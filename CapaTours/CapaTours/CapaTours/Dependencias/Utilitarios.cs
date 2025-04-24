using System.Net.Http.Headers;
using Microsoft.AspNetCore.Http.Features;

namespace CapaTours.Dependencias
{
    public class Utilitarios : IUtilitarios
    {
        private readonly IHttpClientFactory _httpClient;
        private readonly IConfiguration _configuration;
        private readonly IHttpContextAccessor _accessor;
        public Utilitarios(IHttpClientFactory httpClient, IConfiguration configuration, IHttpContextAccessor accessor)
        {
            _httpClient = httpClient;
            _configuration = configuration;
            _accessor = accessor;
        }

        public HttpResponseMessage ConsultarToursAdmin(long TourID)
        {
            using (var api = _httpClient.CreateClient())
            {
                var url = _configuration.GetSection("Variables:urlApi").Value + "Tours/ListadoAdmin?TourID=" + TourID;

                api.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", _accessor.HttpContext!.Session.GetString("Token"));

                var response = api.GetAsync(url).Result;

                return response;
            }
        }
        public HttpResponseMessage ConsultarClientesAdmin(long UsuarioID)
        {
            using (var api = _httpClient.CreateClient())
            {
                var url = _configuration.GetSection("Variables:urlApi").Value + "Clientes/ListadoAdmin?Id=" + UsuarioID;

                api.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", _accessor.HttpContext!.Session.GetString("Token"));

                var response = api.GetAsync(url).Result;

                return response;
            }
        }

        // Que es esto???
        public HttpResponseMessage ConsultarInfoEstados()
        {
            using (var api = _httpClient.CreateClient())
            {
                var url = _configuration.GetSection("Variables:urlApi").Value + "Ofertas/ConsultarEstados";

                api.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", _accessor.HttpContext!.Session.GetString("Token"));
                var response = api.GetAsync(url).Result;

                return response;
            }
        }

        //public HttpResponseMessage ConsultarReservaCliente(long ReservaID)
        //{
        //    using (var api = _httpClient.CreateClient())
        //    {
        //        var url = _configuration.GetSection("Variables:urlApi").Value + "Clientes/PagarReserva?Id=" + ReservaID;

        //        api.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", _accessor.HttpContext!.Session.GetString("Token"));

        //        var response = api.GetAsync(url).Result;

        //        return response;
        //    }
        //}
    }
}
