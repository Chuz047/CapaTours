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
    public class ReservasClienteController : ControllerBase
    {
        private readonly IConfiguration _configuration;

        public ReservasClienteController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        [HttpPost("ReservarTour")]
        public IActionResult ReservarTour([FromBody] ReservaModel model)
        {
            try
            {
                using (var connection = new SqlConnection(_configuration.GetConnectionString("BDConnection")))
                {
                    var parametros = new DynamicParameters();
                    parametros.Add("@UsuarioID", model.UsuarioID);
                    parametros.Add("@TourID", model.TourID);
                    parametros.Add("@CantidadPersonas", model.CantidadPersonas);

                    connection.Execute("CrearReservaTour", parametros, commandType: CommandType.StoredProcedure);

                    return Ok(new { mensaje = "Reserva creada correctamente" });
                }
            }
            catch (SqlException ex)
            {
                return BadRequest(new { mensaje = ex.Message });
            }
        }

        [HttpGet("ListadoCliente")]
        public IActionResult ListadoCliente([FromQuery] long usuarioID)
        {
            try
            {
                using (var connection = new SqlConnection(_configuration.GetConnectionString("BDConnection")))
                {
                    var reservas = connection.Query<ReservaModel>(
                        "ObtenerReservasPorUsuario",
                        new { UsuarioID = usuarioID },
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

        [HttpGet]
        [Route("PagarReserva")]
        public IActionResult PagarReserva(long ReservaID)
        {
            using (var context = new SqlConnection(_configuration.GetSection("ConnectionStrings:BDConnection").Value))
            {
                var result = context.QueryFirstOrDefault<ReservaModel>("ConsultarReserva", new { ReservaID });

                var respuesta = new RespuestaModel();

                if (result != null)
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

        [HttpPost]
        [Route("PagarReserva")]
        public IActionResult PagarReserva(PagoModel model)
        {
            using (var context = new SqlConnection(_configuration.GetSection("ConnectionStrings:BDConnection").Value))
            {
                var result = context.Execute("PagarReserva",
                new { model.ReservaID, model.Comprobante, model.Monto, model.CantidadPersonas});

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

    }
}

