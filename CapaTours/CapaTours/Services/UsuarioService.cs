using CapaTours.Models;
using System.Net.Http;
using System.Text.Json;

namespace CapaTours.Services
{
    public class UsuarioService
    {
        private readonly IHttpClientFactory _httpClientFactory;
        private readonly IConfiguration _configuration;

        public UsuarioService(IHttpClientFactory httpClientFactory, IConfiguration configuration)
        {
            _httpClientFactory = httpClientFactory;
            _configuration = configuration;
        }

        public async Task<UsuarioModel?> ObtenerUsuarioPorCorreoAsync(string correo)
        {
            var cliente = _httpClientFactory.CreateClient();
            var url = _configuration.GetSection("Variables:urlApi").Value + $"Autenticacion/ObtenerUsuarioPorCorreo/{correo}";

            var response = await cliente.GetAsync(url);
            if (!response.IsSuccessStatusCode)
                return null;

            var contenido = await response.Content.ReadAsStringAsync();

            return JsonSerializer.Deserialize<UsuarioModel>(contenido, new JsonSerializerOptions
            {
                PropertyNameCaseInsensitive = true
            });
        }
    }
}

