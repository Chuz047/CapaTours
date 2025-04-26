
using CapaToursAPI.Models;
using Dapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using System.Data;

namespace CapaToursAPI.Controllers.Cliente
{
    [Route("api/[controller]")]
    [ApiController]
    public class ToursClienteController : ControllerBase
    {
        private readonly IConfiguration _configuration;

        public ToursClienteController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        [HttpGet]
        [Route("ListadoCliente")]
        public IActionResult ConsultarToursCliente(long? TourID) 
        {
            using (var context = new SqlConnection(_configuration.GetSection("ConnectionStrings:BDConnection").Value))
            {
                var respuesta = new RespuestaModel();

                if (TourID == null || TourID == 0) 
                {
                    var result = context.Query<TourModel>("ConsultarTours", new { TourID }).ToList(); 
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
                }
                else  
                {
                    var multi = context.QueryMultiple("ConsultarTours", new { TourID }, commandType: CommandType.StoredProcedure);
                    var result = multi.Read<TourModel>().FirstOrDefault(); 

                    if (result != null)
                    {
                        result.Resennas = multi.Read<ResennaModel>().ToList(); 
                        respuesta.Indicador = true;
                        respuesta.Mensaje = "Información consultada";
                        respuesta.Datos = result;
                    }
                    else
                    {
                        respuesta.Indicador = false;
                        respuesta.Mensaje = "No hay información registrada en este momento";
                    }
                }

                return Ok(respuesta);
            }
        }
    }
}
