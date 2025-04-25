using CapaTours.Models;
using CapaToursAPI.Models;
using Dapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System.Data;
namespace CapaToursAPI.Controllers.Cliente
{
    [Route("api/[controller]")]
    [ApiController]
    public class ResennasClienteController : ControllerBase
    {
        private readonly IConfiguration _configuration;

        public ResennasClienteController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        [HttpPost]
        [Route("CrearResenna")]
        public IActionResult CrearResenna(ResennaModel model)
        {
            var respuesta = new RespuestaModel();

            try
            {
                using (var context = new SqlConnection(_configuration.GetSection("ConnectionStrings:BDConnection").Value))
                {
                    var result = context.Execute("CrearResenna",
                        new
                        {
                            model.UsuarioID,
                            model.TourID,
                            model.ReservaID,
                            model.Calificacion,
                            model.Titulo,
                            model.Contenido
                        });

                    if (result > 0)
                    {
                        respuesta.Indicador = true;
                        respuesta.Mensaje = "Reseña creada exitosamente.";
                    }
                    else
                    {
                        respuesta.Indicador = false;
                        respuesta.Mensaje = "No se pudo crear la reseña. Intente nuevamente más tarde.";
                    }
                }
            }
            catch (Exception ex)
            {
                respuesta.Indicador = false;
                respuesta.Mensaje = "Error al procesar la solicitud: " + ex.Message;
            }

            return Ok(respuesta);
        }

        [HttpGet]
        [Route("ListarPorTour")]
        public IActionResult ListarPorTour(long tourID)
        {
            try
            {
                using var connection = new SqlConnection(_configuration.GetConnectionString("BDConnection"));
                var reseñas = connection.Query<ResennaTourModel>(
                    "ListarResennasPorTour",
                    new { TourID = tourID },
                    commandType: CommandType.StoredProcedure
                ).ToList();

                return Ok(reseñas);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { mensaje = "Error al obtener reseñas", detalle = ex.Message });
            }
        }


    }


}
