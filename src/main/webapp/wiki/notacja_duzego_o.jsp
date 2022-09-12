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
    <!--Własne pliki CSS-->
    <link href="../styles/style.css" rel="stylesheet">
    <link href="../styles/sidebar.css" rel="stylesheet">
</head>
<body class="bg-c-white d-flex flex-column min-vh-100">
<header>
    <nav class="navbar navbar-dark bg-c-blue navbar-expand-lg">
        <div id="header" class="container-fluid">
            <a class="navbar-brand ms-2 ms-lg-5" href="/primesort"><img src="../img/logo.png" class="d-inline-block me-2 mb-2" width="40" height="40" alt=""/>Prime Sort</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainMenu" aria-expanded="true">
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
                    <li class="nav-item"><a class="nav-link mx-2" href="../bazawiedzy">Baza wiedzy</a></li>
                    <li class="nav-item"><a class="nav-link mx-2" href="../testy">Testy</a></li>
                </ul>
                <hr class="d-lg-hidden"/>
                <c:choose>
                    <c:when test="${sessionScope.loggedAs!=null}">
                        <ul class="navbar-nav ms-auto text-end text-lg-start">
                            <li class="nav-item"><a class="nav-link" href="#"><svg class="bi mb-1" width="1.5rem" height="1.5rem" fill="currentColor"><use xlink:href="../icons/bootstrap-icons.svg#person-fill"/></svg> ${sessionScope.loggedName}</a></li>
                            <li class="nav-item"><a class="nav-link" href="../logout"><svg class="bi mb-1" width="1.5rem" height="1.5rem" fill="currentColor"><use xlink:href="../icons/bootstrap-icons.svg#box-arrow-left"/></svg> Wyloguj się</a></li>
                        </ul>
                    </c:when>
                    <c:otherwise>
                        <ul class="navbar-nav ms-auto text-end text-lg-start">
                            <li class="nav-item dropdown"><a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"><svg class="bi mb-1" width="1.5rem" height="1.5rem" fill="currentColor"><use xlink:href="../icons/bootstrap-icons.svg#box-arrow-in-right"/></svg> Zaloguj się</a>
                                <form name="loginForm" action="../login" method="post" class="dropdown-menu dropdown-menu-primary p-3 ms-auto" style="width: 300px;">
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
                            <li class="nav-item"><a class="nav-link" href="../rejestracja"><svg class="bi mb-1" width="1.5rem" height="1.5rem" fill="currentColor"><use xlink:href="../icons/bootstrap-icons.svg#person-plus"/></svg> Zarejestruj się</a></li>
                        </ul>
                    </c:otherwise>
                </c:choose>

            </div>
        </div>
    </nav>
</header>

