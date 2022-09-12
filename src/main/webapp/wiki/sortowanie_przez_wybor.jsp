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
                    <li class="nav-item"><a class="nav-link mx-2" href="./sortowanie">Baza wiedzy</a></li>
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
                            <svg class="bi mb-1" width="1rem" height="1rem" fill="currentColor"><use xlink:href="../icons/bootstrap-icons.svg#chevron-right"/></svg>
                            Optymalność
                        </button>
                        <div class="collapse" id="optymalnosc-collapse" style="">
                            <ul class="btn-toggle-nav list-unstyled fw-normal py-1 small">
                                <li><a type="button" href="./notacja_duzego_o" class="btn btn-sidebar btn-sm rounded text-start">Notacja dużego O</a></li>
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
                            <svg class="bi mb-1" width="1rem" height="1rem" fill="currentColor" style="transform: rotate(90deg);"><use xlink:href="../icons/bootstrap-icons.svg#chevron-right"/></svg>
                            Algorytmy sortujące
                        </button>
                        <div class="collapse show" id="algorytmy-collapse" style="">
                            <ul class="btn-toggle-nav list-unstyled fw-normal py-1 small">
                                <li><a type="button" href="./sortowanie_babelkowe" class="btn btn-sidebar btn-sm rounded text-start">Sortowanie bąbelkowe</a></li>
                                <li><a type="button" href="./sortowanie_przez_wstawianie" class="btn btn-sidebar btn-sm rounded text-start">Sortowanie przez wstawianie</a></li>
                                <li><a type="button" href="./sortowanie_przez_wybor" class="btn btn-sidebar btn-sm rounded text-start fw-bold">Sortowanie przez wybór</a></li>
                                <li><a type="button" href="./sortowanie_przez_scalanie" class="btn btn-sidebar btn-sm rounded text-start">Sortowanie przez scalanie</a></li>
                                <li><a type="button" href="./sortowanie_szybkie" class="btn btn-sidebar btn-sm rounded text-start">Sortowanie szybkie</a></li>
                            </ul>
                        </div>
                    </li>
                </ul>
            </nav>
        </aside>

        <main class="col-12 col-sm-9 col-xl-10 p-3 order-1 order-sm-2 pt-5">
            <span class="h2">Sortowanie przez wybór</span>
            <hr class="mt-1 mb-3"/>
            <p>
                Sortowanie przez wybór <i>(ang. Selection sort)</i> - jeden z prostszych algorytmów sortujących, zarówno do zaimplementowania oraz zrozumienia jego działania, choć jest bardzo niepraktyczny ze względu na jego słabą wydajność. Jest natomiast dobrym wyborem w przypadku, gdy wymogiem jest by wykonać na tablicy jak najmniejszą liczbę operacji zamian, ponieważ na każdą iterację algorytmu przypada jedynie jedna taka operacja.
            </p>
            <p>
                Algorytm sortuje przez znalezienie minimalnego elementu listy oraz zamienianie minimalnego elementu z pierwszym elementem listy. W kolejnej iteracji algorytm ponownie znajduje minimalny element, lecz wyklucza przy tym minimalny element z poprzedniej iteracji. Następnie zamienia go z następnym najniżej znajdującym się w liście elementem, do momentu kiedy nie ma już więcej elementów do porównania.
            </p>
            <p>
                Sposób sortowania tego algorytmu jest dobrym przykładem dydaktycznym, z tego powodu, przedstawia sposób w jaki typowa osoba podeszłaby do problemu sortowania listy.
            </p>
            <p>
                Wizualizację działania Sortowania przez wybór można zobaczyć po kliknięciu <a style="text-decoration: none" href="../sortowanie_przez_wybor">tutaj</a>.
            </p>
            <span class="h4">Atrybuty</span>
            <hr class="mt-1 mb-3"/>
            <p>
                Sortowanie przez wybór posiada następujące atrybuty:
            <ul>
                <li>Złożoność obliczeniowa</li>
                <ul>
                    <li>Najlepsza - O(n<sup>2</sup>)</li>
                    <li>Typowa - O(n<sup>2</sup>)</li>
                    <li>Najgorsza  - O(n<sup>2</sup>)</li>
                </ul>
                <li>Złożoność pamięciowa</li>
                <ul>
                    <li>Całkowita - O(n)</li>
                    <li>Pomocnicza - O(1)</li>
                </ul>
                <li>Rekurencja - Nie</li>
                <li>Stabilność - Nie</li>
                <li>Porównywanie - Tak</li>
                <li>Online - Nie</li>
            </ul>
            </p>
            <span class="h4">Pseudokod</span>
            <hr class="mt-1 mb-3"/>
            <p>
                Pseudokod algorytmu Sortowania przez wstawianie wygląda następująco:
            <div class='text-break border border-dark p-1 mt-1 max-vw-25' style='font-family: Consolas; background-color: #ededed; max-width:500px'>
                funkcja sortowaniePrzezWybor(tab <b>: tablica elementów do posortowania</b>){<br/>
                <div style="margin-left: 2rem">
                    n = rozmiar(tab)<br/>
                    <b>dla</b> i = 0 <b>do</b> n - 1 <b>wykonaj</b>{
                    <div style="margin-left: 2rem">
                        min = i<br/>
                        <b>dla</b> j = i + 1 <b>do</b> n <b>wykonaj</b>{
                        <div style="margin-left: 2rem">
                            <b>jeżeli</b> tab[j] < tab[min] <b>to</b> min = j
                        </div>
                        }<br/>
                        <b>zamień</b> tab[i] <b>z</b> tab[min]
                    </div>
                    }
                </div>
                }<br/>
            </div>
            </p>
            <span class="h4">Przykład działania</span>
            <hr class="mt-1 mb-3"/>
            <p>
                Tablica wejściowa: {12, 1, 10, 4, 9}<br/>
                Algorytm sortujący: Sortowanie przez wybór<br/>
                Sortowanie: rosnąco
            </p>
            <div class="row">
                <div class="col-12 col-md-6 col-xl-4 mb-4">
                    <b class="h5">Iteracja 1</b>
                    <table class="table">
                        <thead>
                            <th>L.</th>
                            <th>Operacja</th>
                            <th>Tablica</th>
                            <th>Element minimalny</th>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>Porównywanie</td>
                                <td>{<b class="text-danger">12, 1</b>, 10, 4, 9}</td>
                                <td>1</td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>Porównywanie</td>
                                <td>{12, <b class="text-danger">1, 10</b>, 4, 9}</td>
                                <td>1</td>
                            </tr>
                            <tr>
                                <td>3</td>
                                <td>Porównywanie</td>
                                <td>{12, <b class="text-danger">1</b>, 10, <b class="text-danger">4</b>, 9}</td>
                                <td>1</td>
                            </tr>
                            <tr>
                                <td>4</td>
                                <td>Porównywanie</td>
                                <td>{12, <b class="text-danger">1</b>, 10, 4, <b class="text-danger">9</b>}</td>
                                <td>1</td>
                            </tr>
                            <tr>
                                <td>5</td>
                                <td>Zamiana</td>
                                <td>{<b class="text-danger">1, 12</b>, 10, 4, 9}</td>
                                <td>1</td>
                            </tr>
                        </tbody>
                    </table>
                    Element minimalny 1 jest na poprawnym miejscu.
                </div>
                <div class="col-12 col-md-6 col-xl-4 mb-4">
                    <b class="h5">Iteracja 2</b>
                    <table class="table">
                        <thead>
                            <th>L.</th>
                            <th>Operacja</th>
                            <th>Tablica</th>
                            <th>Element minimalny</th>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>Porównywanie</td>
                                <td>{1 | <b class="text-danger">12, 10</b>, 4, 9}</td>
                                <td>10</td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>Porównywanie</td>
                                <td>{1 | 12, <b class="text-danger">10, 4</b>, 9}</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>3</td>
                                <td>Porównywanie</td>
                                <td>{1 | 12, 10, <b class="text-danger">4, 9</b>}</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>4</td>
                                <td>Zamiana</td>
                                <td>{1 | <b class="text-danger">4</b>, 10, <b class="text-danger">12</b>, 9}</td>
                                <td>4</td>
                            </tr>
                        </tbody>
                    </table>
                    Element minimalny 4 jest na poprawnym miejscu.
                </div>
                <div class="col-12 col-md-6 col-xl-4 mb-4">
                    <b class="h5">Iteracja 3</b>
                    <table class="table">
                        <thead>
                            <th>L.</th>
                            <th>Operacja</th>
                            <th>Tablica</th>
                            <th>Element minimalny</th>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>Porównywanie</td>
                                <td>{1, 4 | <b class="text-danger">10, 12</b>, 9}</td>
                                <td>10</td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>Porównywanie</td>
                                <td>{1, 4 | <b class="text-danger">10</b>, 12, <b class="text-danger">9</b>}</td>
                                <td>9</td>
                            </tr>
                            <tr>
                                <td>3</td>
                                <td>Zamiana</td>
                                <td>{1, 4 | <b class="text-danger">9</b>, 12, <b class="text-danger">10</b>}</td>
                                <td>9</td>
                            </tr>
                        </tbody>
                    </table>
                    Element minimalny 9 jest na poprawnym miejscu.
                </div>
                <div class="col-12 col-md-6 col-xl-4 mb-4">
                    <b class="h5">Iteracja 4</b>
                    <table class="table">
                        <thead>
                            <th>L.</th>
                            <th>Operacja</th>
                            <th>Tablica</th>
                            <th>Element minimalny</th>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>Porównywanie</td>
                                <td>{1, 4, 9 | <b class="text-danger">12, 10</b>}</td>
                                <td>10</td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>Zamiana</td>
                                <td>{1, 4, 9 | <b class="text-danger">10, 12</b>}</td>
                                <td>10</td>
                            </tr>
                        </tbody>
                    </table>
                    Element minimalny 10 jest na poprawnym miejscu.<br/>
                    Nie ma elementów do porównania, stąd element 12 jest na poprawnym miejscu - koniec sortowania.
                </div>

            </div>
            <p>
                Finalna tablica: {1, 4, 9, 10, 12}
            </p>
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