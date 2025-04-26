namespace CapaTours.Models
{
    public class TourModel
    {
        public long TourID { get; set; }          
        public string? Nombre { get; set; }     
        public string? Destino { get; set; }     
        public string? Descripcion { get; set; }  
        public string? Itinerario { get; set; }  
        public decimal Precio { get; set; }  
        public int Capacidad { get; set; }      
        public DateTime? FechaInicio { get; set; } 
        public DateTime? FechaFin { get; set; }    
        public bool Estado { get; set; }        
        public decimal? Descuento { get; set; } 
        public string? Imagen { get; set; }


        // Lista de Reseñas
        public List<ResennaModel>? Resennas { get; set; }
    }
}