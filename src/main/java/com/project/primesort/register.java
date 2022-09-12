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

@WebServlet(name = "register", value = "/register")
public class register extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String sql1 = "SELECT email FROM uzytkownik WHERE email = '"+email+"';";
        Dbcon con1 = new Dbcon();
        con1.query(sql1);
        try {
            if(con1.rs.next()){
                out.print("Użytkownik o takim adresie e-mail już istnieje<br/>");
                request.setAttribute("msg", "Użytkownik o takim adresie e-mail już istnieje.");
                request.setAttribute("color", "text-danger");
                request.getRequestDispatcher("rejestracja").forward(request, response);
            }
            else{
                sql1 = "INSERT INTO uzytkownik (nazwa, email, haslo) VALUES ('"+name+"', '"+email+"', MD5('"+password+"'))";
                int i = con1.update(sql1);
                if(i==1){
                    System.out.print("Pomyślnie dodano użytkownika");
                    System.out.println("Pomyślnie dodano użytkownika");
                    request.setAttribute("msg", "Pomyślnie zarejestrowano. Zaloguj się aby kontynuować.");
                    request.setAttribute("color", "text-success");
                    request.getRequestDispatcher("logowanie").forward(request, response);
                }
                else if(i<1){
                    System.out.print("Nie udało się dodać użytkownika");
                    request.setAttribute("msg", "Nie udało się zarejestrować. Spróbuj ponownie później.");
                    request.setAttribute("color", "text-danger");
                    request.getRequestDispatcher("rejestracja").forward(request, response);
                }
                else{
                    System.out.print("Z jakiegoś powodu dodano więcej niż 1 użytkownika");
                    request.setAttribute("msg", "Z jakiegoś powodu dodano więcej niż 1 użytkownika");
                    request.setAttribute("color", "text-danger");
                    request.getRequestDispatcher("logowanie").forward(request, response);
                }

            }
            con1.close();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }



    }
}
