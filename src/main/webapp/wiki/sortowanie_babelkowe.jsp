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
                                <li><a type="button" href="./sortowanie_babelkowe" class="btn btn-sidebar btn-sm rounded text-start fw-bold">Sortowanie bąbelkowe</a></li>
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
            <span class="h2">Sortowanie bąbelkowe</span>
            <hr class="mt-1 mb-3"/>
            <p>
                Sortowanie bąbelkowe <i>(ang. Bubble sort)</i> jest jednym z najmniej skomplikowanych algorytmów sortujących. Sposób sortowania tego algorytmu jest prosty, lecz nie wydajny, przez co algorytm używany jest bardzo rzadko, szczególnie przy sortowaniu zbiorów o dużym rozmiarze.
            </p>
            <p>
                Algorytm działa poprzez ciągłe porównywanie sąsiadujących ze sobą elementów i zamienianie ich miejscami jeżeli są w złej kolejności. Przykładowo podczas sortowania elementów rosnąco, algorytm co każdą iterację "wypycha" element o największej wartości w górę listy do momentu, aż na jej końcu znajduje się największy element. Lista nieposortowanych elementów zmniejsza się o 1 oraz rozpoczyna się nowa iteracja. Algorytm kończy działanie kiedy podczas iteracji nie wystąpiła żadna operacja zamiany elementów.
            </p>
            <p>
                Wizualizację działania Sortowania bąbelkowego można zobaczyć po kliknięciu <a style="text-decoration: none" href="../sortowanie_babelkowe">tutaj</a>.
            </p>
            <span class="h4">Atrybuty</span>
            <hr class="mt-1 mb-3"/>
            <p>
                Sortowanie bąbelkowe posiada następujące atrybuty:
                <ul>
                    <li>Złożoność obliczeniowa</li>
                    <ul>
                        <li>Najlepsza - O(n) - występuje gdy wszystkie elementy są w posortowanej kolejności</li>
                        <li>Typowa - O(n<sup>2</sup>)</li>
                        <li>Najgorsza  - O(n<sup>2</sup>) - występuje gdy wszystkie elementy są w kolejności odwrotnej do posortowanej</li>
                    </ul>
                    <li>Złożoność pamięciowa</li>
                    <ul>
                        <li>Całkowita - O(n)</li>
                        <li>Pomocnicza - O(1)</li>
                    </ul>
                    <li>Rekurencja - Nie</li>
                    <li>Stabilność - Tak</li>
                    <li>Porównywanie - Tak</li>
                    <li>Online - Nie</li>
                </ul>
            </p>
            <span class="h4">Pseudokod</span>
            <hr class="mt-1 mb-3"/>
            <p>
            Pseudokod algorytmu Sortowania bąbelkowego wygląda następująco:
                <div class='text-break border border-dark p-1 mt-1' style='font-family: Consolas; background-color: #ededed; max-width:500px'>
                    funkcja sortowanieBabelkowe(tab <b>: tablica elementów do posortowania</b>){<br/>
                    <div style="margin-left: 2rem">
                        n = rozmiar(tab)<br/>
                        <b>powtarzaj</b>{<br/>
                        <div style="margin-left: 2rem">
                            zamieniono = fałsz<br/>
                            <b>dla</b> i = 1 <b>do</b> n-1 <b>wykonaj</b>{<br/>
                            <div style="margin-left: 2rem">
                                jeżeli tab[i-1] > tab[i] to{<br/>
                                <div style="margin-left: 2rem">
                                    zamień tab[i-1] z tab[i]<br/>
                                    zamieniono = prawda<br/>
                                </div>
                                }<br/>
                            </div>
                            }<br/>
                            <b>zdekrementuj</b> n<br/>
                        </div>
                        }<b>póki</b> zamieniono == prawda<br/>
                    </div>
                    }<br/>
                </div>
            </p>
            <p>
                Użyta tutaj wersja algorytmu z każdą iteracją porównuje o jeden element mniej, gdyż nie ma potrzeby porównywania elementów z końca listy, które zostały już posortowane.
            </p>
            <p>
                Algorytm implementuje zmienną stanową "zamieniono" by śledzić czy podczas pojedynczej iteracji została wykonana operacja zamiany elementów. Jeżeli przy końcu iteracji zmienna ta będzie miała wartość "fałsz", program zakończy się, gdyż elementy są w prawidłowej kolejności.
            </p>
            <span class="h4">Przykład działania</span>
            <hr class="mt-1 mb-3"/>
            <p>
                Tablica wejściowa: {3, 14, 9, 2, 7}<br/>
                Algorytm sortujący: Sortowanie bąbelkowe<br/>
                Sortowanie: rosnąco
            </p>
            <div class="row">
                <div class="col-12 col-md-6 col-xl-4 col-xxl-3">
                    <p>
                        <b class="h5">Iteracja 1</b>
                    </p>
                    <table class="table">
                        <thead>
                            <th>L.</th>
                            <th>Operacja</th>
                            <th>Tablica</th>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>Porównywanie</td>
                                <td>{<b class="text-danger">3, 14</b>, 9, 2, 7}</td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>Porównywanie</td>
                                <td>{3, <b class="text-danger">14, 9</b>, 2, 7}</td>
                            </tr>
                            <tr>
                                <td>3</td>
                                <td>Zamiana</td>
                                <td>{3, <b class="text-danger">9, 14</b>, 2, 7}</td>
                            </tr>
                            <tr>
                                <td>4</td>
                                <td>Porównywanie</td>
                                <td>{3, 9, <b class="text-danger">14, 2</b>, 7}</td>
                            </tr>
                            <tr>
                                <td>5</td>
                                <td>Zamiana</td>
                                <td>{3, 9, <b class="text-danger">2, 14</b>, 7}</td>
                            </tr>
                            <tr>
                                <td>6</td>
                                <td>Porównywanie</td>
                                <td>{3, 9, 2, <b class="text-danger">14, 7</b>}</td>
                            </tr>
                            <tr>
                                <td>7</td>
                                <td>Zamiana</td>
                                <td>{3, 9, 2, <b class="text-danger">7, 14</b>}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="col-12 col-md-6 col-xl-4 col-xxl-3">
                    <p>
                        <b class="h5">Iteracja 2</b>
                    </p>
                    <table class="table">
                        <thead>
                            <th>L.</th>
                            <th>Operacja</th>
                            <th>Tablica</th>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>Porównywanie</td>
                                <td>{<b class="text-danger">3, 9</b>, 2, 7 | 14}</td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>Porównywanie</td>
                                <td>{3, <b class="text-danger">9, 2</b>, 7 | 14}</td>
                            </tr>
                            <tr>
                                <td>3</td>
                                <td>Zamiana</td>
                                <td>{3, <b class="text-danger">2, 9</b>, 7 | 14}</td>
                            </tr>
                            <tr>
                                <td>4</td>
                                <td>Porównywanie</td>
                                <td>{3, 2, <b class="text-danger">9, 7</b> | 14}</td>
                            </tr>
                            <tr>
                                <td>5</td>
                                <td>Zamiana</td>
                                <td>{3, 2, <b class="text-danger">7, 9</b> | 14}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="col-12 col-md-6 col-xl-4 col-xxl-3">
                    <p>
                        <b class="h5">Iteracja 3</b>
                    </p>
                    <table class="table">
                        <thead>
                            <th>L.</th>
                            <th>Operacja</th>
                            <th>Tablica</th>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>Porównywanie</td>
                                <td>{<b class="text-danger">3, 2</b>, 7 | 9, 14}</td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>Zamiana</td>
                                <td>{<b class="text-danger">2, 3</b>, 7 | 9, 14}</td>
                            </tr>
                            <tr>
                                <td>3</td>
                                <td>Porównywanie</td>
                                <td>{2, <b class="text-danger">3, 7</b> | 9, 14}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="col-12 col-md-6 col-xl-4 col-xxl-3">
                    <p>
                        <b class="h5">Iteracja 4</b>
                    </p>
                    <table class="table">
                        <thead>
                            <th>L.</th>
                            <th>Operacja</th>
                            <th>Tablica</th>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>Porównywanie</td>
                                <td>{<b class="text-danger">2, 3</b> | 7, 9, 14}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <p>
                Finalna tablica: {2, 3, 7, 9, 14}
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