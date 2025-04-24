using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using CapaToursAPI.Models;
using Dapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.IdentityModel.Tokens;

namespace CapaToursAPI.Controllers
{
    [AllowAnonymous]
    [Route("api/[controller]")]
    [ApiController]
    public class AutenticacionController : ControllerBase
    {
        private readonly IConfiguration _configuration;

        public AutenticacionController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        #region Registro

        [HttpPost]
        [Route("Registro")]
        public IActionResult Registro(UsuarioModel model)
        {
            using (var context = new SqlConnection(_configuration.GetSection("ConnectionStrings:BDConnection").Value))
            {
                var result = context.Execute("Registro",
                    new { model.Identificacion, model.Nombre, model.ApellidoPaterno, model.ApellidoMaterno, model.Correo, model.Contrasenna });

                var respuesta = new RespuestaModel();

                if (result > 0)
                {
                    respuesta.Indicador = true;
                    respuesta.Mensaje = "Su información se ha registrado correctamente";
                }
                else
                {
                    respuesta.Indicador = false;
                    respuesta.Mensaje = "Su información no se ha registrado correctamente";
                }

                return Ok(respuesta);
            }
        }

        #endregion

        #region Login

        [HttpPost]
        [Route("Login")]
        public IActionResult Login(UsuarioModel model)
        {
            using (var context = new SqlConnection(_configuration.GetSection("ConnectionStrings:BDConnection").Value))
            {
                var result = context.QueryFirstOrDefault<UsuarioModel>("Login",
                 new { model.Correo, model.Contrasenna });


                var respuesta = new RespuestaModel();

                if (result != null)
                {
                    result.Token = GenerarToken(result.UsuarioID, result.RolID);

                    respuesta.Indicador = true;
                    respuesta.Mensaje = "Su información se ha validado correctamente";
                    respuesta.Datos = result;
                }
                else
                {
                    respuesta.Indicador = false;
                    respuesta.Mensaje = "Su información no se ha validado correctamente";
                }

                return Ok(respuesta);
            }
        }

        #endregion

        [HttpGet("ObtenerUsuarioPorCorreo/{correo}")]
        public IActionResult ObtenerUsuarioPorCorreo(string correo)
        {
            using (var context = new SqlConnection(_configuration.GetSection("ConnectionStrings:BDConnection").Value))
            {
                var result = context.QueryFirstOrDefault<UsuarioModel>("ObtenerUsuarioCompleto", new { correo }, commandType: System.Data.CommandType.StoredProcedure);

                if (result == null)
                    return NotFound();

                return Ok(result);
            }
        }

        [HttpPost("EnviarRecuperacion")]
        public IActionResult EnviarRecuperacion([FromBody] string correo)
        {
            try
            {
                using (var context = new SqlConnection(_configuration.GetConnectionString("BDConnection")))
                {
                    // ✅ Usamos el procedimiento almacenado
                    var usuario = context.QueryFirstOrDefault<UsuarioModel>(
                        "ObtenerUsuarioPorCorreo",
                        new { correo },
                        commandType: System.Data.CommandType.StoredProcedure);

                    if (usuario == null)
                        return NotFound(new { mensaje = "El correo no está registrado.", correo });

                    var codigo = Guid.NewGuid().ToString("N").Substring(0, 6).ToUpper();

                    var asunto = "Recuperación de Contraseña - CapaTours";
                    var cuerpo = $"Hola {usuario.Nombre},\n\nTu código de recuperación es: {codigo}\n\n";

                    var enviado = UtilidadesCorreo.EnviarCorreo(correo, asunto, cuerpo);

                    if (enviado)
                    {
                        return Ok(new { mensaje = "Correo enviado correctamente", codigo });
                    }
                    else
                    {
                        return StatusCode(500, new { mensaje = "No se pudo enviar el correo desde el servidor SMTP" });
                    }
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new
                {
                    mensaje = "Error interno",
                    error = ex.Message,
                    stack = ex.StackTrace
                });
            }
        }




        [HttpPut("RestablecerContrasenna")]
        public IActionResult RestablecerContrasenna([FromBody] UsuarioModel model)
        {
            using (var context = new SqlConnection(_configuration.GetConnectionString("BDConnection")))
            {
                // Ejecutar el procedimiento almacenado
                var result = context.Execute("RestablecerContrasenna",
                    new { model.Correo, model.Contrasenna },
                    commandType: System.Data.CommandType.StoredProcedure);

                if (result > 0)
                    return Ok(new { mensaje = "Contraseña actualizada correctamente" });

                return BadRequest(new { mensaje = "No se pudo actualizar la contraseña" });
            }
        }





        #region Otros Métodos
        private string GenerarToken(long UsuarioID, long RolID)
        {
            string? SecretKey = _configuration.GetSection("Variables:llaveCifrado").Value!;

            if (string.IsNullOrEmpty(SecretKey))
            {
                throw new InvalidOperationException("La llave del token no está configurada correctamente.");
            }

            List<Claim> claims = new List<Claim>();
            claims.Add(new Claim("UsuarioID", UsuarioID.ToString()));
            claims.Add(new Claim("RolID", RolID.ToString()));

            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(SecretKey));
            var cred = new SigningCredentials(key, SecurityAlgorithms.HmacSha256Signature);

            var token = new JwtSecurityToken(
                claims: claims,
                expires: DateTime.UtcNow.AddMinutes(20),
                signingCredentials: cred);

            return new JwtSecurityTokenHandler().WriteToken(token);
        }

        #endregion
    }
}

