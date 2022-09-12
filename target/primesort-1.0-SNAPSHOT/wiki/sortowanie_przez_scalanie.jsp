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
            <a class="navbar-brand ms-2 ms-lg-5" href="/"><img src="../img/logo.png" class="d-inline-block me-2 mb-2" width="40" height="40" alt=""/>Prime Sort</a>
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
                                <li><a type="button" href="./sortowanie_przez_wybor" class="btn btn-sidebar btn-sm rounded text-start">Sortowanie przez wybór</a></li>
                                <li><a type="button" href="./sortowanie_przez_scalanie" class="btn btn-sidebar btn-sm rounded text-start fw-bold">Sortowanie przez scalanie</a></li>
                                <li><a type="button" href="./sortowanie_szybkie" class="btn btn-sidebar btn-sm rounded text-start">Sortowanie szybkie</a></li>
                            </ul>
                        </div>
                    </li>
                </ul>
            </nav>
        </aside>

        <main class="col-12 col-sm-9 col-xl-10 p-3 order-1 order-sm-2 pt-5">
            <span class="h2">Sortowanie przez scalanie</span>
            <hr class="mt-1 mb-3"/>
            <p>
                Sortowanie przez scalanie <i>(ang. Merge sort)</i> - jeden z najpopularniejszych algorytmów sortujących ze względu na jego szybkość działania oraz wydajność. W każdym przypadku zachowuje tą samą optymalną złożoność obliczeniową wynoszącą zaledwie O(n*log(n)). Z tego powodu jest częstym wyborem jako zastosowanie do sortowania zbiorów.
                Mimo iż jest wydajny, to dość skomplikowany w implementacji ze względu na użycie rekursji. Sortowanie przez scalanie jest algorytmem rekursywnym w swojej typowej implementacji, choć istnieje wersja iteracyjna tego algorytmu opierająca się na użyciu stosów.
            </p>
            <p>
                Sposób działania algorytmu sprowadza się do dwóch głównych kroków.
                <ol>
                    <li>Pierwszym jest podzielenie całego zbioru na n pojedynczych podzbiorów, każdy zawierający tylko jeden element.</li>
                    <li>Drugim natomiast jest sam proces scalania polegający na kilkukrotnym łączeniu dwóch mniejszych zbiorów w jeden większy, po drodze sortując elementy znajdujące się w tych zbiorach.</li>
                </ol>
            </p>
            <p>
                Powód dla którego każdy z przypadków sortowania tym algorytmem posiada tą samą złożoność obliczeniową wynika z tego, że niezależnie od sposobu ułożenia elementów w zbiorze wejściowym algorytm wykona te same operacje.
                Dzięki sposobowi sortowania, algorytm jest algorytmem stabilnym, czyli zachowa on oryginalną kolejność elementów o tej samej wartości.
                Fakt, że algorytm na początku dzieli wejściowy zbiór na podzbiory, a potem scala i sortuje je w jeden, mówi że algorytm wykorzystuje metodę Dziel i Rządź.
            </p>
            <p>
                Wizualizację działania Sortowania przez scalanie można zobaczyć po kliknięciu <a style="text-decoration: none" href="../sortowanie_przez_scalanie">tutaj</a>.
            </p>
            <span class="h4">Atrybuty</span>
            <hr class="mt-1 mb-3"/>
            <p>
                Sortowanie przez scalanie posiada następujące atrybuty:
            <ul>
                <li>Złożoność obliczeniowa</li>
                <ul>
                    <li>Najlepsza - O(n*log(n))</li>
                    <li>Typowa - O(n*log(n))</li>
                    <li>Najgorsza  - O(n*log(n))</li>
                </ul>
                <li>Złożoność pamięciowa</li>
                <ul>
                    <li>Całkowita - O(n)</li>
                    <li>Pomocnicza - O(n)</li>
                </ul>
                <li>Rekurencja - Tak</li>
                <li>Stabilność - Tak</li>
                <li>Porównywanie - Tak</li>
                <li>Online - Nie</li>
            </ul>
            </p>
            <span class="h4">Pseudokod</span>
            <hr class="mt-1 mb-3"/>
            <p>
                Pseudokod algorytmu Sortowania przez wstawianie składa się z dwóch funkcji.<br/>
                Pierwszą jest funkcja scalania, która będzie potem użyta we właściwej funkcji sortowania.
                <div class='text-break border border-dark p-1 mt-1 max-vw-25' style='font-family: Consolas; background-color: #ededed; max-width:600px'>
                    funkcja scal(<br/>tab, <b>: tablica elementów do posortowania</b> <br/>indeksL, <b>: lewy (pierwszy) indeks tablicy</b> <br/>indeksS, <b>: środkowy indeks tablicy</b> <br/>indeksP <b>: prawy (ostatni) indeks tablicy</b><br/>){<br/>
                    <div style="margin-left: 2rem">
                        <b>// Określanie rozmiarów podtablicy pierwszej (lewej - L) oraz drugiej (prawej - R)</b><br/>
                        rozmiarL = indeksS - indeksL + 1<br/>
                        rozmiarP = indeksP - indeksS<br/>
                        <br/>
                        <b>// Utworzenie podtablic lewej (L) oraz prawej (R) o rozmiarach określonych powyżej</b><br/>
                        L[rozmiarL]<br/>
                        P[rozmiarP]<br/>
                        <br/>
                        <b>// Kopiowanie danych z tablicy do dwóch utworzonych podtablic</b><br/>
                        <b>dla</b> i = 0 <b>do</b> rozmiarL - 1 <b>wykonaj</b> L[i] = tab[indeksL + i]<br/>
                        <b>dla</b> j = 0 <b>do</b> rozmiarP - 1 <b>wykonaj</b> P[j] = tab[indeksS + 1 + j]<br/>
                        <br/>
                        <b>// Tworzenie indeksów potrzebnych w procesie scalania</b><br/>
                        i = 0<br/>
                        j = 0<br/>
                        k = indeksL<br/>
                        <br/>
                        <b>// Proces scalania oraz sortowania danych</b><br/>
                        <b>powtarzaj podczas gdy</b> i < rozmiarL <b>oraz</b> j < rozmiarP{
                        <div style="margin-left: 2rem">
                            <b>jeżeli</b> L[i] <= R[j] to{
                            <div style="margin-left: 2rem">
                                tab[k] = L[i]<br/>
                                <b>zinkrementuj</b> i
                            </div>
                            }<br/>
                            <b>w przeciwnym wypadku</b>{
                            <div style="margin-left: 2rem">
                                tab[k] = P[j]
                                <b>zinkrementuj</b> j
                            </div>
                            }<br/>
                            <b>zinkrementuj</b> k
                        </div>
                        }<br/>
                        <br/>
                        <b>/* Kopiowanie pozostałych elementów z podtablic do tablicy głównej */</b><br/>
                        <b>powtarzaj podczas gdy</b> i < rozmiarL{
                        <div style="margin-left: 2rem">
                            tab[k] = L[i]<br/>
                            <b>zinkrementuj</b> i<br/>
                            <b>zinkrementuj</b> k
                        </div>
                        }<br/>
                        <b>powtarzaj podczas gdy</b> i < rozmiarP{<br/>
                        <div style="margin-left: 2rem">
                            tab[k] = P[j]<br/>
                            <b>zinkrementuj</b> j<br/>
                            <b>zinkrementuj</b> k
                        </div>
                        }
                    </div>
                    }<br/>
                </div>
            </p>
            <p>
                Druga funkcja to funkcja właściwa wykorzystująca funkcję scal() znajdującą się powyżej.<br/>
                <div class='text-break border border-dark p-1 mt-1 max-vw-25' style='font-family: Consolas; background-color: #ededed; max-width:600px'>
                    funkcja sortowaniePrzezScalanie(<br/>tab, <b>: tablica elementów do posortowania</b> <br/>indeksL, <b>: lewy (pierwszy) indeks tablicy</b> <br/>indeksP <b>: prawy (ostatni) indeks tablicy</b><br/>){
                    <div style="margin-left: 2rem">
                        <b>jeżeli</b> indeksL < indeksP <b>to</b>{
                        <div style="margin-left: 2rem">
                            <b>// Utworzenie indeksu środkowego</b><br/>
                            indeksS = indeksL + (indeksP - indeksL) / 2<br/>
                            <br/>
                            <b>// Rekurencyjne sortowanie lewej i prawej podtablicy</b><br/>
                            sortowaniePrzezScalanie(tab, indeksL, indeksS)<br/>
                            sortowaniePrzezScalanie(tab, indeksS + 1, indeksP)<br/>
                            <br/>
                            <b>// Scalanie lewej i prawej podtablicy</b><br/>
                            scal(tab, indeksL, indeksS, indeksP)
                        </div>
                        }
                    </div>
                    }
                </div>
            </p>
            <span class="h4">Przykład działania</span>
            <hr class="mt-1 mb-3"/>
            <p>
                Tablica wejściowa: {2, 7, 5, 3, 8, 6, 4, 1}<br/>
                Algorytm sortujący: Sortowanie przez scalanie<br/>
                Sortowanie: rosnąco
            </p>
            <img class="img-fluid" src="../img/mergesort_diagram.png" alt="Diagram Sortowania przez Scalanie"/>
            <p>
                Finalna tablica: {1, 2, 3, 4, 5, 6, 7, 8}
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