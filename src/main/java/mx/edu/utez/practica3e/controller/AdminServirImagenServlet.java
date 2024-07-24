package mx.edu.utez.practica3e.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import mx.edu.utez.practica3e.utils.DatabaseConnectionManager;

@WebServlet(name = "AdminServirImagenServlet", value = "/image")
public class AdminServirImagenServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sku = request.getParameter("sku");
        if (sku == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing SKU parameter");
            return;
        }

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DatabaseConnectionManager.getConnection();
            String query = "SELECT imagen FROM producto WHERE sku = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, sku);
            rs = ps.executeQuery();

            if (rs.next()) {
                byte[] imgData = rs.getBytes("imagen");
                response.setContentType("image/jpeg");
                OutputStream out = response.getOutputStream();
                out.write(imgData);
                out.flush();
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Image not found for SKU: " + sku);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (ps != null) ps.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}
