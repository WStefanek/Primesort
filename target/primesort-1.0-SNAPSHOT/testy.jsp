<%@ page import="com.project.primesort.Dbcon" %>
<%@ page import="java.util.ArrayList" %>
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
    <link href="styles/style.css" rel="stylesheet">
</head>
<body>
<c:choose>
    <c:when test="${sessionScope.loggedAs!=null}">
        <header>
            <nav class="navbar navbar-dark bg-c-blue navbar-expand-lg">
                <div id="header" class="container-fluid">
                    <a class="navbar-brand ms-2 ms-lg-5" href="/"><img src="img/logo.png" class="d-inline-block me-2 mb-2" width="40" height="40" alt=""/>Prime Sort</a>
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
                            <li class="nav-item"><a class="nav-link mx-2" href="bazawiedzy/sortowanie">Baza wiedzy</a></li>
                            <li class="nav-item"><a class="nav-link mx-2" href="testy">Testy</a></li>
                        </ul>
                        <hr class="d-lg-hidden"/>
                        <ul class="navbar-nav ms-auto text-end text-lg-start">
                            <li class="nav-item"><a class="nav-link" href="#"><svg class="bi mb-1" width="1.5rem" height="1.5rem" fill="currentColor"><use xlink:href="icons/bootstrap-icons.svg#person-fill"/></svg> ${sessionScope.loggedName}</a></li>
                            <li class="nav-item"><a class="nav-link" href="logout"><svg class="bi mb-1" width="1.5rem" height="1.5rem" fill="currentColor"><use xlink:href="icons/bootstrap-icons.svg#box-arrow-left"/></svg> Wyloguj się</a></li>
                        </ul>
                    </div>
                </div>
            </nav>
        </header>

        <main>
            <%
                Dbcon con = new Dbcon();
                StringBuilder sql = new StringBuilder();
                sql.append("SELECT * FROM postepy WHERE id_uzytkownika = "+session.getAttribute("loggedId")+";");
                con.query(sql.toString());

                Dbcon con2 = new Dbcon();
                sql.setLength(0);
                sql.append("SELECT id_kategorii, nazwa FROM `kategorie_pytan`;");
                con2.query(sql.toString());
                ArrayList<String> catList = new ArrayList<String>();
                ArrayList<Integer> qCount = new ArrayList<Integer>();
                while(con2.rs.next()){
                    catList.add(con2.rs.getString("nazwa"));
                    qCount.add(10);
                }
                int[] progressArr = new int[catList.size()];
                for(int i=0;i<catList.size();i++){
                    progressArr[i]=-1;
                }
                while(con.rs.next()){
                    progressArr[con.rs.getInt("id_kategorii")-1] = con.rs.getInt("ilosc_poprawnych");
                }
                con.close();
                con2.close();
                StringBuilder html = new StringBuilder();
            %>
            <div id="main" class="container-fluid bg-c-white text-black">
                <div class="row justify-content-center py-5">
                    <div class="col-12 col-md-10 col-lg-9 col-xl-8 col-xxl-7">
                        <div class="p-4 mb-4 border border-2 border-custom rounded shadow">
                            <p class="h2">Podstawy sortowania</p>
                            <hr/>
                            <div class="row">
                                <div class="col-7">
                                    <p class="h5 c-grey mb-4">Odpowiedz na pytania związane z podstawami sortowania.</p>
                                    <a href="testy/podstawy_sortowania" type="button" class="btn scriptbtn btn-primary">Przejdź</a>
                                </div>
                                <div class="col-5 text-end">
                                    <%
                                        html.setLength(0);
                                        html.append("<div class='h4'>Twój wynik</div>\n");
                                        if(progressArr[0]<0){
                                            html.append("<div class='h5 fst-italic'>Nie ukończono testu.</div>\n");
                                            html.append("<div class='progress w-100' style='height: 20px'>\n");
                                            html.append("<div class='progress-bar' role='progressbar' value='0' style='background-color: #e3e3e3; width: 100%'></div>");
                                            html.append("</div>");
                                        }
                                        else{
                                            html.append("<div class='h5 fst-italic'>Poprawne odpowiedzi: "+progressArr[0]+"/"+qCount.get(0)+"</div>\n");
                                            html.append("<div class='progress w-100' style='height: 20px'>\n");
                                            html.append("<div class='progress-bar   bg-success' role='progressbar' value='"+progressArr[0]+"' style='width: "+(((double)progressArr[0]/(double)qCount.get(0))*100)+"%'>"+((double)Math.round((double)progressArr[0]/(double)qCount.get(0)*1000)/10)+"%</div>");
                                            html.append("<div class='progress-bar bg-danger' role='progressbar' value='"+(qCount.get(0)-progressArr[0])+"' style='background-color: #e3e3e3; width: "+(100-((double)progressArr[0]/(double)qCount.get(0))*100)+"%'>"+(100-((double)Math.round((double)progressArr[0]/(double)qCount.get(0)*1000)/10))+"%</div>");
                                            html.append("</div>");
                                        }
                                        out.println(html.toString());
                                    %>
                                </div>
                            </div>
                        </div>
                        <div class="p-4 my-5 border border-2 border-custom rounded shadow">
                            <p class="h2">Algorytmy sortujące</p>
                            <hr/>
                            <div class="row">
                                <div class="col-7">
                                    <p class="h5 c-grey mb-4">Odpowiedz na pytania związane z algorytmami sortującymi.</p>
                                    <a href="testy/algorytmy_sortujace" type="button" class="btn scriptbtn btn-primary">Przejdź</a>
                                </div>
                                <div class="col-5 text-end">
                                    <%
                                        html.setLength(0);
                                        html.append("<div class='h4'>Twój wynik</div>\n");
                                        if(progressArr[1]<0){
                                            html.append("<div class='h5 fst-italic'>Nie ukończono testu.</div>\n");
                                            html.append("<div class='progress w-100' style='height: 20px'>\n");
                                            html.append("<div class='progress-bar' role='progressbar' value='0' style='background-color: #e3e3e3; width: 100%'></div>");
                                            html.append("</div>");
                                        }
                                        else{
                                            html.append("<div class='h5 fst-italic'>Poprawne odpowiedzi: "+progressArr[1]+"/"+qCount.get(1)+"</div>\n");
                                            html.append("<div class='progress w-100' style='height: 20px'>\n");
                                            html.append("<div class='progress-bar   bg-success' role='progressbar' value='"+progressArr[1]+"' style='width: "+(((double)progressArr[1]/(double)qCount.get(1))*100)+"%'>"+((double)Math.round((double)progressArr[1]/(double)qCount.get(1)*1000)/10)+"%</div>");
                                            html.append("<div class='progress-bar bg-danger' role='progressbar' value='"+(qCount.get(1)-progressArr[1])+"' style='background-color: #e3e3e3; width: "+(100-((double)progressArr[1]/(double)qCount.get(1))*100)+"%'>"+(100-((double)Math.round((double)progressArr[1]/(double)qCount.get(1)*1000)/10))+"%</div>");
                                            html.append("</div>");
                                        }
                                        out.println(html.toString());
                                    %>
                                </div>
                            </div>
                        </div>
                        <div class="p-4 my-5 border border-2 border-custom rounded shadow">
                            <p class="h2">Sortowanie bąbelkowe</p>
                            <hr/>
                            <div class="row">
                                <div class="col-7">
                                    <p class="h5 c-grey mb-4">Odpowiedz na pytania związane z Sortowaniem bąbelkowym.</p>
                                    <a href="testy/sortowanie_babelkowe" type="button" class="btn scriptbtn btn-primary">Przejdź</a>
                                </div>
                                <div class="col-5 text-end">
                                    <%
                                        html.setLength(0);
                                        html.append("<div class='h4'>Twój wynik</div>\n");
                                        if(progressArr[2]<0){
                                            html.append("<div class='h5 fst-italic'>Nie ukończono testu.</div>\n");
                                            html.append("<div class='progress w-100' style='height: 20px'>\n");
                                            html.append("<div class='progress-bar' role='progressbar' value='0' style='background-color: #e3e3e3; width: 100%'></div>");
                                            html.append("</div>");
                                        }
                                        else{
                                            html.append("<div class='h5 fst-italic'>Poprawne odpowiedzi: "+progressArr[2]+"/"+qCount.get(2)+"</div>\n");
                                            html.append("<div class='progress w-100' style='height: 20px'>\n");
                                            html.append("<div class='progress-bar   bg-success' role='progressbar' value='"+progressArr[2]+"' style='width: "+(((double)progressArr[2]/(double)qCount.get(2))*100)+"%'>"+((double)Math.round((double)progressArr[2]/(double)qCount.get(2)*1000)/10)+"%</div>");
                                            html.append("<div class='progress-bar bg-danger' role='progressbar' value='"+(qCount.get(2)-progressArr[2])+"' style='background-color: #e3e3e3; width: "+(100-((double)progressArr[2]/(double)qCount.get(2))*100)+"%'>"+(100-((double)Math.round((double)progressArr[2]/(double)qCount.get(2)*1000)/10))+"%</div>");
                                            html.append("</div>");
                                        }
                                        out.println(html.toString());
                                    %>
                                </div>
                            </div>
                        </div>
                        <div class="p-4 my-5 border border-2 border-custom rounded shadow">
                            <p class="h2">Sortowanie przez wstawianie</p>
                            <hr/>
                            <div class="row">
                                <div class="col-7">
                                    <p class="h5 c-grey mb-4">Odpowiedz na pytania związane z Sortowaniem przez wstawianie.</p>
                                    <a href="testy/sortowanie_przez_wstawianie" type="button" class="btn scriptbtn btn-primary">Przejdź</a>
                                </div>
                                <div class="col-5 text-end">
                                    <%
                                        html.setLength(0);
                                        html.append("<div class='h4'>Twój wynik</div>\n");
                                        if(progressArr[3]<0){
                                            html.append("<div class='h5 fst-italic'>Nie ukończono testu.</div>\n");
                                            html.append("<div class='progress w-100' style='height: 20px'>\n");
                                            html.append("<div class='progress-bar' role='progressbar' value='0' style='background-color: #e3e3e3; width: 100%'></div>");
                                            html.append("</div>");
                                        }
                                        else{
                                            html.append("<div class='h5 fst-italic'>Poprawne odpowiedzi: "+progressArr[3]+"/"+qCount.get(3)+"</div>\n");
                                            html.append("<div class='progress w-100' style='height: 20px'>\n");
                                            html.append("<div class='progress-bar   bg-success' role='progressbar' value='"+progressArr[3]+"' style='width: "+(((double)progressArr[3]/(double)qCount.get(3))*100)+"%'>"+((double)Math.round((double)progressArr[3]/(double)qCount.get(3)*1000)/10)+"%</div>");
                                            html.append("<div class='progress-bar bg-danger' role='progressbar' value='"+(qCount.get(3)-progressArr[3])+"' style='background-color: #e3e3e3; width: "+(100-((double)progressArr[3]/(double)qCount.get(3))*100)+"%'>"+(100-((double)Math.round((double)progressArr[3]/(double)qCount.get(3)*1000)/10))+"%</div>");
                                            html.append("</div>");
                                        }
                                        out.println(html.toString());
                                    %>
                                </div>
                            </div>
                        </div>
                        <div class="p-4 my-5 border border-2 border-custom rounded shadow">
                            <p class="h2">Sortowanie przez wybór</p>
                            <hr/>
                            <div class="row">
                                <div class="col-7">
                                    <p class="h5 c-grey mb-4">Odpowiedz na pytania związane z Sortowaniem przez wybór.</p>
                                    <a href="testy/sortowanie_przez_wybor" type="button" class="btn scriptbtn btn-primary">Przejdź</a>
                                </div>
                                <div class="col-5 text-end">
                                    <%
                                        html.setLength(0);
                                        html.append("<div class='h4'>Twój wynik</div>\n");
                                        if(progressArr[4]<0){
                                            html.append("<div class='h5 fst-italic'>Nie ukończono testu.</div>\n");
                                            html.append("<div class='progress w-100' style='height: 20px'>\n");
                                            html.append("<div class='progress-bar' role='progressbar' value='0' style='background-color: #e3e3e3; width: 100%'></div>");
                                            html.append("</div>");
                                        }
                                        else{
                                            html.append("<div class='h5 fst-italic'>Poprawne odpowiedzi: "+progressArr[4]+"/"+qCount.get(4)+"</div>\n");
                                            html.append("<div class='progress w-100' style='height: 20px'>\n");
                                            html.append("<div class='progress-bar   bg-success' role='progressbar' value='"+progressArr[4]+"' style='width: "+(((double)progressArr[4]/(double)qCount.get(4))*100)+"%'>"+((double)Math.round((double)progressArr[4]/(double)qCount.get(4)*1000)/10)+"%</div>");
                                            html.append("<div class='progress-bar bg-danger' role='progressbar' value='"+(qCount.get(4)-progressArr[4])+"' style='background-color: #e3e3e3; width: "+(100-((double)progressArr[4]/(double)qCount.get(4))*100)+"%'>"+(100-((double)Math.round((double)progressArr[4]/(double)qCount.get(4)*1000)/10))+"%</div>");
                                            html.append("</div>");
                                        }
                                        out.println(html.toString());
                                    %>
                                </div>
                            </div>
                        </div>
                        <div class="p-4 my-5 border border-2 border-custom rounded shadow">
                            <p class="h2">Sortowanie przez scalanie</p>
                            <hr/>
                            <div class="row">
                                <div class="col-7">
                                    <p class="h5 c-grey mb-4">Odpowiedz na pytania związane z Sortowaniem przez scalanie.</p>
                                    <a href="testy/sortowanie_przez_scalanie" type="button" class="btn scriptbtn btn-primary">Przejdź</a>
                                </div>
                                <div class="col-5 text-end">
                                    <%
                                        html.setLength(0);
                                        html.append("<div class='h4'>Twój wynik</div>\n");
                                        if(progressArr[5]<0){
                                            html.append("<div class='h5 fst-italic'>Nie ukończono testu.</div>\n");
                                            html.append("<div class='progress w-100' style='height: 20px'>\n");
                                            html.append("<div class='progress-bar' role='progressbar' value='0' style='background-color: #e3e3e3; width: 100%'></div>");
                                            html.append("</div>");
                                        }
                                        else{
                                            html.append("<div class='h5 fst-italic'>Poprawne odpowiedzi: "+progressArr[5]+"/"+qCount.get(5)+"</div>\n");
                                            html.append("<div class='progress w-100' style='height: 20px'>\n");
                                            html.append("<div class='progress-bar   bg-success' role='progressbar' value='"+progressArr[5]+"' style='width: "+(((double)progressArr[5]/(double)qCount.get(5))*100)+"%'>"+((double)Math.round((double)progressArr[5]/(double)qCount.get(5)*1000)/10)+"%</div>");
                                            html.append("<div class='progress-bar bg-danger' role='progressbar' value='"+(qCount.get(5)-progressArr[5])+"' style='background-color: #e3e3e3; width: "+(100-((double)progressArr[5]/(double)qCount.get(5))*100)+"%'>"+(100-((double)Math.round((double)progressArr[5]/(double)qCount.get(5)*1000)/10))+"%</div>");
                                            html.append("</div>");
                                        }
                                        out.println(html.toString());
                                    %>
                                </div>
                            </div>
                        </div>
                        <div class="p-4 mt-5 border border-2 border-custom rounded shadow">
                            <p class="h2">Sortowanie szybkie</p>
                            <hr/>
                            <div class="row">
                                <div class="col-7">
                                    <p class="h5 c-grey mb-4">Odpowiedz na pytania związane z Sortowaniem szybkim.</p>
                                    <a href="testy/sortowanie_szybkie" type="button" class="btn scriptbtn btn-primary">Przejdź</a>
                                </div>
                                <div class="col-5 text-end">
                                    <%
                                        html.setLength(0);
                                        html.append("<div class='h4'>Twój wynik</div>\n");
                                        if(progressArr[6]<0){
                                            html.append("<div class='h5 fst-italic'>Nie ukończono testu.</div>\n");
                                            html.append("<div class='progress w-100' style='height: 20px'>\n");
                                            html.append("<div class='progress-bar' role='progressbar' value='0' style='background-color: #e3e3e3; width: 100%'></div>");
                                            html.append("</div>");
                                        }
                                        else{
                                            html.append("<div class='h5 fst-italic'>Poprawne odpowiedzi: "+progressArr[6]+"/"+qCount.get(6)+"</div>\n");
                                            html.append("<div class='progress w-100' style='height: 20px'>\n");
                                            html.append("<div class='progress-bar   bg-success' role='progressbar' value='"+progressArr[6]+"' style='width: "+(((double)progressArr[6]/(double)qCount.get(6))*100)+"%'>"+((double)Math.round((double)progressArr[6]/(double)qCount.get(6)*1000)/10)+"%</div>");
                                            html.append("<div class='progress-bar bg-danger' role='progressbar' value='"+(qCount.get(6)-progressArr[6])+"' style='background-color: #e3e3e3; width: "+(100-((double)progressArr[6]/(double)qCount.get(6))*100)+"%'>"+(100-((double)Math.round((double)progressArr[6]/(double)qCount.get(6)*1000)/10))+"%</div>");
                                            html.append("</div>");
                                        }
                                        out.println(html.toString());
                                    %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <!--Podpięcie plików skryptowych JQuery oraz Bootstrap-->
        <script src="../lib/jquery-3.6.0.min.js"></script>
        <script src="../lib/bootstrap.bundle.min.js"></script>
        <!--Własny plik JavaScript-->
        <script src="scripts/script.js"></script>
    </c:when>
    <c:otherwise>
        <%
            request.setAttribute("headedTo", request.getRequestURI());
            request.getRequestDispatcher("logowanie").forward(request, response);
        %>
    </c:otherwise>
</c:choose>


</body>
</html>
