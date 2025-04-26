using CapaToursAPI.Models;
using Dapper;

using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using System.Data;

namespace CapaToursAPI.Controllers.Admin
{
    [ApiController]
    [Route("api/[controller]")]
    public class ReservasController : ControllerBase
    {
        private readonly IConfiguration _configuration;

        public ReservasController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        [HttpGet("ListadoAdmin")]
        public IActionResult ListadoAdmin()
        {
            using (var connection = new SqlConnection(_configuration.GetConnectionString("BDConnection")))
            {
                var result = connection.Query<ReservaAdminModel>(
                    "ObtenerReservasAdmin",
                    commandType: CommandType.StoredProcedure
                ).ToList();

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
                    respuesta.Mensaje = "No hay reservas registradas en este momento.";
                }

                return Ok(respuesta);
            }
        }

        [HttpGet("AnularReserva")]
        public IActionResult AnularReserva([FromQuery] long reservaID)
        {
            try
            {
                using (var connection = new SqlConnection(_configuration.GetConnectionString("BDConnection")))
                {
                    var resultado = connection.Execute(
                        "AnularReserva",
                        new { ReservaID = reservaID },
                        commandType: CommandType.StoredProcedure
                    );

                    return Ok(new RespuestaModel
                    {
                        Indicador = true,
                        Mensaje = "Reserva cancelada correctamente."
                    });
                }
            }
            catch (Exception ex)
            {
                return BadRequest(new RespuestaModel
                {
                    Indicador = false,
                    Mensaje = "Error al cancelar reserva: " + ex.Message
                });
            }
        }

    }
}

