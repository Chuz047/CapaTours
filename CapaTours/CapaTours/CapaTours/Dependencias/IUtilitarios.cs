namespace CapaTours.Dependencias
{
    public interface IUtilitarios
    {
        HttpResponseMessage ConsultarToursAdmin(long TourID);
        HttpResponseMessage ConsultarClientesAdmin(long TourID);
        //HttpResponseMessage ConsultarReservaCliente(long TourID);
        HttpResponseMessage ConsultarInfoEstados();
    }
}