<div class="container-fluid">
    <div class="row">
        <aside class="col-12 col-sm-3 col-xl-2 p-3 order-2 order-sm-1">
            <hr class="d-sm-none"/>
            <nav class="navbar navbar-light navbar-expand" id="sidebar">
                <ul class="navbar-nav flex-column mx-auto mx-sm-0 text-center text-sm-start">
                    <li class="mb-1">
                        <a type="button" class="btn btn-sidebar text-start rounded collapsed" href="./sortowanie">
                            Sortowanie
                        </a>
                    </li>
                    <li class="mb-1">
                        <a type="button" class="btn btn-sidebar text-start rounded collapsed" href="./algorytm_sortujacy">
                        Algorytm sortujący
                        </a>
                    </li>
                    <li class="mb-1">
                        <button class="btn btn-toggle btn-sidebar text-start rounded collapsed text-nowrap" data-bs-toggle="collapse" data-bs-target="#optymalnosc-collapse" aria-expanded="false">
                            <svg class="bi mb-1" width="1rem" height="1rem" fill="currentColor" style="transform: rotate(90deg);"><use xlink:href="../icons/bootstrap-icons.svg#chevron-right"/></svg>
                            Optymalność
                        </button>
                        <div class="collapse show" id="optymalnosc-collapse" style="">
                            <ul class="btn-toggle-nav list-unstyled fw-normal py-1 small">
                                <li><a type="button" href="./notacja_duzego_o" class="btn btn-sidebar btn-sm rounded text-start fw-bold">Notacja dużego O</a></li>
                                <li><a type="button" href="./zlozonosc_obliczeniowa" class="btn btn-sidebar btn-sm rounded text-start">Złożoność obliczeniowa</a></li>
                                <li><a type="button" href="./zlozonosc_pamieciowa" class="btn btn-sidebar btn-sm rounded text-start">Złożoność pamięciowa</a></li>
                            </ul>
                        </div>
                    </li>

                    <li class="mb-1">
                        <button class="btn btn-toggle btn-sidebar text-start rounded collapsed" data-bs-toggle="collapse" data-bs-target="#atrybuty-collapse" aria-expanded="false">
                            <svg class="bi mb-1" width="1rem" height="1rem" fill="currentColor"><use xlink:href="../icons/bootstrap-icons.svg#chevron-right"/></svg>
                            Atrybuty
                        </button>
                        <div class="collapse" id="atrybuty-collapse" style="">
                            <ul class="btn-toggle-nav list-unstyled fw-normal py-1 small">
                                <li><a type="button" href="./stabilnosc" class="btn btn-sidebar btn-sm rounded text-start">Stabilność</a></li>
                                <li><a type="button" href="./rekurencja" class="btn btn-sidebar btn-sm rounded text-start">Rekurencja</a></li>
                            </ul>
                        </div>
                    </li>
                    <li class="mb-1">
                        <button class="btn btn-toggle btn-sidebar text-start rounded collapsed" data-bs-toggle="collapse" data-bs-target="#algorytmy-collapse" aria-expanded="false">
                            <svg class="bi mb-1" width="1rem" height="1rem" fill="currentColor"><use xlink:href="../icons/bootstrap-icons.svg#chevron-right"/></svg>
                            Algorytmy sortujące
                        </button>
                        <div class="collapse" id="algorytmy-collapse" style="">
                            <ul class="btn-toggle-nav list-unstyled fw-normal py-1 small">
                                <li><a type="button" href="./sortowanie_babelkowe" class="btn btn-sidebar btn-sm rounded text-start">Sortowanie bąbelkowe</a></li>
                                <li><a type="button" href="./sortowanie_przez_wstawianie" class="btn btn-sidebar btn-sm rounded text-start">Sortowanie przez wstawianie</a></li>
                                <li><a type="button" href="./sortowanie_przez_wybor" class="btn btn-sidebar btn-sm rounded text-start">Sortowanie przez wybór</a></li>
                                <li><a type="button" href="./sortowanie_przez_scalanie" class="btn btn-sidebar btn-sm rounded text-start">Sortowanie przez scalanie</a></li>
                                <li><a type="button" href="./sortowanie_szybkie" class="btn btn-sidebar btn-sm rounded text-start">Sortowanie szybkie</a></li>
                            </ul>
                        </div>
                    </li>
                </ul>
            </nav>
        </aside>

        <main class="col-12 col-sm-9 col-xl-10 p-3 order-1 order-sm-2 pt-5">
            <span class="h2">Notacja dużego O</span>
            <hr class="mt-1 mb-3"/>
            <p>
                Notacja dużego O używana jest do określenia górnej <b>granicy funkcji</b> wyrażającej liczbę operacji. W tej notacji najważniejszy jest najbardziej znaczący składnik funkcji, czyli ten który ma największy wpływ na jej przebieg, a pomijane są składniki mniej znaczące (takie jak np. wartość stała), ponieważ dla dostatecznie dużych wartości n ich wpływ na wynik funkcji jest niemal niezauważalny.
            </p>
            <p>
                <b>Przykład #1</b><br/>
                Podana jest funkcja <b>f(n) = n<sup>2</sup> + 10n + 40</b>. Notacja dużego O tej funkcji to <b>O(n<sup>2</sup>)</b>, ponieważ najbardziej znaczącym składnikiem tej funkcji jest n<sup>2</sup> i to dzięki niemu funkcja rośnie najszybciej.<br/>
            </p>
            <p>
                <b>Przykład #2</b><br/>
                Podana jest funkcja <b>f(n) = 10n<sup>2</sup> + 200n</b>. Notacja dużego O tej funkcji to <b>O(n<sup>2</sup>)</b>. Mimo że dla małych wartości n dzięki składnikowi liniowemu funkcja wynosi sporo, to dla większych wartości n znacznie większe znaczenie będzie miał składnik o potędze kwadratowej.
                <div class="row">
                    <div class="col-12 col-sm-10 col-md-8 col-xl-6 col-xxl-4">
                        <table class="table table-bordered">
                            <thead class="table-secondary">
                            <th>n</th>
                            <th>n<sup>2</sup></th>
                            <th>200n</th>
                            <th>f(n)</th>
                            </thead>
                            <tbody>
                            <tr>
                                <th>
                                    10
                                </th>
                                <td>
                                    100
                                </td>
                                <td>
                                    2 000
                                </td>
                                <td>
                                    2 100
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    100
                                </th>
                                <td>
                                    10 000
                                </td>
                                <td>
                                    20 000
                                </td>
                                <td>
                                    30 000
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    1000
                                </th>
                                <td>
                                    1 000 000
                                </td>
                                <td>
                                    200 000
                                </td>
                                <td>
                                    1 200 000
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </p>
            <p>
                W tematyce algorytmów sortujących notację dużego O wykorzystuje się do wyrażania czasu pracy algorytmu lub też oznaczania ilości zasobów wykorzystywanych przez algorytm w czasie jego całkowitego działania.<br/>
                Może również posłużyć do oznaczania ilości pamięci wykorzystywanej przez algorytm przez cały okres pracy algorytmu.
            </p>
            <p>
                Przykładowo zapis O(n<sup>2</sup>) w złożoności obliczeniowej algorytmu oznacza, że algorytm będzie działał <b>co najwyżej</b> w czasie kwadratowym w stosunku do ilości elementów listy.
            </p>
            <span class="h4">Najczęściej spotykane zapisy notacji i ich nazwy</span>
            <hr class="mt-1 mb-3"/>
            <p>
                Istnieje kilka najczęściej spotykanych zapisów notacji:
                <ul>
                    <li><b>O(1)</b> - złożoność stała</li>
                    <li><b>O(log(n))</b> - złożoność logarytmiczna</li>
                    <li><b>O(n)</b> - złożoność liniowa</li>
                    <li><b>O(n*log(n))</b> - złożoność liniowo-logarytmiczna</li>
                    <li><b>O(n<sup>2</sup>)</b> - złożoność kwadratowa</li>
                    <li><b>O(n<sup>x</sup>)</b> - złożoność wielomianowa</li>
                    <li><b>O(x<sup>n</sup>)</b> - złożoność wykładnicza</li>
                    <li><b>O(n!)</b> - złożoność silniowa</li>
                </ul>
            </p>
            <span class="h4">Bliźniacze notacje</span>
            <hr class="mt-1 mb-3"/>
            <p>
                Istnieją dwie bliźniacze do notacji dużego O notacje, są nimi:
                <ul>
                    <li>Notacja dużego θ (Theta) - Określa jednakową górną i dolną granicę funkcji oraz oznacza, że algorytm będzie działał <b>dokładnie</b> w zadanej notacji</li>
                    <li>Notacja dużego Ω (Omega) - Określa dolną granicę funkcji orazoznacza, że algorytm będzie działał <b>co najmniej</b> w zadanej notacji.</li>
                </ul>
                Jednak do oznaczania złożoności obliczeniowych stosuje się jedynie notację dużego O, ponieważ branie pod uwagę najgorszego przypadku działania algorytmu jest najbardziej miarodajnym wyznacznikiem wydajności.
            </p>
            <hr class="mt-1 mb-2"/>
            <span class="h5">Źródła</span>
            <ol class="fst-italic text-break">
                <li><a style="text-decoration: none" href="https://en.wikipedia.org/wiki/Computational_complexity">https://en.wikipedia.org/wiki/Computational_complexity</a>, dostęp 26 października 2021</li>
                <li><a style="text-decoration: none" href="http://algorytmy.ency.pl/artykul/notacja_duzego_o">http://algorytmy.ency.pl/artykul/notacja_duzego_o</a>, dostęp 26 października 2021</li>
                <li><a style="text-decoration: none" href="https://pl.wikipedia.org/wiki/Asymptotyczne_tempo_wzrostu">https://pl.wikipedia.org/wiki/Asymptotyczne_tempo_wzrostu</a>, dostęp 26 października 2021</li>
            </ol>
        </main>
    </div>
</div>

<div class="flex-grow-1"></div>

<!--Podpięcie plików skryptowych JQuery oraz Bootstrap-->
<script src="../lib/jquery-3.6.0.min.js"></script>
<script src="../lib/jquery.validate.min.js"></script>
<script src="../lib/bootstrap.bundle.min.js"></script>
<!--Własny plik JavaScript-->
<script src="../scripts/script.js"></script>
<script src="../scripts/form-validation.js"></script>
</body>
</html>