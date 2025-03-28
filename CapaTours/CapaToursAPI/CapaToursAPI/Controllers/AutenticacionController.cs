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

