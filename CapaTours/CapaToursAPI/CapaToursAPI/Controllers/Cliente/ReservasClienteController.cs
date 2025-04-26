using System.Data;
using CapaToursAPI.Models;
using Dapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;

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

        #region ReservarTour

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

        #endregion

        #region Listado

        [HttpGet("ListadoCliente")]
        public IActionResult ListadoCliente([FromQuery] long usuarioID)
        {
            using (var connection = new SqlConnection(_configuration.GetConnectionString("BDConnection")))
            {
                var reservas = connection.Query<ReservaModel>(
                    "ObtenerReservasPorUsuario",
                    new { UsuarioID = usuarioID },
                    commandType: CommandType.StoredProcedure
                ).ToList();

                var respuesta = new RespuestaModel();

                if (reservas.Any())
                {
                    respuesta.Indicador = true;
                    respuesta.Mensaje = "Información consultada";
                    respuesta.Datos = reservas;
                }
                else
                {
                    respuesta.Indicador = false;
                    respuesta.Mensaje = "No hay reservas registradas en este momento.";
                }

                return Ok(respuesta);
            }
        }

        #endregion

        #region PagarReserva

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
                new { model.ReservaID, model.Comprobante, model.Monto, model.CantidadPersonas });

                var respuesta = new RespuestaModel();

                if (result > 0)
                {
                    var asunto = "Confirmación de Pago - CapaTours";

                    var cuerpo = $@"
Estimado/a {model.Nombre},

Le confirmamos que hemos recibido correctamente su pago para el tour '{model.NombreTour}'.

Detalles de su transacción:
- Fecha de Reserva: {DateTime.Now:dd/MM/yyyy}
- Número de Reserva: {model.ReservaID}
- Cantidad de Personas: {model.CantidadPersonas}
- Monto Pagado: ₡{model.Monto:N2}

Puede contactarnos si requiere asistencia o desea modificar su reserva.

¡Gracias por confiar en CapaTours!

Atentamente,
Equipo de CapaTours
";

                    UtilidadesCorreo.EnviarCorreo(model.Correo, asunto, cuerpo);

                    respuesta.Indicador = true;
                    respuesta.Mensaje = "Su pago ha sido procesado y se ha enviado una confirmación a su correo.";
                }
                else
                {
                    respuesta.Indicador = false;
                    respuesta.Mensaje = "No se pudo procesar el pago. Intente nuevamente más tarde.";
                }

                return Ok(respuesta);
            }
        }

        #endregion

        #region AnularReserva

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

        #endregion

    }
}

