package com.project.primesort;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URI;
import java.net.URISyntaxException;
import java.sql.SQLException;

import com.project.primesort.Dbcon;

@WebServlet(name = "login", value = "/login")
public class login extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        String callerpageURL = request.getHeader("Referer");
        String headedTo = request.getParameter("headedTo");

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String sql = "SELECT * FROM uzytkownik WHERE email = '"+email+"' && haslo = MD5('"+password+"')";
        Dbcon con = new Dbcon();
        con.query(sql);
        try {
            if(con.rs.next()){
                out.print("Znaleziono użytkownika");
                HttpSession session = request.getSession();
                session.setMaxInactiveInterval(60*60);
                session.setAttribute("loggedId", con.rs.getString("id"));
                session.setAttribute("loggedAs", con.rs.getString("email"));
                session.setAttribute("loggedName", con.rs.getString("nazwa"));
                response.sendRedirect(headedTo);
            }
            else{
                out.print("Brak użytkownika o takim loginie i haśle");
                request.setAttribute("msg", "Brak użytkownika o takim e-mailu i haśle");
                request.setAttribute("color", "text-danger");
                request.setAttribute("headedTo", headedTo);
                request.getRequestDispatcher("logowanie").forward(request, response);
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }

        con.close();
    }
}
