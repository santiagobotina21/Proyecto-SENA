package vista;

import controlador.PreparatorioControlador;
import controlador.PreparatorioDAO;

public class Main {

    public static void main(String[] args) {
        PreparatorioDAO dao = new PreparatorioDAO();
        PreparatorioVista vista = new PreparatorioVista();
        PreparatorioControlador controlador = new PreparatorioControlador(dao, vista);
        controlador.iniciar();
    }
}