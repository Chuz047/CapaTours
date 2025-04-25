
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
        [Route("ListarPorTour")]
        public IActionResult ListarPorTour(long tourID)
        {
            try
            {
                using var connection = new SqlConnection(_configuration.GetConnectionString("BDConnection"));
                var resennas = connection.Query<ResennaModel>(
                    "ListarResennasPorTour",
                    new { TourID = tourID },
                    commandType: CommandType.StoredProcedure
                ).ToList();

                return Ok(resennas);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { mensaje = "Error al obtener reseñas", detalle = ex.Message });
            }
        }
    }
}
