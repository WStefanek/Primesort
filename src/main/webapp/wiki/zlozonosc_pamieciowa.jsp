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
                            <svg class="bi mb-1" width="1rem" height="1rem" fill="currentColor" style="transform: rotate(90deg);"><use xlink:href="../icons/bootstrap-icons.svg#chevron-right"/></svg>
                            Optymalność
                        </button>
                        <div class="collapse show" id="optymalnosc-collapse" style="">
                            <ul class="btn-toggle-nav list-unstyled fw-normal py-1 small">
                                <li><a type="button" href="./notacja_duzego_o" class="btn btn-sidebar btn-sm rounded text-start">Notacja dużego O</a></li>
                                <li><a type="button" href="./zlozonosc_obliczeniowa" class="btn btn-sidebar btn-sm rounded text-start">Złożoność obliczeniowa</a></li>
                                <li><a type="button" href="./zlozonosc_pamieciowa" class="btn btn-sidebar btn-sm rounded text-start fw-bold">Złożoność pamięciowa</a></li>
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
            <span class="h2">Złożoność pamięciowa</span>
            <hr class="mt-1 mb-3"/>
            <p>
                <b>Złożoność pamięciowa</b> <i>(ang. space complexity)</i> - wyraża ilość pamięci komputera zajmowanej przez struktury danych tworzone przez algorytm w czasie jego działania. Złożoność pamięciowa, podobnie jak złożoność obliczeniowa, wyrażana jest za pomocą <a style="text-decoration: none" href="./notacja_duzego_o">notacji dużego O</a>.
            </p>
            <p>
                Każdy algorytm operujący na danych wykorzystuje pewną ilość pamięci komputera do swojego działania. Złożoność pamięciowa dzieli się na złożoność <b>całkowitą</b> oraz <b>pomocniczą</b>.
            </p>
            <span class="h4">Całkowita złożoność pamięciowa</span>
            <hr class="mt-1 mb-3"/>
            <p>Określa całkowitą ilość pamięci zajmowanej przez algorytm. W jej skład wchodzą argumenty wejściowe algorytmu, na przykład
                <ul>
                    <li>dane zrzucone na stos przy algorytmach rekursywnych, do których algorytm odwoła się później;</li>
                    <li>dynamiczne przypisywanie pamięci.</li>
                </ul>
                Częścią całkowitej złożoności pamięciowej jest również <b>złożoność pomocnicza</b>.
            </p>
            <span class="h4">Pomocnicza złożoność pamięciowa</span>
            <hr class="mt-1 mb-3"/>
            <p>
                Określa dodatkowe struktury danych tworzone przez algorytm wymagane do poprawnej pracy algorytmu. W jej skład wchodzą na przykład
                <ul>
                    <li>zmienne pomocnicze wykorzystywane w operacji zamiany (np. sortowanie bąbelkowe),</li>
                    <li>tablica pomocnicza o rozmiarze tablicy wejściowej (np. sortowanie przez scalanie).</li>
                </ul>
            </p>
            <span class="h4">Przykład obliczania złożoności pamięciowej funkcji</span>
            <hr class="mt-1 mb-3"/>
            <p>Załóżmy, że mamy do obliczenia złożoność pamięciową podanej funkcji zwracającej sumę wszystkich elementów tablicy</p>
            <div class='text-break border border-dark p-1 mt-1' style='font-family: Consolas; background-color: #ededed; width: 350px'>
                public int sumaTablicy(int[] tab){
                <div style="margin-left: 2rem">
                    int suma = 0;<br/><br/>

                    for(int i=0;i&lt;tab.length;i++){<br/>
                        <div style="margin-left: 2rem">
                            suma += tab[i];<br/>
                        </div>
                    }<br/><br/>
                    return suma;<br/>
                </div>
                }
            </div><br/>
            <p>
                Przyjmijmy, że każda przypisana zmienna zajmuje jedną jednostkę pamięci. Podana funkcja składa się z następujących struktur danych:
                <ul>
                    <li><b>int[] tab</b> - operacja zadeklarowania tablicy, która jest argumentem wejściowym funkcji. Jej rozmiar w pamięci zależy od ilości elementów tablicy podanej jako argument, czyli zajmuje n jednostek pamięci.</li>
                    <li><b>int suma = 0;</b> - operacja zadeklarowania zmiennej oraz przypisania jej wartości 0. Zajmuje 1 jednostkę pamięci.</li>
                    <li><b>int i = 0;</b> - operacja zadeklarowania zmiennej oraz przypisania jej wartości 0. Zajmuje 1 jednostkę pamięci.</li>
                </ul>
            </p>
            <p>
                W sumie ilość pamięci zajętej przez funkcję będzie wynosić: <b>pamięć zajęta przez int[] tab</b> + <b>pamięć zajęta przez int suma = 0</b> + <b>pamięć zajęta przez int i = 0</b>, czyli
            </p>
            <p>
                <b> n + 1 + 1 = n + 2</b>
            </p>
            <p>
                Całkowita ilość zajętej pamięci wynosi więc <b>n+2</b>. Jako że przy złożoności bierzemy pod uwagę tylko czynnik, którego wzrost będzie miał największy wpływ na wynik funkcji, to całkowita złożoność pamięciowa tego programu wyniesie <b>O(n)</b>.
            </p>
            <hr class="mt-1 mb-2"/>
            <span class="h5">Źródła</span>
            <ol class="fst-italic text-break">
                <li><a style="text-decoration: none" href="https://eduinf.waw.pl/inf/utils/010_2010/0216.php">https://eduinf.waw.pl/inf/utils/010_2010/0216.php</a>, dostęp 03 listopada 2021</li>
                <li><a style="text-decoration: none" href="https://www.tutorialspoint.com/time-and-space-complexity-in-data-structure">https://www.tutorialspoint.com/time-and-space-complexity-in-data-structure</a>, dostęp 04 listopada 2021</li>
                <li><a style="text-decoration: none" href="https://www.baeldung.com/cs/space-complexity">https://www.baeldung.com/cs/space-complexity</a>, dostęp 04 listopada 2021</li>
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