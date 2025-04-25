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
            try
            {
                using (var connection = new SqlConnection(_configuration.GetConnectionString("BDConnection")))
                {
                    var reservas = connection.Query<ReservaAdminModel>(
                        "ObtenerReservasAdmin",
                        commandType: CommandType.StoredProcedure
                    ).ToList();

                    return Ok(new RespuestaModel
                    {
                        Indicador = true,
                        Mensaje = "Reservas cargadas correctamente.",
                        Datos = reservas
                    });
                }
            }
            catch (Exception ex)
            {
                return BadRequest(new RespuestaModel
                {
                    Indicador = false,
                    Mensaje = "Error al obtener reservas: " + ex.Message
                });
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

