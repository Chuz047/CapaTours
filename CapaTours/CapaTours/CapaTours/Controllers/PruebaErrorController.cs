using Microsoft.AspNetCore.Mvc;
using System.Data;
using Microsoft.Data.SqlClient;
using Dapper;

namespace CapaTours.Controllers
{
    public class PruebaErrorController : Controller
    {
        private readonly string _connectionString;

        public PruebaErrorController(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("BDConnection");
        }

        public IActionResult CapturarError()
        {
            try
            {
                // Simulación de error
                throw new Exception("Error generado intencionalmente para prueba.");
            }
            catch (Exception ex)
            {
                RegistrarError(1, ex.Message, nameof(PruebaErrorController));
                return View("Error");
            }
        }

        private void RegistrarError(long usuarioId, string mensaje, string origen)
        {
            using var connection = new SqlConnection(_connectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@UsuarioID", usuarioId, DbType.Int64);
            parametros.Add("@Mensaje", mensaje, DbType.String);
            parametros.Add("@Origen", origen, DbType.String);

            connection.Execute("RegistrarError", parametros, commandType: CommandType.StoredProcedure);
        }
    }
}
