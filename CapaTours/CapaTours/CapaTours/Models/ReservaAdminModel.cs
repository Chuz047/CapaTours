﻿namespace CapaTours.Models
{
    public class ReservaAdminModel
    {
        public long ReservaID { get; set; }
        public string NombreTour { get; set; }
        public string Cliente { get; set; }
        public string Identificacion { get; set; }
        public int CantidadPersonas { get; set; }
        public string Estado { get; set; }
        public DateTime? FechaComprobante { get; set; }
        public decimal? MontoComprobante { get; set; }
        public string? Comprobante { get; set; }

    }


}



