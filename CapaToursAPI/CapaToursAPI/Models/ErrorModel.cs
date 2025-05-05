namespace CapaToursAPI.Models
{
    public class ErrorModel
    {
        public long UsuarioID { get; set; }
        public string Mensaje { get; set; } = string.Empty;
        public string Origen { get; set; } = string.Empty;
    }
}
