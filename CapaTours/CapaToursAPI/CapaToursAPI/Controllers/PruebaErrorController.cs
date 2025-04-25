using Microsoft.AspNetCore.Mvc;
using System.Data;
using Microsoft.Data.SqlClient;
using Dapper;

namespace CapaToursAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PruebaErrorController : ControllerBase
    {
        private readonly string? _connectionString;

        public PruebaErrorController(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("BDConnection");
        }

        [HttpPost("CapturarError")]
        public IActionResult CapturarError([FromBody] ErrorRequest error)
        {
            try
            {
                using var connection = new SqlConnection(_connectionString);
                var parametros = new DynamicParameters();
                parametros.Add("@UsuarioID", error.UsuarioID, DbType.Int64);
                parametros.Add("@Mensaje", error.Mensaje, DbType.String);
                parametros.Add("@Origen", error.Origen, DbType.String);

                connection.Execute("RegistrarError", parametros, commandType: CommandType.StoredProcedure);

                return Ok(new { mensaje = "Error registrado correctamente en la BD" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { mensaje = "Error al registrar en la base de datos", detalle = ex.Message });
            }
        }
    }

    public class ErrorRequest
    {
        public long UsuarioID { get; set; }
        public string Mensaje { get; set; } = string.Empty;
        public string Origen { get; set; } = string.Empty;
    }
}
