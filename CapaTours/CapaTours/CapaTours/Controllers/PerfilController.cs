using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using CapaTours.Models;
using CapaTours.Services;

namespace CapaTours.Controllers
{
    public class PerfilController : Controller
    {
        private readonly UsuarioService _usuarioService;

        public PerfilController(UsuarioService usuarioService)
        {
            _usuarioService = usuarioService;
        }

        #region Vista de Perfil

        public async Task<IActionResult> Index()
        {
            var correo = HttpContext.Session.GetString("Correo");
            var usuario = await _usuarioService.ObtenerUsuarioPorCorreoAsync(correo!);

            if (usuario == null)
                return RedirectToAction("Login", "Autenticacion");

            usuario.Nombre = $"{usuario.Nombre} {usuario.ApellidoPaterno} {usuario.ApellidoMaterno}".Trim();

            return View(usuario);
        }

        #endregion

        #region Otros Métodos
        public override void OnActionExecuting(ActionExecutingContext context)
        {
            if (HttpContext.Session.GetString("Correo") == null)
            {
                context.Result = RedirectToAction("Login", "Autenticacion");
                return;
            }
            base.OnActionExecuting(context);
        }
        #endregion

    }
}
