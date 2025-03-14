using Microsoft.AspNetCore.Mvc;

namespace CapaTours.Controllers
{
    public class HomeController : Controller
    {
        public IActionResult Home()
        {
            return View();
        }
    }
}
