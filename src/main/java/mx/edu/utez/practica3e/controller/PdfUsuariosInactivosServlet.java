package mx.edu.utez.practica3e.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;

import java.io.*;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.practica3e.utils.DatabaseConnectionManager;
import net.sf.jasperreports.engine.JasperRunManager;


@WebServlet(name = "PdfUsuariosInactivosServlet", value = "/pdf")
public class PdfUsuariosInactivosServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //Seleccinar una imagen de los assets (logo)
        String archivo = "/img/logo.PNG";
        File file2 = new File(getServletContext().getRealPath(archivo));
        FileInputStream input2 = new FileInputStream(file2);
        //Obtener ubicación y bytes del reporte
        String report = "/WEB-INF/UsuariosSISOC.jasper";
        File file = new File(getServletContext().getRealPath(report));
        InputStream input = new FileInputStream(file);
        //Colocar los parametros del reporte
        Map mapa = new HashMap();
        mapa.put("logo", input2);
        //obtener una coneccion a los datos
        Connection con = null;
        try { con = DatabaseConnectionManager.getConnection();}
        catch (SQLException e) { throw new RuntimeException(e);}
        resp.setContentType("application/pdf"); //Establecer el tipo de respuesta
        resp.setHeader("Content-Disposition", "Attachment; filename=reporte.pdf"); //esto es para forzar la descarga del archivo
//Generar el reporte
        try {
            byte[] bytes = JasperRunManager. runReportToPdf(input, mapa, con);
            OutputStream os = resp.getOutputStream();
            os.write(bytes);
            os.flush();
            os.close();
        } catch (Exception e) { System.out.println(e.getMessage());}
    }

}
