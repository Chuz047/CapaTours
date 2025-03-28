using System.Net.Http.Headers;

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
    }
}
