using CapaToursAPI.Helpers;
using CapaToursAPI.Models;
using Dapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;

namespace CapaToursAPI.Controllers.Admin
{
    [AllowAnonymous]
    [Route("api/[controller]")]
    [ApiController]
    public class ToursController : ControllerBase
    {
        private readonly IConfiguration _configuration;

        public ToursController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        #region ListadoAdmin

        [HttpGet]
        [Route("ListadoAdmin")]
        public IActionResult ConsultarTours(long TourID)
        {
            using (var context = new SqlConnection(_configuration.GetSection("ConnectionStrings:BDConnection").Value))
            {
                var result = context.Query<TourModel>("ConsultarTours", new { TourID });

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

        #region CrearTour

        [HttpPost]
        [Route("CrearTour")]
        public IActionResult CrearTour(TourModel model)
        {
            using (var context = new SqlConnection(_configuration.GetSection("ConnectionStrings:BDConnection").Value))
            {
                try
                {
                   
                    var result = context.Execute("CrearTourErrorNombre",
                        new
                        {
                            model.Nombre,
                            model.Destino,
                            model.Precio,
                            model.Capacidad,
                            model.FechaInicio,
                            model.FechaFin,
                            model.Descripcion,
                            model.Itinerario
                        });

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
                catch (Exception ex)
                {
                    var usuarioIdStr = HttpContext.Session.GetString("UsuarioID");
                    long.TryParse(usuarioIdStr, out long usuarioId);

                    var connectionString = _configuration.GetSection("ConnectionStrings:BDConnection").Value;
                    UtilidadesErrores.RegistrarError(connectionString, usuarioId, ex.Message, nameof(CrearTour));

                    var respuestaError = new RespuestaModel
                    {
                        Indicador = false,
                        Mensaje = "Ocurrió un error inesperado al procesar su solicitud"
                    };

                    return StatusCode(500, respuestaError);
                }
            }
        }


        #endregion

        #region EditarTour

        [HttpPut]
        [Route("EditarTour")]
        public IActionResult EditarTour(TourModel model)
        {
            using (var context = new SqlConnection(_configuration.GetSection("ConnectionStrings:BDConnection").Value))
            {
                try
                {
                    var result = context.Execute("EditarTour",
                        new
                        {
                            model.TourID,
                            model.Nombre,
                            model.Destino,
                            model.Precio,
                            model.Capacidad,
                            model.FechaInicio,
                            model.FechaFin,
                            model.Descripcion,
                            model.Itinerario
                        });

                    var respuesta = new RespuestaModel();

                    if (result > 0)
                    {
                        respuesta.Indicador = true;
                        respuesta.Mensaje = "Información actualizada";
                    }
                    else
                    {
                        respuesta.Indicador = false;
                        respuesta.Mensaje = "No se actualizó la información correctamente";
                    }

                    return Ok(respuesta);
                }
                catch (Exception ex)
                {
                    long usuarioId = 0; // Sin usar HttpContext.Session

                    var connectionString = _configuration.GetSection("ConnectionStrings:BDConnection").Value;
                    UtilidadesErrores.RegistrarError(connectionString, usuarioId, ex.Message, nameof(EditarTour));

                    var respuestaError = new RespuestaModel
                    {
                        Indicador = false,
                        Mensaje = "Ocurrió un error inesperado al procesar su solicitud"
                    };

                    return StatusCode(500, respuestaError);
                }
            }
        }


        #endregion

        #region DesactivarTour

        [HttpPut]
        [Route("DesactivarTour")]
        public IActionResult DesactivarTour([FromBody] long TourID)
        {
            using (var connection = new SqlConnection(_configuration.GetSection("ConnectionStrings:BDConnection").Value))
            {
                var result = connection.Execute("DesactivarTour", new { TourID });

                var respuesta = new RespuestaModel();

                if (result > 0)
                {
                    respuesta.Indicador = true;
                    respuesta.Mensaje = "Tour desactivado correctamente.";
                }
                else
                {
                    respuesta.Indicador = false;
                    respuesta.Mensaje = "No se pudo desactivar el tour.";
                }

                return Ok(respuesta);
            }
        }

        #endregion

        #region ActivarTour

        [HttpPut]
        [Route("ActivarTour")]
        public IActionResult ActivarTour([FromBody] long TourID)
        {
            using (var connection = new SqlConnection(_configuration.GetSection("ConnectionStrings:BDConnection").Value))
            {
                var result = connection.Execute("ActivarTour", new { TourID });

                var respuesta = new RespuestaModel();

                if (result > 0)
                {
                    respuesta.Indicador = true;
                    respuesta.Mensaje = "Tour activado correctamente.";
                }
                else
                {
                    respuesta.Indicador = false;
                    respuesta.Mensaje = "No se pudo activar el tour.";
                }

                return Ok(respuesta);
            }
        }

        #endregion
    }
}
