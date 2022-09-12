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
                        <a type="button" class="btn btn-sidebar text-start rounded collapsed fw-bold" href="./algorytm_sortujacy">
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

        <main class="col-12 col-sm-9 col-xl-10 p-3 order-1 order-sm-2 py-5">
            <span class="h2">Algorytm sortujący</span>
            <hr class="mt-1 mb-3"/>

            <p>
                <b>Algorytm sortujący</b> to metoda na ułożenie elementów pewnej listy w konkretnej kolejności (np. rosnącej, malejącej, alfabetycznej)
            </p>
            <p>
                W informatyce algorytmem sortującym nazywa się program, którego parametrem wejściowym jest lista elementów, a wynikiem jego działania jest pierwotna lista, której elementy znajdują się w ustalonej kolejności.<br/>
                Formalnie każdy wynik algorytmu musi spełniać <b>dwa założenia:</b>
                <ol>
            <li>Wynikowa lista przedstawia elementy <b>w kolejności</b> zależnej od pewnego kryterium</li>
            <li>Wynikowa lista jest <b>przekształceniem</b> listy wejściowej, wszystkie oryginalne elementy muszą zostać zachowane</li>
                </ol>
            </p>

            <span class="h4">Operacje</span>
            <hr class="mt-1 mb-3"/>
            <p>
                Algorytm sortujący przeprowadza zestaw konkretnych <b>operacji</b> na zadanej liście, które dążą do całkowitego jej posortowania. Najbardziej powszechnymi operacjami wykorzystywanymi w algorytmach sortujących są:
                <ol>
                    <li><b>Porównywanie</b> - operacja biorąca pod uwagę dwa elementy listy i porównująca ją pod względem ich atrybutów, po to by określić ich kolejność</li>
                    <li><b>Zamiana</b> - operacja zamieniająca pozycjami dwa określone elementy listy</li>
                </ol>
                Wspomnieć należy, że nie wszystkie algorytmy sortujące wykorzystują operacje porównania do swojego działania.
            </p>

            <span class="h4">Klasyfikacja</span>
            <hr class="mt-1 mb-3"/>
            <p>
                Algorytmów sortujących jest wiele. Różnią się one między sobą atrybutami, które sprawiają, że każdy z nich jest mniej lub bardziej wydajny, lub bardziej lub mniej efektywny w konkretnych sytuacjach. Poniżej znajduje się lista atrybutów, dzięki którym sklasyfikowane są algorytmy.
            </p>
            <ul>
                <li><b><a style="text-decoration: none" href="./zlozonosc_obliczeniowa">Złożoność obliczeniowa</a></b> - jest wyznacznikiem wydajności algorytmu pod względem ilości operacji jakie wykonuje do pełnego posortowania listy. Wyrażana jest w notacji dużego O. Dla każdego algorytmu można ją podzielić między trzy przypadki:
                <ul>
                    <li><b>Przypadek najlepszy</b> (<i>ang. best case</i>) - wyraża najmniejszą możliwą ilość operacji jaką musi wykonać algorytm podczas sortowania listy, która jest dla algorytmu w najbardziej korzystnej konfiguracji.</li>
                    <li><b>Przypadek typowy</b> (<i>ang. average case</i>) - wyraża przeciętną ilość operacji jaką wykonuje algorytm, gdy kolejność elementów listy nie odznacza się niczym charakterystycznym.</li>
                    <li><b>Przypadek najgorszy</b> (<i>ang. worst case</i>) - wyraża największą możliwą ilość operacji jaką musi wykonać algorytm podczas sortowania listy, która jest dla algorytmu w najbardziej niekorzystnej konfiguracji.</li>
                </ul></li>
                <li><b><a style="text-decoration: none" href="./zlozonosc_pamieciowa">Złożoność pamięciowa</a></b> - wyraża ilość pamięci wymaganej do przeprowadzenia sortowania przez algorytm.</li>
                <li><b><a style="text-decoration: none" href="./rekurencja">Rekurencja</a></b> - niektóre algorytmy sortujące występują w formie rekursywnej, a niektóre nie.</li>
                <li><b><a style="text-decoration: none" href="./stabilnosc">Stabilność</a></b> - mówi o tym czy algorytm zachowa oryginalną kolejność elementów o tej samej wartości, czy nie.</li>
                <li><b><a style="text-decoration: none" href="./porownywanie">Porównywanie</a></b> - mówi o tym czy algorytm wykorzystuje operacje porównywania do swojego działania.</li>
                <li><b><a style="text-decoration: none" href="#">Online</a></b> - czy algorytm potrafi działać bez znajomości rozmiaru listy oraz czy lista może być powiększana o nowe elementy podczas działania algorytmu.</li>
            </ul>

            <span class="h4">Wybrane algorytmy sortujące</span>
            <hr class="mt-1 mb-3"/>
            <p>
                Poniższe algorytmy są jednymi z najpopularniejszych algorytmów sortujących.
                <ul>
                    <li><a style="text-decoration: none" href="./sortowanie_babelkowe">Sortowanie bąbelkowe</a> (Sortowanie bąbelkowe) - jeden z najprostszych i najbardziej podstawowych algorytmów sortujących. Działa poprzez porównywanie każdych kolejnych sąsiadujących elementów i zamienianie ich miejscami jeżeli są w złej kolejności. Służy jako dobry dydaktyczny przykład algorytmu sortującego, lecz nie jest efektywny ze względu na wysoką złożoność obliczeniową.</li>
                    <li><a style="text-decoration: none" href="./sortowanie_przez_wstawianie">Sortowanie przez wstawianie</a> (Sortowanie przez wstawianie) - algorytm efektywny dla list wstępnie posortowanych. Działa poprzez przesuwanie każdego kolejnego elementu w dół listy aż będzie na właściwym miejscu.</li>
                    <li><a style="text-decoration: none" href="./sortowanie_przez_wybor">Sortowanie przez wybór</a> (Sortowanie przez wybór) - koncept tego algorytmu jest bardzo zbliżony do tego jak człowiek rozwiązałby problem sortowania. Algorytm iteruje przez całą listę nieposortowanych elementów by znaleźć element o najmniejszej wartości, a na koniec iteracji umieszcza go na właściwym miejscu.</li>
                    <li><a style="text-decoration: none" href="./sortowanie_przez_scalanie">Sortowanie przez scalanie</a> (Sortowanie przez scalanie) - jeden z najbardziej efektywnych algorytmów. Dzieli on listę na osobne podlisty o coraz mniejszej wielkości, aż wielkość pojedynczej podlisty wyniesie 1. Potem porównuje ze sobą elementy sąsiadujących podlist i scala je w jedną, do momentu aż scali całą listę.</li>
                    <li><a style="text-decoration: none" href="./sortowanie_szybkie">Sortowanie szybkie</a> (Sortowanie szybkie) - algorytm działający na zasadzie partycjonowania. Wybiera jeden element jako element osiowy (pivot) oraz orientuje resztę tablicy wokół tego elementu.</li>
                </ul>
            </p>

            <hr class="mt-1 mb-2"/>
            <span class="h5">Źródła</span>
            <ol class="fst-italic text-break">
                <li><a style="text-decoration: none" href="https://whatis.techtarget.com/definition/sorting-algorithm">https://whatis.techtarget.com/definition/sorting-algorithm</a>, dostęp 25 października 2021</li>
                <li><a style="text-decoration: none" href="https://en.wikipedia.org/wiki/Sorting_algorithm">https://en.wikipedia.org/wiki/Sorting_algorithm</a>, dostęp 25 października 2021</li>
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