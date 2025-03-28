using CapaTours.Models;
using CapaToursAPI.Models;
using Dapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;

namespace CapaToursAPI.Controllers
{
    [AllowAnonymous]
    [Route("api/[controller]")]
    [ApiController]
    public class ClientesController : Controller
    {
        private readonly IConfiguration _configuration;

        public ClientesController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        #region ListadoAdmin

        [HttpGet]
        [Route("ListadoAdmin")]
        public IActionResult ConsultarClientes(long UsuarioID)
        {
            using (var context = new SqlConnection(_configuration.GetSection("ConnectionStrings:BDConnection").Value))
            {
                var result = context.Query<UsuarioModel>("ConsultarClientes",
                    new { UsuarioID });

                var respuesta = new RespuestaModel();

                if (result.Any())
                {
                    respuesta.Indicador = true;
                    respuesta.Mensaje = "Información consultada";
                    respuesta.Datos = result;
                }
                else
                {
                    respuesta.Indicador = false;
                    respuesta.Mensaje = "No hay información registrada en este momento";
                }

                return Ok(respuesta);
            }
        }

        #endregion
        [HttpPut]
        [Route("DesactivarUsuario")]
        public IActionResult DesactivarUsuario([FromBody] long usuarioID)
        {
            using (var connection = new SqlConnection(_configuration.GetSection("ConnectionStrings:BDConnection").Value))
            {
                var result = connection.Execute("DesactivarUsuario", new { UsuarioID = usuarioID });

                var respuesta = new RespuestaModel();

                if (result > 0)
                {
                    respuesta.Indicador = true;
                    respuesta.Mensaje = "Usuario desactivado correctamente.";
                }
                else
                {
                    respuesta.Indicador = false;
                    respuesta.Mensaje = "No se pudo desactivar el usuario.";
                }

                return Ok(respuesta);
            }
        }
        [HttpPut]
        [Route("ActivarUsuario")]
        public IActionResult ActivarUsuario([FromBody] long usuarioID)
        {
            using (var connection = new SqlConnection(_configuration.GetSection("ConnectionStrings:BDConnection").Value))
            {
                var result = connection.Execute("ActivarUsuario", new { UsuarioID = usuarioID });

                var respuesta = new RespuestaModel();

                if (result > 0)
                {
                    respuesta.Indicador = true;
                    respuesta.Mensaje = "Usuario activado correctamente.";
                }
                else
                {
                    respuesta.Indicador = false;
                    respuesta.Mensaje = "No se pudo activar el usuario.";
                }

                return Ok(respuesta);
            }
        }


    }
}
