<%@ page import="com.project.primesort.Dbcon" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.io.FileWriter" %>
<%@ page import="com.mysql.cj.x.protobuf.MysqlxDatatypes" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Prime Sort</title>
    <link rel="shortcut icon" type="image/png" href="../favicon.png"/>
    <!--Podpięcie pliku stylu Bootstrap oraz dodatkowych czcionek-->
    <link href="../lib/bootstrap.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,100;0,300;0,400;0,700;0,900;1,100;1,300;1,400;1,700;1,900&display=swap" rel="stylesheet">
    <!--Własny plik CSS-->
    <link href="../styles/style.css" rel="stylesheet">
</head>
<body>
<c:choose>
    <c:when test="${sessionScope.loggedAs!=null}">
        <%
            String selected = request.getParameter("answers");
            String[] selectedArr = selected.split(",");

            String generateorder = request.getParameter("generateorder");
            String[] generateArr = generateorder.split(",");

            int ilosc = generateArr.length;
            int iloscpoprawnych = 0;

            StringBuilder sql = new StringBuilder();
            sql.append("SELECT * FROM pytania WHERE id_kategorii=2 && id_pytania IN (");
            for(int i=0;i<ilosc;i++){
                sql.append(generateArr[i]);
                if(i<ilosc-1) sql.append(", ");
            }
            sql.append(") ORDER BY CASE id_pytania");
            for(int i=0;i<ilosc;i++){
                sql.append(" WHEN "+generateArr[i]+" THEN "+i);
            }
            sql.append(" END");

            Dbcon con = new Dbcon();
            con.query(sql.toString());

            for(int i=0;con.rs.next();i++){
                String correctAns = con.rs.getString("poprawna");
                String selectedAns = selectedArr[i].substring(3);
                if(correctAns.equals(selectedAns)) iloscpoprawnych++;
            }
            con.rs.beforeFirst();

            Dbcon con2 = new Dbcon();
            StringBuilder sql2 = new StringBuilder();
            sql2.append("SELECT * FROM postepy WHERE id_uzytkownika = "+(session.getAttribute("loggedId"))+" AND id_kategorii = 2;");

            con2.query(sql2.toString());
            sql2.setLength(0);
            if(con2.rs.next()){
                sql2.append("UPDATE postepy SET ilosc_poprawnych = "+(iloscpoprawnych)+" WHERE id_uzytkownika = "+(session.getAttribute("loggedId"))+" AND id_kategorii = 2;");
                con2.update(sql2.toString());
            }
            else{
                sql2.append("INSERT INTO postepy (id_uzytkownika, id_kategorii, ilosc_poprawnych) VALUES ("+session.getAttribute("loggedId")+", 2, "+iloscpoprawnych+");");
                con2.update(sql2.toString());
            }
            con2.close();
        %>
        <header>
            <nav class="navbar navbar-dark bg-c-blue navbar-expand-lg">
                <div id="header" class="container-fluid">
                    <a class="navbar-brand ms-2 ms-lg-5" href="../"><img src="../img/logo.png" class="d-inline-block me-2 mb-2" width="40" height="40" alt=""/>Prime Sort</a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainMenu">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="mainMenu">
                        <ul class="navbar-nav text-end text-lg-start text-justify-center ms-3">
                            <li class="nav-item dropdown"><a class="nav-link dropdown-toggle mx-2" href="#" role="button" data-bs-toggle="dropdown">Wizualizacja</a>
                                <ul id="mainMenuDropdown" class="dropdown-menu dropdown-menu-primary ms-auto text-center text-lg-start">
                                    <li><a class="dropdown-item" href="../sortowanie_babelkowe">Sortowanie bąbelkowe</a></li>
                                    <li><a class="dropdown-item" href="../sortowanie_przez_wstawianie">Sortowanie przez wstawianie</a></li>
                                    <li><a class="dropdown-item" href="../sortowanie_przez_wybor">Sortowanie przez wybór</a></li>
                                    <li><a class="dropdown-item" href="../sortowanie_przez_scalanie">Sortowanie przez scalanie</a></li>
                                    <li><a class="dropdown-item" href="../sortowanie_szybkie">Sortowanie szybkie</a></li>
                                </ul>
                            </li>
                            <li class="nav-item"><a class="nav-link mx-2" href="../bazawiedzy/sortowanie">Baza wiedzy</a></li>
                            <li class="nav-item"><a class="nav-link mx-2" href="../testy">Testy</a></li>
                        </ul>
                        <hr class="d-lg-hidden"/>
                        <ul class="navbar-nav ms-auto text-end text-lg-start">
                            <li class="nav-item"><a class="nav-link" href="#"><svg class="bi mb-1" width="1.5rem" height="1.5rem" fill="currentColor"><use xlink:href="../icons/bootstrap-icons.svg#person-fill"/></svg> ${sessionScope.loggedName}</a></li>
                            <li class="nav-item"><a class="nav-link" href="../logout"><svg class="bi mb-1" width="1.5rem" height="1.5rem" fill="currentColor"><use xlink:href="../icons/bootstrap-icons.svg#box-arrow-left"/></svg> Wyloguj się</a></li>
                        </ul>
                    </div>
                </div>
            </nav>
        </header>

        <main class="bg-c-lightblue">
            <div class="row justify-content-center">
                <div id="testheader" class="col-12 col-sm-10 col-md-8 col-xl-6 col-xxl-5">
                    <div class="h1 text-center pt-5">Wyniki - Algorytmy sortujące</div>
                    <div class="h3 mt-5">Podsumowanie:</div>
                    <table class="table">
                        <tbody>
                        <tr>
                            <th class="w-50">Ilość pytań:</th>
                            <td class="text-center"><%=ilosc%></td>
                        </tr>
                        <tr>
                            <th>Poprawne:</th>
                            <td class="text-center"><%=iloscpoprawnych%></td>
                        <tr>
                            <th>Błędne:</th>
                            <td class="text-center"><%=ilosc-iloscpoprawnych%></td>
                        </tr>
                        <tr>
                            <th>Procent:</th>
                            <td colspan="2">
                                <div class="progress mx-auto" style="height: 25px">
                                    <div class="progress-bar progress-bar-striped progress-bar-animated bg-success" role="progressbar" value="<%=iloscpoprawnych%>" style="width: <%=((double)iloscpoprawnych/(double)ilosc)*100%>%"><%=(double)Math.round((double)iloscpoprawnych/(double)ilosc*1000)/10%>%</div>
                                    <div class="progress-bar bg-danger" role="progressbar" value="<%=(ilosc-iloscpoprawnych)%>" style="width: <%=(100-((double)iloscpoprawnych/(double)ilosc)*100)%>%"><%=100-(double)Math.round((double)iloscpoprawnych/(double)ilosc*1000)/10%>%</div>
                                </div>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="row g-0 justify-content-center pb-5">
                <div id="testarea" class="col-10 col-sm-8 col-md-6 col-xl-5 col-xxl-4">
                    <%
                        StringBuilder html = new StringBuilder();
                        for(int i=1;i<=ilosc;i++){
                            try {
                                if(con.rs.next()){
                                    html.append("<div id='question"+i+"' class='testbox mt-5 p-3 rounded-3' value='odp"+con.rs.getString("poprawna")+"' data-selected='"+selectedArr[i-1]+"'>\n");
                                    html.append("<div class='questionbox fs-5 rounded-3 p-2 bg-c-white px-2 shadow-sm'><strong>"+i+". </strong>"+con.rs.getString("tresc")+"</div>\n");
                                    html.append("<div class='resultbox p-2 text-white rounded mt-3 text-center'></div>");
                                    html.append("<div class='odpA row answerbox my-3 rounded-3 shadow-sm g-0' value='odpA'><div class='answerletter rounded-3 col-2 col-md-1 fw-bold text-white d-flex align-items-center justify-content-center fs-5'>A</div><div class='col-10 col-md-11 p-2'>"+con.rs.getString("odpa")+"</div></div>\n");
                                    html.append("<div class='odpB row answerbox my-3 rounded-3 shadow-sm g-0' value='odpB'><div class='answerletter rounded-3 col-2 col-md-1 fw-bold text-white d-flex align-items-center justify-content-center fs-5'>B</div><div class='col-10 col-md-11 p-2'>"+con.rs.getString("odpb")+"</div></div>\n");
                                    html.append("<div class='odpC row answerbox my-3 rounded-3 shadow-sm g-0' value='odpC'><div class='answerletter rounded-3 col-2 col-md-1 fw-bold text-white d-flex align-items-center justify-content-center fs-5'>C</div><div class='col-10 col-md-11 p-2'>"+con.rs.getString("odpc")+"</div></div>\n");
                                    html.append("<div class='odpD row answerbox my-3 rounded-3 shadow-sm g-0' value='odpD'><div class='answerletter rounded-3 col-2 col-md-1 fw-bold text-white d-flex align-items-center justify-content-center fs-5'>D</div><div class='col-10 col-md-11 p-2'>"+con.rs.getString("odpd")+"</div></div>\n");
                                    html.append("<div class='explanationbox border rounded-3 bg-c-white p-3'><strong>Wyjaśnienie:</strong><br/>"+con.rs.getString("wyjasnienie")+"</div>");
                                    html.append("</div>");
                                }
                            } catch (SQLException throwables) {
                                throwables.printStackTrace();
                            }
                        }
                        out.println(html.toString());
                    %>

                    <div class='text-end mt-5'>
                        <a href='../testy/algorytmy_sortujace' class='btn btn-lg btn-primary me-2'>Spróbuj ponownie</a>
                        <a href='../testy' class='btn btn-lg btn-light border border-secondary text-secondary'>Wybór testów</a>
                    </div>
                </div>
            </div>
        </main>

        <%
            con.close();
        %>
    </c:when>
    <c:otherwise>
        <%
            request.setAttribute("headedTo", request.getRequestURI());
            request.getRequestDispatcher("../logowanie").forward(request, response);
        %>
    </c:otherwise>
</c:choose>
<!--Podpięcie plików skryptowych JQuery oraz Bootstrap-->
<script src="../lib/jquery-3.6.0.min.js"></script>
<script src="../lib/bootstrap.bundle.min.js"></script>
<script src="../lib/d3.v7.min.js"></script>
<!--Własny plik JavaScript-->
<script src="../scripts/script.js"></script>
<script src="../scripts/quiz_review.js"></script>
</body>
</html>
