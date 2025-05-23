﻿using System.Net.Http.Headers;
using System.Text.Json;
using CapaTours.Dependencias;
using CapaTours.Models;
using Microsoft.AspNetCore.Mvc;

namespace CapaTours.Controllers.Admin
{
    [FiltroSeguridadSesion]
    public class ClientesController : Controller
    {
        private readonly IHttpClientFactory _httpClient;
        private readonly IConfiguration _configuration;
        private readonly IUtilitarios _utilitarios;
        public ClientesController(IHttpClientFactory httpClient, IConfiguration configuration, IUtilitarios utilitarios)
        {
            _httpClient = httpClient;
            _configuration = configuration;
            _utilitarios = utilitarios;
        }

        #region Listado
        [HttpGet]
        public IActionResult ListadoAdmin()
        {
            var response = _utilitarios.ConsultarClientesAdmin(0);

            if (response.IsSuccessStatusCode)
            {
                var result = response.Content.ReadFromJsonAsync<RespuestaModel>().Result;

                if (result != null && result.Indicador)
                {
                    var datosResult = JsonSerializer.Deserialize<List<UsuarioModel>>((JsonElement)result.Datos!);
                    return View(datosResult);
                }
                else
                    ViewBag.Msj = result!.Mensaje;
            }
            else
                ViewBag.Msj = "No se pudo completar su petición";

            return View(new List<UsuarioModel>());
        }

        #endregion Listado

        #region DesactivarUsuario

        [HttpPost]
        public IActionResult DesactivarUsuario(long usuarioID)
        {
            using (var api = _httpClient.CreateClient())
            {
                var url = _configuration.GetSection("Variables:urlApi").Value + "Clientes/DesactivarUsuario";

                api.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", HttpContext.Session.GetString("Token"));
                var result = api.PutAsJsonAsync(url, usuarioID).Result;

                if (result.IsSuccessStatusCode)
                {
                    ViewBag.Mensaje = "El usuario ha sido desactivado correctamente.";
                }
                else
                {
                    ViewBag.Mensaje = "Hubo un error al desactivar el usuario.";
                }
            }

            return RedirectToAction("ListadoAdmin");
        }

        #endregion

        #region ActivarUsuario
        [HttpPost]
        public IActionResult ActivarUsuario(long usuarioID)
        {
            using (var api = _httpClient.CreateClient())
            {
                var url = _configuration.GetSection("Variables:urlApi").Value + "Clientes/ActivarUsuario";

                api.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", HttpContext.Session.GetString("Token"));
                var result = api.PutAsJsonAsync(url, usuarioID).Result;

                if (result.IsSuccessStatusCode)
                {
                    ViewBag.Mensaje = "El usuario ha sido activado correctamente.";
                }
                else
                {
                    ViewBag.Mensaje = "Hubo un error al activar el usuario.";
                }
            }

            return RedirectToAction("ListadoAdmin");
        }

        #endregion
    }
}
