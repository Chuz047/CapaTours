using System.Reflection;
using System.Security.Cryptography;
using System.Text;
using System.Text.Json;
using CapaTours.Models;
using Microsoft.AspNetCore.Mvc;

namespace CapaTours.Controllers
{
    [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
    public class AutenticacionController : Controller
    {
        private readonly IHttpClientFactory _httpClient;
        private readonly IConfiguration _configuration;
        public AutenticacionController(IHttpClientFactory httpClient, IConfiguration configuration)
        {
            _httpClient = httpClient;
            _configuration = configuration;
        }

        #region Registro

        [HttpGet]
        public IActionResult Registro()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Registro(UsuarioModel model)
        { 

        // Encriptación
        model.Contrasenna = Encrypt(model.Contrasenna!);

        
            using (var api = _httpClient.CreateClient())
            {

                var url = _configuration.GetSection("Variables:urlApi").Value + "Autenticacion/Registro";

                var response = api.PostAsJsonAsync(url, model).Result;

                if (response.IsSuccessStatusCode)
                {
                    var result = response.Content.ReadFromJsonAsync<RespuestaModel>().Result;

                    if (result != null && result.Indicador)
                        return RedirectToAction("Login", "Autenticacion");
                    else
                        ViewBag.Msj = result!.Mensaje;
                }
                else
                    ViewBag.Msj = "No se pudo completar su petición";
            }

            return View();
        }

        #endregion

        #region Login

        [HttpGet]
        public IActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Login(UsuarioModel model)
        {
            // Encriptación 
            model.Contrasenna = Encrypt(model.Contrasenna!);

            using (var api = _httpClient.CreateClient())
            {
                var url = _configuration.GetSection("Variables:urlApi").Value + "Autenticacion/Login";
                var response = api.PostAsJsonAsync(url, model).Result;

                if (response.IsSuccessStatusCode)
                {
                    var result = response.Content.ReadFromJsonAsync<RespuestaModel>().Result;

                    if (result != null && result.Indicador)
                    {
                        var datosResult = JsonSerializer.Deserialize<UsuarioModel>((JsonElement)result.Datos!);

                        // Datos de Sesión
                        HttpContext.Session.SetString("Token", datosResult!.Token!);
                        HttpContext.Session.SetString("Correo", datosResult!.Correo!);
                        HttpContext.Session.SetString("RolID", datosResult!.RolID.ToString());

                        if (datosResult.RolID == 1)
                        {
                            return RedirectToAction("ListadoAdmin", "Tours");
                        }
                        else if (datosResult.RolID == 2)
                        {
                            return RedirectToAction("Inicio", "ToursCliente");
                        }

                    }
                    else
                    {
                        ViewBag.Msj = result!.Mensaje;
                    }
                }
                else
                {
                    ViewBag.Msj = "No se pudo completar su petición";
                }
            }

            return View();
        }

        #endregion

        #region CerrarSesion

        [FiltroSeguridadSesion]
        [HttpGet]
        public IActionResult CerrarSesion()
        {
            HttpContext.Session.Clear();
            return RedirectToAction("Login", "Autenticacion");
        }
        #endregion

        #region RecuperarContrasenna
        [HttpGet]
        public IActionResult RecuperarContrasenna()
        {
            return View();
        }
        #endregion

        #region Otros Métodos
        private string Encrypt(string texto)
        {
            byte[] iv = new byte[16];
            byte[] array;

            using (Aes aes = Aes.Create())
            {
                aes.Key = Encoding.UTF8.GetBytes(_configuration.GetSection("Variables:llaveCifrado").Value!);
                aes.IV = iv;

                ICryptoTransform encryptor = aes.CreateEncryptor(aes.Key, aes.IV);

                using (MemoryStream memoryStream = new MemoryStream())
                {
                    using (CryptoStream cryptoStream = new CryptoStream(memoryStream, encryptor, CryptoStreamMode.Write))
                    {
                        using (StreamWriter streamWriter = new StreamWriter(cryptoStream))
                        {
                            streamWriter.Write(texto);
                        }

                        array = memoryStream.ToArray();
                    }
                }
            }

            return Convert.ToBase64String(array);
        }

        public string Decrypt(string texto)
        {
            byte[] iv = new byte[16];
            byte[] buffer = Convert.FromBase64String(texto);

            using (Aes aes = Aes.Create())
            {
                aes.Key = Encoding.UTF8.GetBytes(_configuration.GetSection("Variables:llaveCifrado").Value!);
                aes.IV = iv;

                ICryptoTransform decryptor = aes.CreateDecryptor(aes.Key, aes.IV);

                using (MemoryStream memoryStream = new MemoryStream(buffer))
                {
                    using (CryptoStream cryptoStream = new CryptoStream(memoryStream, decryptor, CryptoStreamMode.Read))
                    {
                        using (StreamReader streamReader = new StreamReader(cryptoStream))
                        {
                            return streamReader.ReadToEnd();
                        }
                    }
                }
            }
        }

        #endregion

    }
}
