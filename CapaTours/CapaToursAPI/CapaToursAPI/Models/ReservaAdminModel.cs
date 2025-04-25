namespace CapaToursAPI.Models
{

    public class ReservaAdminModel
    {
        public long ReservaID { get; set; }
        public string NombreTour { get; set; }
        public string Cliente { get; set; }
        public string Identificacion { get; set; }
        public int CantidadPersonas { get; set; }
        public string Estado { get; set; }

		//Atributos de Pago
		public long PagoID { get; set; }
		public DateTime Fecha { get; set; }
		public string? Comprobante { get; set; }
		public decimal Monto { get; set; }
	}


}




