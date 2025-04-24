namespace CapaTours.Models
{
    public class PagoModel
    {
        public long PagoID { get; set; }
        public long ReservaID { get; set; }
        public DateTime Fecha { get; set; }
        public string? Comprobante { get; set; }
        public decimal Monto { get; set; }
        public int CantidadPersonas { get; set; }

        // Atributos de Tour
        public string? NombreTour { get; set; }
        public DateTime? FechaInicio { get; set; }
        public DateTime? FechaFin { get; set; }
        public decimal Precio { get; set; }
    }
}