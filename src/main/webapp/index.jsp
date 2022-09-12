<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Prime Sort</title>
    <link rel="shortcut icon" type="image/png" href="favicon.png"/>
    <!--Podpięcie pliku stylu Bootstrap oraz dodatkowych czcionek-->
    <link href="lib/bootstrap.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,100;0,300;0,400;0,700;0,900;1,100;1,300;1,400;1,700;1,900&display=swap" rel="stylesheet">
    <!--Własny plik CSS-->
    <link href="styles/style.css" rel="stylesheet">
</head>
<body>
    <header>
        <nav class="navbar navbar-dark bg-c-blue navbar-expand-lg">
            <div id="header" class="container-fluid">
                <a class="navbar-brand ms-2 ms-lg-5" href="#"><img src="img/logo.png" class="d-inline-block me-2 mb-2" width="40" height="40" alt=""/>Prime Sort</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainMenu">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="mainMenu">
                    <ul class="navbar-nav text-end text-lg-start text-justify-center ms-3">
                        <li class="nav-item dropdown"><a class="nav-link dropdown-toggle mx-2" href="#" role="button" data-bs-toggle="dropdown">Wizualizacja</a>
                            <ul id="mainMenuDropdown" class="dropdown-menu dropdown-menu-primary ms-auto text-center text-lg-start">
                                <li><a class="dropdown-item" href="sortowanie_babelkowe">Sortowanie bąbelkowe</a></li>
                                <li><a class="dropdown-item" href="sortowanie_przez_wstawianie">Sortowanie przez wstawianie</a></li>
                                <li><a class="dropdown-item" href="sortowanie_przez_wybor">Sortowanie przez wybór</a></li>
                                <li><a class="dropdown-item" href="sortowanie_przez_scalanie">Sortowanie przez scalanie</a></li>
                                <li><a class="dropdown-item" href="sortowanie_szybkie">Sortowanie szybkie</a></li>
                            </ul>
                        </li>
                        <li class="nav-item"><a class="nav-link mx-2" href="bazawiedzy/sortowanie">Baza wiedzy</a></li>
                        <li class="nav-item"><a class="nav-link mx-2" href="testy">Testy</a></li>
                    </ul>
                    <hr class="d-lg-hidden"/>
                    <c:choose>
                        <c:when test="${sessionScope.loggedAs!=null}">
                            <ul class="navbar-nav ms-auto text-end text-lg-start">
                                <li class="nav-item"><a class="nav-link" href="#"><svg class="bi mb-1" width="1.5rem" height="1.5rem" fill="currentColor"><use xlink:href="icons/bootstrap-icons.svg#person-fill"/></svg> ${sessionScope.loggedName}</a></li>
                                <li class="nav-item"><a class="nav-link" href="logout"><svg class="bi mb-1" width="1.5rem" height="1.5rem" fill="currentColor"><use xlink:href="icons/bootstrap-icons.svg#box-arrow-left"/></svg> Wyloguj się</a></li>
                            </ul>
                        </c:when>
                        <c:otherwise>
                            <ul class="navbar-nav ms-auto text-end text-lg-start">
                                <li class="nav-item dropdown"><a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"><svg class="bi mb-1" width="1.5rem" height="1.5rem" fill="currentColor"><use xlink:href="icons/bootstrap-icons.svg#box-arrow-in-right"/></svg> Zaloguj się</a>
                                    <form name="loginForm" action="login" method="post" class="dropdown-menu dropdown-menu-primary p-3 ms-auto" style="width: 300px;">
                                        <input type="hidden" name="headedTo" value="<%=request.getRequestURI()%>">
                                        <div class="mb-3 form-floating">
                                            <input id="input-email" name="email" class="form-control" placeholder="E-mail" type="email" autocomplete="off">
                                            <label for="input-email" class="form-label">E-mail</label>
                                            <div class="text-start text-danger small ms-1 mt-1"></div>
                                        </div>
                                        <div class="mb-3 form-floating">
                                            <input id="input-password" name="password" class="form-control" placeholder="Hasło" type="password" autocomplete="off">
                                            <label for="input-password" class="form-label form-floating">Hasło</label>
                                            <div class="text-start text-danger small ms-1 mt-1"></div>
                                        </div>
                                        <div class="text-end"><button type="submit" class="btn scriptbtn btn-primary">Zaloguj</button></div>
                                        <hr/>
                                        <span>Nie masz jeszcze konta?<br/><a class="link-primary text-decoration-none" href="rejestracja">Zarejestruj się!</a></span>
                                    </form>
                                </li>
                                <li class="nav-item"><a class="nav-link" href="rejestracja"><svg class="bi mb-1" width="1.5rem" height="1.5rem" fill="currentColor"><use xlink:href="icons/bootstrap-icons.svg#person-plus"/></svg> Zarejestruj się</a></li>
                            </ul>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </nav>
    </header>

    <main>
        <div id="main" class="container-fluid bg-c-white text-black">
            <div class="row justify-content-center py-5">
                <div class="col-12 col-md-2 my-auto d-flex justify-content-center justify-content-md-end">
                    <img src="img/logo-adv.png" alt="logo-adv" class="d-inline-block" width="300" height="300">
                </div>
                <div class="col-12 col-md-4 ps-3 pt-4 text-center text-md-start">
                    <p class="display-4">Przywitaj się z Prime Sort!</p>
                    <p class="h3">Prime Sort to centrum wiedzy o algorytmach sortujących. To tutaj nauczysz się o ich działaniu, zastosowaniu oraz zobaczysz ich pracę od wewnątrz.</p>
                </div>
            </div>
            <hr/>
            <div id="mainpagecontent">

                <div class="row my-5 mx-auto justify-content-center border border-2 border-custom rounded shadow">
                    <div class="col-12 col-md-7 order-2 order-md-1 pb-5 pt-3 pt-md-5 ps-md-5 my-auto text-center text-md-start">
                        <h2 class="">Sprawdź działanie algorytmu sortującego</h2>
                        <hr/>
                        <p class="h5 c-grey mb-4">Zobacz najpopularniejsze algorytmy sortujące w działaniu oraz dowiedz się o wykonywanych przez nie procesach w czasie rzeczywistym.<br/>
                            Podaj algorytmowi dane, a ten pokaże ci jak je sortuje krok po kroku wybraną metodą.</p>
                        <a href="/primesort/sortowanie_babelkowe" type="button" class="btn scriptbtn btn-primary">Przejdź</a>
                    </div>
                    <div class="col-12 col-md-5 order-1 order-md-2 my-auto py-3">
                        <img src="img/picture1-e.jpg" alt="pic1" class="img-fluid rounded"/>
                    </div>
                </div>

                <div class="row my-5 mx-auto justify-content-center border border-2 border-custom rounded shadow">
                    <div class="col-12 col-md-7 order-2 pb-5 pt-3 pt-md-5 ps-md-5 my-auto text-center text-md-start">
                        <h2 class="">Dowiedz się więcej o algorytmach sortujących</h2>
                        <hr/>
                        <p class="h5 c-grey mb-4">Przejrzyj naszą bazę wiedzy na temat algorytmów sortujących. Dowiedz się o ich zastosowaniu, efektywności i optymalności,
                            przeczytaj o zastosowanych metodach i zobacz strukturę algorytmu.</p>
                        <a href="bazawiedzy/sortowanie" type="button" class="btn scriptbtn btn-primary">Przejdź</a>
                    </div>
                    <div class="col-12 col-md-5 order-1 my-auto py-3">
                        <img src="img/picture2-e.jpg" alt="pic2" class="img-fluid rounded"/>
                    </div>
                </div>

                <div class="row my-5 mx-auto justify-content-center border border-2 border-custom rounded shadow">
                    <div class="col-12 col-md-7 order-2 order-md-1 pb-5 pt-3 pt-md-5 ps-md-5 my-auto text-center text-md-start">
                        <h2 class="">Sprawdź swoją wiedzę na temat struktury algorytmów sortujących</h2>
                        <hr/>
                        <p class="h5 c-grey mb-4">Przekonaj się czy potrafisz wykorzystać zdobytą wiedzę o algorytmach sortujących w praktyce i czy rozumiesz w pełni ich działanie. Uzupełniaj testy
                            i sprawdzaj swoje postępy.</p>
                        <a href="testy" type="button" class="btn scriptbtn btn-primary">Przejdź</a>
                    </div>
                    <div class="col-12 col-md-5 order-1 order-md-2 my-auto py-3">
                        <img src="img/picture3-e.jpg" alt="pic3" class="img-fluid rounded"/>
                    </div>
                </div>

            </div>
        </div>
    </main>
    
    <!--Podpięcie plików skryptowych JQuery oraz Bootstrap-->
    <script src="lib/jquery-3.6.0.min.js"></script>
    <script src="lib/jquery.validate.min.js"></script>
    <script src="lib/bootstrap.bundle.min.js"></script>
    <!--Własny plik JavaScript-->
    <script src="scripts/script.js"></script>
    <script src="scripts/form-validation.js"></script>
</body>
</html>