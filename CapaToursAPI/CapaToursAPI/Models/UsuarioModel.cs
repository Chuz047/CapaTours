namespace CapaToursAPI.Models
{
    public class UsuarioModel
    {
        public long UsuarioID { get; set; }
        public string? Identificacion { get; set; }
        public string? Nombre { get; set; }
        public string? ApellidoPaterno { get; set; }
        public string? ApellidoMaterno { get; set; }
        public string? Correo { get; set; }
        public string? Contrasenna { get; set; }
        public bool? TieneContrasennaTemp { get; set; }
        public DateTime? FechaVencimientoTemp { get; set; }
        public bool Estado { get; set; }
        public long RolID { get; set; }
        public string? Token { get; set; }
    }
}

