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
                                    <form method="post" action="login" class="dropdown-menu dropdown-menu-primary p-3 ms-auto" style="width: 300px;">
                                        <input type="hidden" name="headedTo" value="<%=request.getRequestURI()%>">
                                        <h4 class="mb-4">Zaloguj się</h4>
                                        <div class="mb-3 form-floating">
                                            <input id="input-email" name="email" class="form-control" placeholder="E-mail" type="email" autocomplete="off">
                                            <label for="input-email" class="form-label">E-mail</label>
                                        </div>
                                        <div class="mb-3 form-floating">
                                            <input id="input-password" name="password" class="form-control" placeholder="Hasło" type="password" autocomplete="off">
                                            <label for="input-password" class="form-label form-floating">Hasło</label>
                                        </div>
                                        <button type="submit" class="btn btn-primary mb-3">Zaloguj</button>
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
        <div style="height: 21rem">
            <div id="svgdiv" class="overflow-auto">
                <svg id="can-vis" class="d-block mx-auto" width="500" height="21rem" xmlns="http://www.w3.org/2000/svg">
                </svg>
            </div>
        </div>
    </main>

    <footer>
        <div class="container-fluid fixed-bottom bottom-0 p-0">
            <div id="sortinglog" class="collapse navbar-collapse text-center mx-0">
                <div class="row g-0 mx-0">
                    <div id="logdiv" class="col-12 col-md-6 col-xl-4 bg-c-blue mx-0 g-0">
                        <textarea id="textlog" class="form-control d-inline-block mx-2 mt-2" rows="5" style="resize: none; font-size: 1.3rem" readonly></textarea>
                    </div>
                </div>
            </div>
            <div class="row min-vh-30 bg-c-blue">
                <div class="mx-auto text-light text-center">
                    <div class="row d-flex align-items-center">
                        <div class="col-5 col-sm-3 text-start navbar navbar-dark d-flex justify-content-start">
                            <button class="navbar-toggler ms-1" type="button" data-bs-toggle="collapse" data-bs-target="#sortingoptions">
                                <svg class="bi text-light" width="2rem" height="2rem" fill="currentColor"><use xlink:href="icons/bootstrap-icons.svg#gear"/></svg>
                            </button>
                            <button class="navbar-toggler ms-1" type="button" data-bs-toggle="collapse" data-bs-target="#sortinglog">
                                <svg class="bi text-light" width="2rem" height="2rem" fill="currentColor"><use xlink:href="icons/bootstrap-icons.svg#journal-text"/></svg>
                            </button>
                        </div>
                        <div class="col-2 col-sm-2 col-md-1 text-end g-0">
                            <button id="playbtn" class="btn btn-sm"><svg class="bi mb-1 text-light pt-1" width="3rem" height="3rem" fill="currentColor"><use id="playicon" xlink:href="icons/bootstrap-icons.svg#play-btn"/></svg></button>
                        </div>
                        <div class="col-5 col-sm-7 g-0 text-start">
                            <input type="range" class="form-range pt-2" id="progressbar" disabled value="0" min="0" step="1">
                        </div>
                    </div>
                </div>
                <div id="sortingoptions" class="collapse navbar-collapse px-5">
                    <hr class="divider mx-auto"/>
                    <div class="row">
                        <div class="col-12 pt-3 mb-2 text-light">
                            <div class="row">
                                <div class="col-2 col-sm-2 col-md-1 col-xl-1 text-end mb-2">
                                    Dane:
                                </div>
                                <div class="col-10 col-sm-6 col-md-4 col-xl-2 text-start mb-2">
                                    <input id="dataset" class="w-100" type="text" value="">
                                </div>
                                <div class="col-12 col-sm-8 col-md-7 col-xl-8 text-end text-md-start">
                                    <button id="generate-btn" class="btn-sm btn-primary">Generuj</button>
                                    <button id="random-btn" class="btn-sm btn-primary">Losowe dane</button>
                                    <button id="sort-btn" class="btn-sm btn-primary" value="insertionsort">Sortuj</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12 mb-2 text-light">
                            <div class="row">
                                <div class="col-12 col-sm-2 col-md-1 text-start text-md-end">
                                    Prędkość:
                                </div>
                                <div class="col-8 col-sm-6 col-md-4 col-xl-2">
                                    <svg class="bi mb-1 mb-3" width="1rem" height="1rem" fill="currentColor"><use xlink:href="icons/bootstrap-icons.svg#chevron-up"/></svg>
                                    <input type="range" class="form-range p-0 w-75" id="speedslider" min="250" max="2000" value="1125"/>
                                    <svg class="bi mb-1 mb-3" width="1rem" height="1rem" fill="currentColor"><use xlink:href="icons/bootstrap-icons.svg#chevron-double-up"/></svg>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    
    <!--Podpięcie plików skryptowych JQuery oraz Bootstrap-->
    <script src="../lib/jquery-3.6.0.min.js"></script>
    <script src="../lib/bootstrap.bundle.min.js"></script>
    <script src="../lib/d3.v7.min.js"></script>
    <!--Własny plik JavaScript-->
    <script src="scripts/script.js"></script>
    <script src="scripts/insertionsort_control.js"></script>
</body>
</html>