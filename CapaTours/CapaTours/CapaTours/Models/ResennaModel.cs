namespace CapaTours.Models
{
    public class ResennaModel
    {
        public long ResennaID { get; set; }
        public long UsuarioID { get; set; }
        public long ReservaID { get; set; }
        public long TourID { get; set; }
        public int Calificacion { get; set; }
        public string? Titulo { get; set; }
        public string? Contenido { get; set; }
        public string? NombreUsuario { get; set; }
    }
}
