using Dapper;
using Microsoft.Data.SqlClient;
using System.Data;

namespace CapaToursAPI.Helpers
{
    public static class UtilidadesErrores
    {
        public static void RegistrarError(string connectionString, long usuarioId, string mensaje, string origen)
        {
            using var connection = new SqlConnection(connectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@UsuarioID", usuarioId, DbType.Int64);
            parametros.Add("@Mensaje", mensaje, DbType.String);
            parametros.Add("@Origen", origen, DbType.String);

            connection.Execute("RegistrarError", parametros, commandType: CommandType.StoredProcedure);
        }
    }

}
