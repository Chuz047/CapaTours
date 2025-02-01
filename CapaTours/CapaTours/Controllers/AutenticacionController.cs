using Microsoft.AspNetCore.Mvc;

namespace CapaTours.Controllers
{
    public class AutenticacionController : Controller
    {
        public IActionResult Login()
        {
            return View();
        }

        public IActionResult Registro()
        {
            return View();
        }
    }
}
