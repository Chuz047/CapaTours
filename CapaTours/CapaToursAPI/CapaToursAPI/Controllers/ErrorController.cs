using Dapper;
using Microsoft.AspNetCore.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using CapaToursAPI.Models;

namespace CapaToursAPI.Controllers
{
    [ApiExplorerSettings(IgnoreApi = true)]
    [Route("api/[controller]")]
    [ApiController]
    public class ErrorController : ControllerBase
    {
        private readonly IConfiguration _configuration;

        public ErrorController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        [Route("CapturarError")]
        public IActionResult CapturarError()
        {
            var ex = HttpContext.Features.Get<IExceptionHandlerFeature>();

            // Obtener el UsuarioID desde cabecera o sesión
            string usuarioIdStr = HttpContext.Request.Headers["UsuarioID"];
            long.TryParse(usuarioIdStr, out long usuarioID);

            string origen = HttpContext.Request.Headers["Origen"];

            using (var context = new SqlConnection(_configuration.GetSection("ConnectionStrings:BDConnection").Value))
            {
                var Mensaje = ex!.Error.Message;

                context.Execute("RegistrarError",
                    new
                    {
                        UsuarioID = usuarioID,
                        Mensaje,
                        Origen = string.IsNullOrEmpty(origen) ? "Origen no especificado" : origen
                    });
            }

            var respuesta = new RespuestaModel
            {
                Indicador = false,
                Mensaje = "Se presentó un problema en el sistema"
            };

            return BadRequest(respuesta);
        }
    }
}