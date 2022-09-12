-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 04 Lut 2022, 12:17
-- Wersja serwera: 10.4.21-MariaDB
-- Wersja PHP: 8.0.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `primesort`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `kategorie_pytan`
--

CREATE TABLE `kategorie_pytan` (
  `id_kategorii` int(11) NOT NULL,
  `nazwa` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `kategorie_pytan`
--

INSERT INTO `kategorie_pytan` (`id_kategorii`, `nazwa`) VALUES
(1, 'Podstawy sortowania'),
(2, 'Algorytmy sortujące'),
(3, 'Bubble sort'),
(4, 'Insertion sort'),
(5, 'Selection sort'),
(6, 'Merge sort'),
(7, 'Quick sort');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `postepy`
--

CREATE TABLE `postepy` (
  `id_postepu` int(11) NOT NULL,
  `id_uzytkownika` int(11) NOT NULL,
  `id_kategorii` int(11) NOT NULL,
  `ilosc_poprawnych` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `postepy`
--

INSERT INTO `postepy` (`id_postepu`, `id_uzytkownika`, `id_kategorii`, `ilosc_poprawnych`) VALUES
(19, 1, 1, 9);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pytania`
--

CREATE TABLE `pytania` (
  `id_pytania` int(11) NOT NULL,
  `id_kategorii` int(11) NOT NULL,
  `tresc` varchar(500) NOT NULL,
  `odpa` varchar(200) NOT NULL,
  `odpb` varchar(200) NOT NULL,
  `odpc` varchar(200) NOT NULL,
  `odpd` varchar(200) NOT NULL,
  `poprawna` char(1) NOT NULL,
  `wyjasnienie` varchar(1500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `pytania`
--

INSERT INTO `pytania` (`id_pytania`, `id_kategorii`, `tresc`, `odpa`, `odpb`, `odpc`, `odpd`, `poprawna`, `wyjasnienie`) VALUES
(1, 1, 'Czym jest operacja swap?', 'Jest to proces zamiany dwóch elementów miejscami.', 'Jest to proces wybierania nowego elementu osiowego.', 'Jest to proces alokowania nowej komórki pamięci, w której algorytm będzie przechowywał element.', 'Jest to pojedyncze przeiterowanie przez całą wielkość sortowanej tablicy.', 'A', 'Operacja swap (ang. zamiana) - w kontekście algorytmów sortujących jest to operacja zamieniająca dwa elementy miejscami w tablicy.'),
(2, 1, 'Czym charakteryzuje się rekurencyjny algorytm sortujący?', 'Algorytm do poprawnego sortowania nie potrzebuje używać operacji zamiany.', 'Algorytm sprawdza, czy podczas pojedynczej iteracji w tablicy zostały wykonane zmiany. Jeżeli nie - kończy sortowanie.', 'Do poprawnego działania wymagane jest wykorzystanie wskaźników w kodzie takiego algorytmu.', 'Do wykonania sortowania wykorzystana jest funkcja wywołująca sama siebie.', 'D', 'Rekurencyjny algorytm sortujący polega na wykorzystaniu rekurencji, czyli odwoływania się funkcji do samej siebie.'),
(3, 1, 'Które z podanych zdań jest fałszywe?', 'Nie istnieje jeden algorytm zdolny do radzenia sobie najlepiej w każdej sytuacji.', 'Najlepszą możliwą do osiągnięcia złożonością obliczeniową jakiegokolwiek algorytmu jest O(n).', 'Wartość elementów znacznie wpływa na złożoność obliczeniową algorytmu.', 'Podczas obliczania złożoności najważniejszy jest czynnik funkcji, którego wzrost wpłynie na wynik najbardziej.', 'C', 'Wartość elementów nie ma wpływu na złożoność obliczeniową algorytmu, ponieważ algorytm bierze pod uwagę jedynie to czy wartość elementu jest większa czy mniejsza od wartości drugiego. Na złożoność obliczeniową wpływają czynniki, które zwiększają ilość operacji (porównanie, zamiana) wymaganych do zakończenia sortowania. Takim czynnikiem może być np. ilość elementów w zadanej tablicy.'),
(4, 1, 'Która złożoność obliczeniowa jest najbardziej korzystna spomiędzy wszystkich podanych?', 'O(2^n)', 'O(n!)', 'O(n*log(n))', 'O(n^2)', 'C', 'Kolejność podanych złożoności od najgorszej do najlepszej: O(n!) -> O(2^n) -> O(n^2) -> O(n*log(n)).'),
(5, 1, 'Jeżeli algorytm sortujący wykonuje operacje zamiany, do których wymaga utworzenia zmiennej pomocniczej, w której tymczasowo przechowa jeden z zamienianych elementów, to znaczy że złożoność pamięciowa takiego algorytmu wynosi:', 'O(1)', 'O(n)', 'O(n^2)', 'O(log(n))', 'A', 'Jeżeli algorytm wykorzystuje jedynie jedną zmienną pomocniczą niezależnie od wielkości tablicy, to złożoność pamięciowa algorytmu jest stała i oznacza się ją jako O(1).'),
(6, 1, 'Jeżeli algorytm sortujący wymaga utworzenia tablicy pomocniczej w której, na pewnym etapie, przechowa wszystkie elementy tablicy wejściowej, to znaczy że całkowita złożoność pamięciowa takiego algorytmu wynosi co najmniej:', 'O(1)', 'O(n)', 'O(n^2)', 'O(log(n))', 'B', 'Jeżeli algorytm musi utworzyć pomocniczą tablicę w której będą musiały się zmieścić wszystkie elementy tablicy wejściowej, to znaczy że tablica pomocnicza jest takiej samej wielkości jak tablica wejściowa. To oznacza, że w tym przypadku pomocnicza złożoność pamięciowa jest zależna od ilości elementów w tablicy. Jako że złożoność pomocnicza wchodzi w skład złożoności całkowitej, to złożoność pamięciowa całkowita wyniesie co najmniej O(n).'),
(7, 1, 'Czym charakteryzuje się stabilny algorytm sortujący?', 'Złożoność obliczeniowa takiego algorytmu wynosi O(log(n)) lub lepiej.', 'Algorytm jest przystosowany do posortowania każdego typu danych.', 'Algorytm zachowa oryginalną kolejność elementów o tej samej wartości.', 'Algorytm nie potrzebuje alokowania dodatkowej pamięci do przeprowadzenia sortowania.', 'C', 'Stabilność w algorytmach sortujących cechuje się tym, że elementy o tej samej wartości nie zmienią swojej kolejności względem siebie po posortowaniu.'),
(8, 1, 'Który z podanych zapisów notacji dużego O oznacza złożoność liniową?', 'O(1)', 'O(n)', 'O(n^2)', 'O(n!)', 'B', 'Złożoność liniowa cechuje się tym, że wzrasta liniowo proporcjonalnie do ilości elementów tablicy początkowej, czyli n elementów da nam złożoność o wartości O(n).'),
(9, 1, 'Istnieje zestaw czterech kart:<br/>\r\n<img src=\'../img/quiz_img/7-playing_cards.jpg\' alt=\'playing-cards.jpg\' class=\'mx-auto img-fluid\'/><br/>\r\nW jakiej kolejności znajdą się karty posortowane stabilnym algorytmem sortującym?', 'I, II, III, IV', 'IV, II, III, I', 'III, IV, I, II', 'III, I, IV, II', 'D', 'Stabilny algorytm po posortowaniu zachowa oryginalną kolejność elementów o tej samej wartości. W sytuacji zadanej w pytaniu mamy dwie karty o wartości pięć oraz o różnych kolorach. Pierwsza występująca w zbiorze piątka jest koloru czerwonego, druga jest koloru czarnego. Stabilny algorytm musi zachować tę kolejność w wyniku swoich operacji.'),
(15, 7, 'Istnieją dwie tablice: {1, 2, 3, 4, 5} oraz {4, 1, 5, 3, 2}, które będą posortowane algorytmem Sortowania szybkiego, który za element osiowy obiera pierwszy element listy. Przyjmijmy że t1 oraz t2 to jest liczba porównań, które algorytm wykona przy sortowaniu odpowiednio tablicy pierwszej oraz drugiej. Które z podanych stwierdzeń jest prawdziwe?', 't1 = 5', 't1 < t2', 't1 > t2', 't1 = t2', 'C', 'Kiedy Sortowanie szybkie wybiera pierwszy lub ostatni element jako element osiowy, a tablica jest już wstępnie posortowana, oznacza to najgorszy przypadek dla tego algorytmu.'),
(16, 1, 'Czym są algorytmy sortujące online?', 'Jest to nazwa na algorytmy, które w obecnym czasie przeprowadzają sortowanie.', 'Są to algorytmy, które wykonują operacje sortowania w chmurze w celu zaoszczędzenia lokalnych zasobów.', 'Są to algorytmy, podczas których działania można do tablicy dołączać nowe elementy i one też zostaną posortowane.', 'Są to algorytmy, których kod źródłowy nie jest objęty prawem autorskim i można je swobodnie wykorzystać bez licencji.', 'C', 'Jeżeli algorytm sortujący jest online, oznacza to że do sortowanej tablicy można wkładać kolejne, nowe elementy, nawet kiedy algorytm w obecnej chwili przeprowadza operacje. Mimo że w takiej sytuacji tablica nie będzie miała stałej wielkości, to i tak algorytm będzie w stanie ustawić wszystkie elementy w odpowiedniej kolejności.'),
(17, 7, 'Losowane Sortowanie szybkie jest rozszerzeniem algorytmu Sortowania szybkiego, w którym element osiowy jest wybierany całkowicie losowo spośród nieposortowanych elementów. Ile wyniesie najgorszy przypadek takiego algorytmu przy sortowaniu tablicy o n elementach?', 'O(n)', 'O(n*log(n))', 'O(n^2)', 'O(n!)', 'C', 'Typowy przypadek złożoności obliczeniowej dla algorytmu losowanego Sortowania szybkiego wynosi O(n*log(n)), ale najgorszy przypadek pozostaje niezmienny od podstawowej implementacji tego algorytmu. W najgorszym przypadku funkcja losująca kolejny element osiowy może wybrać niekorzystny element tak samo jak może to zrobić funkcja wybierająca element osiowy w nielosowy sposób.'),
(18, 7, 'Posortowanie 1000 nazwisk zajmuje komputerowi minimum 100 sekund przy użyciu algorytmu Sortowania szybkiego. Minimalny czas potrzebny by posortować 100 nazwisk wyniesie około:', '50.2 sekund', '6.7 sekund', '10 sekund', '66.7 sekund', 'B', 'W zadaniu mowa o minimalnym czasie, więc bierzemy pod uwagę najlepszy przypadek dla algorytmu Sortowania szybkiego, który wynosi O(n*log(n)). Obliczenia wyglądają w sposób następujący:\r\n<div class=\'border border-dark p-1 mt-1\' style=\'font-family: Consolas; background-color: #ededed;\'>\r\nt1 = 100 sekund -> czas potrzebny do posortowania 1000 nazwisk<br/>\r\nt2 = x sekund -> czas potrzebny do posortowania 100 nazwisk<br/>\r\n<br/>\r\nn1 = 1000 -> ilość nazwisk w pierwszym sortowaniu<br/>\r\nn2 = 100 -> ilość nazwisk w drugim sortowaniu<br/>\r\n<br/>\r\nt1/t2 = n1*log(n1) / n2*log(n2) -> Podstawienie liczb<br/>\r\n100/t2 = 1000 * log(1000) / 100 * log(100) -> Skrócenie zer<br/>\r\n100/t2 = 10 * log(1000) / log(100) -> obliczenie logarytmów<br/>\r\n100/t2 = 10 * 3 / 2 -> Podzielenie obu stron przez 10<br/>\r\n10/t2 = 3/2 -> Wymnożenie mianowników przez liczniki<br/>\r\n3 * t2 = 20 -> Podzielenie obu stron przez 3<br/>\r\nt2 = 20/3 = 6.66\r\n</div>'),
(19, 7, 'Która z metod wybierania elementu osiowego w algorytmie Sortowania szybkiego całkowicie eliminuje możliwość wystąpienia złożoności obliczeniowej wynoszącej O(n^2)?', 'Element osiowy jako pierwszy element tablicy', 'Element osiowy jako ostatni element tablicy', 'Element osiowy jako losowo wybrany element', 'Element osiowy jako mediana obliczana spomiędzy pierwszego, środkowego oraz ostatniego elementu listy', 'D', 'Rozważmy sytuację gdy początkowa tablica jest całkowicie posortowana, niezależnie od tego czy rosnąco czy malejąco. W takim przypadku algorytm Sortowania szybkiego, który wybiera element osiowy z początku lub z końca listy będzie wybierał kolejno najmniejsze lub największe elementy. Kiedy Sortowanie szybkie za każdym razem wybiera najmniejszy lub największy element listy jako element osiowy, jest z góry skazany na przeprowadzenie operacji w najgorszym możliwym czasie, czyli O(n^2).<br/>\r\n<br/>\r\nJeżeli jednak element osiowy będzie wybierany losowo, znacznie zmniejszają się szanse, że wybrany element będzie którymś z brzegu. Mimo to, jeżeli losowanie będzie bardzo pechowe, to i tak za każdym razem jako element osiowy będzie wybierany najmniejszy lub największy element, więc możliwość wystąpienia złożoności obliczeniowej wynoszącej O(n^2) nie jest całkowicie wyeliminowana.<br/>\r\n<br/>\r\nDopiero gdy elementem osiowym jest mediana z trzech elementów, gwarantuje to sytuację że nigdy nie stanie się nim element z brzegu, co eliminuje możliwość wystąpienia złożoności O(n^2).'),
(20, 7, 'Istnieje tablica ośmiu elementów: {4, 5, 3, 6, 10, 20, 18, 15}\r\nTablica jest sortowana za pomocą Sortowania szybkiego. Właśnie zakończone zostało pierwsze partycjonowanie. Które elementy mogły być elementem osiowym podczas tego partycjonowania?', '6 lub 10', '6, ale nie 10', '10, ale nie 6', 'Ani 6, ani 10', 'A', 'Elementy 6 oraz 10 są na swoich poprawnych pozycjach względem reszty elementów. Co więcej - elementy na lewo od 6 są mniejsze, a na prawo są większe. Taka sama sytuacja występuje z elementem 10. Daje nam to podejrzenie, że zarówno element 6 jak i 10 mogły być elementem osiowym podczas tego partycjonowania.'),
(21, 7, 'Jakiej metody używa Sortowanie szybkie w trakcie sortowania?', 'Wymieniania', 'Partycjonowania', 'Selekcji', 'Scalania', 'B', 'Sortowanie szybkie w ramach sortowania dzieli tablicę na podtablice używając do tego pojedynczego elementu zwanego elementem osiowym, wokół którego orientuje resztę tablicy. Proces ten nazywany jest partycjonowaniem.'),
(22, 7, 'Który z podanych modeli algorytmów jest wykorzystywany w Sortowaniu szybkim?', 'Algorytm Zachłanny', 'Algorytm z Nawrotami', 'Programowanie Dynamiczne', 'Algorytm Dziel i Rządź', 'D', 'Sortowanie szybkie wykorzystuje paradygmat \"Dziel i Rządź\" by posortować elementy. Spomiędzy elementów w tablicy wybierany jest jeden element osiowy, wokół którego tablica dzielona jest na dwie podtablice. Kolejno spośród elementów w podtablicy wybierany jest kolejny element osiowy, a podtablica ponownie jest dzielona na dwie jeszcze mniejsze podtablice do momentu, aż rozmiar podtablicy osiągnie wielkość 1, w którym to momencie elementy są ustawione na swoich właściwych miejscach.'),
(23, 7, 'Które z podanych zdań jest prawdziwe o Sortowaniu szybkim?', 'Sortowanie szybkie jest algorytmem stabilnym.', 'Wybieranie ostatniego elementu jako element osiowy jest najbardziej optymalne.', 'Złożoność obliczeniowa w typowym przypadku wynosi O(n^2)', 'Sortowanie szybkie może występować w postaci iteracyjnej', 'D', 'Algorytm Sortowania szybkiego jest najbardziej powszechny w postaci rekurencyjnej, ale istnieje wersja tego algorytmu wykorzystująca podejście iteracyjne.'),
(24, 7, 'Które z podanych zdań jest fałszywe o Sortowaniu szybkim?', 'Sortowanie szybkie jest algorytmem in-place.', 'Ilość razy kiedy jakikolwiek element jest wybrany jako osiowy jest zawsze mniejsza lub równa ilości elementów tablicy.', 'Sortowanie szybkie jest dobrym wyborem w przypadku sortowania zbiorów o sporej ilości elementów.', 'Złożoność obliczeniowa w przypadku najlepszym oraz typowym jest taka sama.', 'C', 'Złożoność obliczeniowa w typowym przypadku algorytmu Sortowania szybkiego wynosi O(n*log(n)), co czyni go jednym z najlepszych wyborów jeżeli chodzi o sortowanie zbiorów, lecz przy zbiorach sporej wielkości jego wydajność zmniejsza się znacznie w porównaniu z innymi algorytmami, takimi jak np. Sortowanie przez scalanie.'),
(25, 7, 'Ile wynosi całkowita złożoność pamięciowa w najgorszym przypadku algorytmu Sortowania szybkiego dla tablicy o ilości elementów n?', 'O(n^2)', 'O(n)', 'O(log(n))', 'O(1)', 'B', 'Mimo że Sortowanie szybkie nie tworzy podczas sortowania pomocniczych struktur danych, to całkowita złożoność pamięciowa jest większa niż O(1). Jest to spowodowane faktem użycia rekursji.<br/>\r\n<br/>\r\nGdy tablica jest podzielona na dwie podtablice, algorytm zajmie się tylko jedną z dwóch stron, a drugą zachowa sobie na przyszłość. Algorytm musi przechować gdzieś informacje o zachowanej podtablicy, a to zajmuje pamięć.'),
(26, 6, 'Który z podanych modeli algorytmów jest wykorzystywany w Sortowaniu przez scalanie?', 'Algorytm Zachłanny', 'Algorytm z Nawrotami', 'Programowanie Dynamiczne', 'Algorytm Dziel i Rządź', 'D', 'Sortowanie przez scalanie wykorzystuje paradygmat \"Dziel i Rządź\" by posortować elementy. Tablica zostaje rekursywnie dzielona na dwie połowy, zwane podtablicami, do momentu aż podtablice będą rozmiaru jednego elementu. W momencie kiedy wszystkie elementy są pojedynczo rozdzielone, rozpoczyna się proces scalania, który zaczyna scalać podtablice do momentu, w którym wszystkie podtablice złączą się w jedną.'),
(27, 6, 'Pomocnicza złożoność pamięciowa dla typowej implementacji algorytmu Sortowania przez scalanie to:', 'O(1)', 'O(log(n))', 'O(n)', 'O(n*log(n))', 'C', 'Sortowanie przez scalanie, do poprawnego działania, wymaga utworzenia tablicy pomocniczej o wielkości takiej samej jak ilość elementów tablicy wejściowej, stąd jego pomocnicza złożoność pamięciowa to O(n).'),
(28, 6, 'Istnieje tablica sortowana przez algorytm Sortowania przez scalanie. Algorytm jest w trakcie ostatniego scalania, więc tablica jest w postaci dwóch posortowanych podtablic. Pierwsza podtablica jest wielkości n, druga wielkości m. Ile porównań zajmie algorytmowi scalenie dwóch podtablic w najgorszym wypadku?', 'n * m', 'Większa liczba spomiędzy n oraz m', 'Mniejsza liczba spomiędzy n oraz m', 'n + m - 1', 'D', 'W najgorszym przypadku potrzeba n + m - 1 porównań do scalenia dwóch podtablic o rozmiarach n oraz m.'),
(29, 6, 'Istnieje tablica o podanych elementach: {6, 8, 5, 2, 3, 4, 7, 1}<br/>\r\nJak będzie wyglądać tablica po drugim scaleniu podczas działania algorytmu Sortowania przez scalanie?', '6, 8, 5, 2, 3, 4, 7, 1', '6, 8, 2, 5, 3, 4, 1, 7', '2, 5, 6, 8, 1, 3, 4, 7', '1, 2, 3, 4, 5, 6, 7, 8', 'C', 'Pierwsze scalenie posortuje sąsiednie pary, czyli {6, 8}, {5, 2}, {3, 4} oraz {7, 1}, czego wynikiem będzie tablica jaka widnieje w odpowiedzi B.<br/>\r\nDrugie scalenie posortuje sąsiednie pary podtablic utworzonych po pierwszym scalaniu, czyli [{6, 8}, {2, 5}] oraz [{3, 4}, {1, 7}], co da nam rezultat widoczny w odpowiedzi C.'),
(30, 6, 'Które z podanych zdań jest prawdziwe o typowej implementacji algorytmu Sortowania przez scalanie?', 'Złożoność obliczeniowa w najlepszym, typowym oraz najgorszym przypadku jest jednakowa', 'Najmniejszy rozmiar podtablicy po podzieleniu na podtablice nie może być mniejszy niż 2', 'Sortowanie przez scalanie jest algorytmem in-place', 'Sortowanie przez scalanie nie jest rekurencyjnym algorytmem', 'A', 'Najlepszy, typowy oraz najgorszy przypadek w algorytmie Sortowania przez scalanie posiada złożoność obliczeniową o wartości O(n*log(n)).'),
(31, 6, 'Które z podanych zdań jest fałszywe o typowej implementacji Sortowania przez scalanie?', 'Najgorszy przypadek Sortowania przez scalanie zostanie posortowany w czasie O(n*log(n))', 'Sortowana tablica może być powiększana o nowe elementy w momencie gdy Sortowanie przez scalanie jest w procesie sortowania', 'Sortowanie przez scalanie jest algorytmem, którego czas sortowania jest praktycznie taki sam dla tablic o tej samej liczbie elementów', 'Sortowanie przez scalanie jest stabilnym algorytmem', 'B', 'Sortowanie przez scalanie nie jest algorytmem online. Algorytm ten musi znać wielkość tablicy do poprawnego działania a wielkość ta musi być stała i niezmienna przez cały proces sortowania.'),
(32, 6, 'Istnieje tablica, której elementy są posortowane w odwrotnej kolejności. Jaka będzie złożoność obliczeniowa dla tego przypadku jeżeli do sortowania użyje się algorytmu Sortowania przez scalanie?', 'O(log(n))', 'O(n)', 'O(n*log(n))', 'O(n^2)', 'C', 'Niezależnie od początkowego ustawienia elementów w tablicy, Sortowanie przez scalanie zawsze posortuje ją w czasie O(n*log(n)).'),
(33, 6, 'W którym z przypadków użycie Sortowania przez scalanie jest prawidłowym wyborem?', 'Kiedy ilość elementów jest duża, a pamięć ograniczona', 'Kiedy oryginalna kolejność elementów o tej samej wartości musi być zachowana', 'Kiedy użycie dodatkowej pamięci nie jest wskazane', 'Kiedy początkowa tablica jest prawie posortowana', 'B', 'Sortowanie przez scalanie jest algorytmem stabilnym, więc zachowa oryginalną kolejność elementów o tej samej wartości.'),
(34, 6, 'Jakiej techniki używa algorytm Sortowania przez scalanie w celu sortowania?', 'Partycjonowania', 'Scalania', 'Selekcji', 'Wymieniania', 'B', 'Scalanie w kontekście algorytmu sortującego jest to proces łączenia kilku podzbiorów w jeden.'),
(35, 6, 'Ile wynosi złożoność obliczeniowa dla najlepszego, typowego oraz najgorszego przypadku Sortowania przez scalanie?', 'O(n*log(n)), O(n*log(n)), O(n^2)', 'O(n), O(n^2), O(n^2)', 'O(n*log(n)), O(n*log(n)), O(n*log(n))', 'O(n), O(n*log(n)), O(n^2)', 'C', 'Złożoności obliczeniowe dla wszystkich przypadków Sortowania przez scalanie są identyczne i wynoszą O(n*log(n)).'),
(36, 2, 'Podane są algorytmy Sortowania szybkiego, Heap sort i Sortowania przez scalanie. Najgorszy przypadek których z tych algorytmów jest najmniejszy?', 'Sortowanie szybkie oraz Heap sort.', 'Heap sort oraz Sortowanie przez scalanie.', 'Tylko Sortowanie szybkie.', 'Wszystkie z podanych mają równy czas w najgorszym przypadku.', 'B', 'Najgorszy przypadek dla Heap sort oraz Sortowania przez scalanie wynosi O(n*log(n)), podczas gdy dla Sortowania szybkiego wynosi O(n^2).'),
(37, 2, 'Istnieje tablica, która jest w większości posortowana, lecz po ostatnim posortowanym elemencie stoi kilka elementów o losowej wartości. Który z podanych algorytmów poradzi sobie z posortowaniem takiej tablicy najlepiej?', 'Sortowanie bąbelkowe', 'Sortowanie przez wybór', 'Sortowanie szybkie', 'Sortowanie przez wstawianie', 'D', 'Dla posortowanej tablicy z kilkoma losowymi elementami Sortowanie bąbelkowe, przez wybór oraz szybkie zajmie O(n^2) czasu, a Sortowanie przez wstawianie zajmie O(n) czasu.'),
(38, 2, 'Jaka jest kolejność podanych algorytmów względem czasu w ich najlepszym przypadku?', 'Sortowanie szybkie > Sortowanie przez wstawianie > Sortowanie przez wybór', 'Sortowanie przez wybór > Sortowanie szybkie > Sortowanie przez wstawianie', 'Sortowanie szybkie > Sortowanie przez wybór > Sortowanie przez wstawianie', 'Sortowanie przez wstawianie > Sortowanie przez wybór > Sortowanie szybkie', 'B', 'Najlepsze przypadki dla podanych algorytmów:<br/>\r\nSortowanie szybkie: O(n*log(n))<br/>\r\nSortowanie przez wstawianie: O(n)<br/>\r\nSortowanie przez wybór: O(n^2)'),
(39, 2, 'Jaki algorytm będzie najbardziej wydajny jeżeli należy posortować tablicę o ilości elementów przekraczającej milion?', 'Sortowanie przez wybór', 'Sortowanie bąbelkowe', 'Sortowanie szybkie', 'Sortowanie przez wstawianie', 'C', 'Sortowanie szybkie, jako jedyne z podanych, posiada typowy przypadek wynoszący jedynie O(n*log(n)), kiedy pozostałych wynosi O(n^2). Istnieje też możliwość użycia Sortowania szybkiego w wersji losowanej, która losowo wybiera element osiowy w celu wyeliminowania możliwości zaistnienia najgorszego przypadku w sytuacji, gdyby tablica jest wstępnie posortowana lub odwrotnie posortowana.'),
(40, 2, 'Dla listy o wielkości n który z algorytmów wykona w najgorszym przypadku dokładnie n zamian?', 'Sortowanie szybkie', 'Sortowanie przez wstawianie', 'Sortowanie przez wybór', 'Heap sort', 'C', 'Algorytm Sortowania przez wybór wykonuje jedną operację zamiany na pojedynczą iterację, jeżeli znaleziony element minimalny nie jest na odpowiednim miejscu. Więc po wszystkich n iteracjach zostanie wykonanych n zamian.'),
(41, 2, 'Złożoność obliczeniowa w najgorszym przypadku dla algorytmów Sortowania przez wstawianie, przez scalanie oraz szybkiego wynoszą kolejno:', 'O(n*log(n)), O(n*log(n)), O(n^2)', 'O(n^2), O(n^2), O(n*log(n))', 'O(n^2), O(n*log(n)), O(n*log(n))', 'O(n^2), O(n*log(n)), O(n^2)', 'D', 'Wszystkie przypadki podanych algorytmów, w kolejności najlepszy -> typowy -> najgorszy wyglądają następująco:<br/>\r\nSortowanie przez wstawianie: O(n) -> O(n^2) -> O(n^2)<br/>\r\nSortowanie przez scalanie: O(n*log(n)) -> O(n*log(n)) -> O(n*log(n))<br/>\r\nSortowanie szybkie: O(n*log(n)) -> O(n*log(n)) -> O(n^2)'),
(42, 2, 'Istnieje tablica wejściowa, która jest już posortowana w rosnącej kolejności. Jeżeli podane poniżej algorytmy w swojej typowej implementacji mają za zadanie posortować taką tablicę również w rosnącej kolejności, to które z poniższych zdań jest prawdziwe?<br/>\r\nI. Sortowanie szybkie zajmie O(n^2) czasu.<br/>\r\nII. Sortowanie bąbelkowe zajmie O(n^2) czasu.<br/>\r\nIII. Sortowanie przez scalanie zajmie O(n) czasu.<br/>\r\nIV. Sortowanie przez wstawianie zajmie O(n) czasu.', 'I oraz II', 'I oraz III', 'II oraz IV', 'I oraz IV', 'D', 'Sortowanie szybkie działa najgorzej, gdy za element osiowy obierany jest element o minimalnej lub maksymalnej wartości spośród elementów tablicy. Dokładnie tak jest kiedy tablica jest posortowana, a element osiowy jest zawsze skrajnym elementem listy, więc zdanie I jest prawdziwe.<br/>\r\nSortowanie bąbelkowe działa najlepiej, gdy wejściowa tablica jest już posortowana. Jeżeli po pierwszej iteracji, w której porównywane są wszystkie elementy, nie nastąpi żadna operacja zamiany, to algorytm kończy pracę gdyż wykrył posortowany stan tablicy. Złożoność obliczeniowa w takim przypadku wyniesie O(n), więc zdanie II jest nieprawdziwe.<br/>\r\nSortowanie przez scalanie sortuje każdą tablicę w jednakowym czasie, czyli O(n*log(n)), niezależnie od ułożenia elementów. Zdanie III jest więc nieprawdziwe.<br/>\r\nSortowanie przez wstawianie kolejno sprawdza, czy następny element jest mniejszy od poprzedniego. W przypadku posortowanej tablicy taka sytuacja nie zaistnieje, więc algorytm nie wykona żadnej operacji zamiany. Stąd złożoność w takim przypadku wyniesie O(n), więc IV zdanie jest prawdziwe.'),
(43, 2, 'Który z algorytmów wykonuje tylko jedną operację zamiany na pojedyncze przejście?', 'Sortowanie szybkie', 'Sortowanie przez wstawianie', 'Sortowanie bąbelkowe', 'Sortowanie przez wybór', 'D', 'Sortowanie przez wybór działa na zasadzie przejścia przez wszystkie elementy tablicy i wytypowanie najmniejszego elementu spośród nich. Gdy zakończy przejście i znajdzie najmniejszy element, dopiero wtedy wykonuje zamianę z pierwszym elementem nieposortowanej listy.'),
(44, 2, 'Podana jest tablica: {7, 9, 1, 5, 3, 8}, która jest sortowana nieznanym algorytmem. Tablica po pierwszym oraz drugim przejściu algorytmu wygląda następująco:<br/>\r\nI: {7, 1, 5, 3, 8, 9}<br/>\r\nII: {1, 5, 3, 7, 8, 9}<br/>\r\nKtóry algorytm jest wykorzystywany do sortowania tej tablicy?', 'Sortowanie przez wstawianie', 'Sortowanie szybkie', 'Sortowanie bąbelkowe', 'Sortowanie przez wybór', 'C', 'Na podanych przejściach można zaobserwować, że co przejście wypychany na koniec listy jest element o największej wartości, czyli dokładnie tak jak zachowuje się Sortowanie bąbelkowe.'),
(45, 2, 'Podana jest tablica: {2, 7, 9, 1, 4, 3}, która jest sortowana nieznanym algorytmem. Tablica po pierwszym oraz drugim przejściu algorytmu wygląda następująco:<br/>\r\nI: {2, 1, 3, 7, 4, 9}<br/>\r\nII: {1, 2, 3, 7, 4, 9}<br/>\r\nKtóry algorytm jest wykorzystywany do sortowania tej tablicy?', 'Sortowanie przez wstawianie', 'Sortowanie szybkie', 'Sortowanie bąbelkowe', 'Sortowanie przez wybór', 'B', 'Przy pierwszym przejściu można zauważyć, że element 3, który znajdował się na samym końcu, jest teraz w środku tablicy, a po lewo od niego są elementy mniejsze oraz na prawo większe. Sugeruje to, że element 3 był przy pierwszym przejściu elementem osiowym, co sugeruje że został użyty algorytm Sortowania szybkiego. Przejście drugie potwierdza tę teorię, gdyż elementy na lewo od 3 zostały posortowane, natomiast elementy na prawo jeszcze nie.'),
(46, 3, 'W jakim czasie zostanie posortowana podana tablica, jeżeli sortowanie bąbelkowe będzie ją sortować malejąco?<br/>\r\n{9, 8, 7, 6, 4, 3, 1}', 'O(1)', 'O(n)', 'O(n*log(n))', 'O(n^2)', 'B', 'Podana w pytaniu tablica znajduje się w takim ułożeniu, że sortujące malejąco Sortowanie bąbelkowe posegreguje ją w czasie o wartości najlepszego przypadku, czyli O(n).'),
(47, 3, 'Jaka jest złożoność obliczeniowa w najlepszym przypadku Sortowania bąbelkowego?', 'O(n^2)', 'O(n*log(n))', 'O(n)', 'O(n*log(n))^2', 'C', 'Najlepszy przypadek Sortowania bąbelkowego występuje wtedy, gdy tablica jest już posortowana. Wtedy algorytm wystarczy że wykona jedno przejście przez wszystkie elementy i jeżeli nie wykona żadnej zamiany elementów, zakończy działanie. Stąd jego złożoność obliczeniowa w najlepszym przypadku to O(n).'),
(48, 3, 'Przyjmijmy że algorytm Sortowania bąbelkowego jest użyty do posortowania n elementów w malejącej kolejności. Kiedy wystąpi najlepszy przypadek dla algorytmu tego algorytmu?', 'Kiedy elementy są posortowane rosnąco.', 'Kiedy elementy są posortowane malejąco.', 'Kiedy elementy są w losowej kolejności.', 'Sortowanie bąbelkowe nie posiada najlepszego przypadku, bo zawsze sortuje w czasie O(n^2).', 'B', 'Jeżeli tablica jest posortowana malejąco, a Sortowanie bąbelkowe ma za zadanie posortować ją również malejąco, to nie wykona żadnych operacji zamiany. Jeżeli przy pojedynczym przejściu nie zostaną wykonane żadne zamiany elementów, algorytm kończy pracę.'),
(49, 3, 'W ilu przejściach zostanie posortowana ta tablica podczas sortowania algorytmem Sortowania bąbelkowego?<br/>\r\n{2, 1, 6, 9, 4, 5, 8, 3}', '5', '6', '7', '8', 'B', 'Przejścia tego algorytmu będą wyglądać następująco:<br/>\r\nI: {1, 2, 6, 4, 5, 8, 3, 9}<br/>\r\nII: {1, 2, 4, 5, 6, 3, 8, 9}<br/>\r\nIII: {1, 2, 4, 5, 3, 6, 8, 9}<br/>\r\nIV: {1, 2, 4, 3, 5, 6, 8, 9}<br/>\r\nV: {1, 2, 3, 4, 5, 6, 8, 9}<br/>\r\nVI: {1, 2, 3, 4, 5, 6, 8, 9}<br/>\r\nPowodem, dla którego dwa ostatnie przejścia wyglądają identycznie, jest fakt, że algorytm podczas ostatniego przejścia musiał zweryfikować, czy elementy 1 oraz 2 są na odpowiednich miejscach. Na etapie VI wykrył, że nie odbyła się żadna zamiana elementów, dlatego zakończył działanie.'),
(50, 3, 'Które z podanych zdań na temat Sortowania bąbelkowego jest fałszywe?', 'Sortowanie bąbelkowe jest bardzo małym i prostym algorytmem.', 'Typowy przypadek Sortowania bąbelkowego jest prawie zawsze zbliżony do najgorszego.', 'Sortowanie bąbelkowe jest stabilnym algorytmem.', 'Sortowanie bąbelkowe powinno być wykorzystywane jedynie do dużych zbiorów.', 'D', 'Ilość operacji jakich wymaga ten algorytm rośnie kwadratowo wraz z ilością elementów zbioru. Oznacza to, że algorytm ten będzie bardzo nieefektywny przy dużych zbiorach.'),
(51, 3, 'Istnieje tablica o podanych elementach: {9, 3, 5, 6, 4, 8, 7, 1}. W jakim czasie posortuje ją algorytm Sortowania bąbelkowego?', 'O(n)', 'O(n*log(n))', 'O(n^2)', 'O(n!)', 'C', 'Tablica jest w zupełnie losowej kolejności, więc jest to przypadek typowy. Złożoność obliczeniowa w typowym przypadku wynosi O(n^2).'),
(52, 3, 'Co zawiera struktura typowej reprezentacji algorytmu Sortowania bąbelkowego?', 'Dwie pętle for, z czego jedna jest zagnieżdżona w drugiej', 'Pojedynczą pętlę for wraz z instrukcją warunkową if wewnątrz', 'Pętla do while', 'Pojedynczą pętlę for', 'A', 'Pseudo kod podstawowej wersji algorytmu Sortowania bąbelkowego wygląda następująco:<br/>\r\n<div class=\'border border-dark p-1 mt-1\' style=\'font-family: Consolas; background-color: #ededed;\'>\r\nprocedure bubbleSort( A : lista elementów do posortowania )<br/>\r\n   n = liczba_elementów(A)<br/>\r\n   do<br/>\r\n     for (i = 0; i < n-1; i++) do:<br/>\r\n       if A[i] > A[i+1] then<br/>\r\n         swap(A[i], A[i+1])<br/>\r\n       end if<br/>\r\n     end for<br/>\r\n     n = n-1<br/>\r\n   while n > 1<br/>\r\nend procedure<br/>\r\n</div>'),
(53, 3, 'Jaka będzie liczba wykonanych przez Sortowanie bąbelkowe porównań w najgorszym przypadku dla tablicy o rozmiarze 5?', '5', '10', '25', '50', 'B', 'Największa możliwa ilość porównań w algorytmie Sortowania bąbelkowego wyrażana jest za pomocą następującego równania:<br/>\r\n<div class=\'border border-dark p-1 mt-1\' style=\'font-family: Consolas; background-color: #ededed;\'>\r\nSuma = n(n-1)/2<br/>\r\n</div><br/>\r\nPodstawienie 5 pod n da nam wynik:<br/>\r\n<div class=\'border border-dark p-1 mt-1\' style=\'font-family: Consolas; background-color: #ededed;\'>\r\nSuma = 5*(5-1)/2 = 5*4/2 = 20/2 = 10<br/>\r\nSuma = 10\r\n</div><br/>'),
(54, 3, 'Jaka jest złożoność obliczeniowa w typowym oraz najgorszym przypadku Sortowania bąbelkowego?', 'O(n*log(n)), O(n^2)', 'O(n), O(n*log(n))', 'Oba wynoszą O(n*log(n))', 'Oba wynoszą O(n^2)', 'D', 'W algorytmie Sortowania bąbelkowego typowy przypadek jest bardzo zbliżony do najgorszego, a oba wynoszą O(n^2).'),
(55, 3, 'Na czym polega mechanika działania algorytmu Sortowania bąbelkowego?', 'Na wytypowaniu najmniejszego elementu i zamienieniu go z pierwszym elementem listy', 'Na porównywaniu każdej kolejnej pary elementów i zamianie ich miejscami, jeżeli są w złej kolejności', 'Na dzieleniu tablicy na mniejsze podtablice i potem scalanie ich w odpowiedniej kolejności', 'Na wybraniu elementu osiowego i orientowaniu reszty tablicy względem niego', 'B', 'Odpowiedzi przedstawiają kolejno schemat działania następujących algorytmów:<br/>\r\nA: Sortowanie przez wybór<br/>\r\nB: Sortowanie bąbelkowe<br/>\r\nC: Sortowanie przez scalanie<br/>\r\nD: Sortowanie szybkie'),
(56, 5, 'Które z podanych modeli algorytmów jest wykorzystywany w Sortowaniu przez wybór?', 'Algorytm Zachłanny', 'Algorytm Dziel i Rządź', 'Programowanie Dynamiczne', 'Algorytm z Nawrotami', 'A', 'Sortowanie przez wybór wykonuje sortowanie poprzez znalezienie najmniejszego elementu z całej tablicy i ustawienie go na początku tablicy. Dokonuje on w ten sposób wyboru, który jest najlepszy w danej chwili - jest to paradygmat algorytmu zachłannego.'),
(57, 5, 'Ile algorytm Sortowania przez wybór wykona porównań, jeżeli sortuje tablicę 5 elementów znajdującą się już w posortowanym stanie?', '1', '5', '10', '50', 'C', 'Za przykład weźmy tablicę {1, 2, 3, 4, 5}. Podczas pierwszej iteracji element 1 będzie porównany z czteroma elementami. Podczas iteracji drugiej element 2 będzie porównany z trzema elementami. Podczas trzeciej iteracji - element 3 z dwoma. Oraz na końcu element 4 z jednym. W sumie liczba porównań będzie wynosić 4 + 3 + 2 + 1 = 10. Wzór na sumę porównań w algorytmie Sortowania przez wybór wygląda następująco:<br/>\r\n<div class=\'border border-dark p-1 mt-1\' style=\'font-family: Consolas; background-color: #ededed;\'>\r\nSuma = (1+(n-1)) * (n-1) / 2\r\n</div><br/>'),
(58, 5, 'Istnieje tablica {7, 8, 3, 2, 4, 1, 9, 6}. Jak będzie wyglądać tablica po pierwszej iteracji algorytmu Sortowania przez wybór?', '{7, 3, 2, 4, 1, 8, 6, 9}', '{1, 8, 3, 2, 4, 7, 9, 6}', '{3, 2, 4, 1, 6, 8, 9, 7}', '{7, 8, 2, 3, 1, 4, 6, 9}', 'B', 'Algorytm Sortowania przez wybór podczas pierwszej iteracji znajduje najmniejszy element spośród wszystkich elementów, po czym na koniec zamienia go z pierwszym elementem listy. Dokładnie taka sytuacja jest zaprezentowana w odpowiedzi B.<br/>\r\nOdpowiedź A prezentuje stan tablicy po pierwszej iteracji sortowania algorytmem Sortowania bąbelkowego, odpowiedź C - Sortowania szybkiego, a odpowiedź D - Sortowania przez scalanie.'),
(59, 5, 'Na czym polega mechanika działania algorytmu Sortowania przez wybór?', 'Na wytypowaniu najmniejszego elementu i zamienieniu go z pierwszym elementem listy', 'Na porównywaniu każdej kolejnej pary elementów i zamianie ich miejscami, jeżeli są w złej kolejności', 'Na dzieleniu tablicy na mniejsze podtablice i potem scalanie ich w odpowiedniej kolejności', 'Na wybraniu elementu osiowego i orientowaniu reszty tablicy względem niego', 'A', 'Odpowiedzi przedstawiają kolejno schemat działania następujących algorytmów:<br/>\r\nA: Sortowanie przez wybór<br/>\r\nB: Sortowanie bąbelkowe<br/>\r\nC: Sortowanie przez scalanie<br/>\r\nD: Sortowanie szybkie'),
(60, 5, 'Które zdanie spośród podanych jest zdaniem prawdziwym na temat Sortowania przez wybór?', 'Algorytm Sortowania przez wybór jest algorytmem stabilnym', 'Typowy oraz najgorszy przypadek Sortowania przez wybór ma jednakową złożoność obliczeniową', 'Podczas pojedynczej iteracji algorytmu Sortowania przez wybór występuje taka sama ilość porównań jak zamian elementów', 'Do prawidłowego działania algorytmu Sortowania przez wybór wymagane jest stworzenie tablicy pomocniczej', 'B', 'Najlepszy, typowy oraz najgorszy przypadek algorytmu Sortowania przez wybór ma wartość O(n^2).'),
(61, 5, 'Ile wynosi najlepszy, typowy oraz najgorszy przypadek algorytmu Sortowania przez wybór?', 'O(n), O(n*log(n)), O(n^2)', 'O(n*log(n)), O(n*log(n)), O(n^2)', 'O(n*log(n)), O(n*log(n)), O(n*log(n))', 'O(n^2), O(n^2), O(n^2)', 'D', 'Niezależnie od sposobu ułożenia elementów w tablicy, Sortowanie przez wybór dla każdego wykona tyle samo operacji porównania jak i zamiany. Każdy element w tablicy musi być porównany z każdym innym nieposortowanym elementem, co daje n*n operacji, więc każdy przypadek tego algorytmu wynosi O(n^2).'),
(62, 5, 'W przypadku sortowania n elementów w rosnącej kolejności algorytmem Sortowania przez wybór, kiedy wystąpi najlepszy przypadek dla tego algorytmu?', 'Kiedy elementy są posortowane rosnąco.', 'Kiedy elementy są posortowane malejąco.', 'Kiedy elementy są w losowej kolejności.', 'Sortowanie przez wybór nie posiada najlepszego przypadku, bo zawsze sortuje w czasie O(n^2).', 'D', 'Każdy przypadek algorytmu Sortowania przez wybór, nawet najlepszy, ma złożoność obliczeniową o wartości O(n^2).'),
(63, 5, 'Jaka jest pomocnicza złożoność pamięciowa algorytmu Sortowania przez wybór?', 'O(1)', 'O(n)', 'O(n*log(n))', 'O(n^2)', 'A', 'Sortowanie przez wybór nie wymaga tworzenia pomocniczych struktur danych do posortowania zbioru, więc jego pomocnicza złożoność pamięciowa wynosi O(1).'),
(64, 5, 'Przyjmij, że n to rozmiar tablicy sortowanej algorytmem Sortowania przez wybór. Na każdą iterację tego algorytmu przypada jaka ilość operacji zamiany?', '1', 'n - 1', 'n', 'n / 2', 'A', 'Algorytm podczas pojedynczej iteracji algorytmu Sortowania przez wybór ma za zadanie znaleźć najmniejszy element dzięki operacjom porównań oraz na końcu iteracji zamienić najmniejszy znaleziony element z pierwszym elementem nieposortowanej części listy. Stąd na jedną iterację przypada tylko jedna operacja zamiany.'),
(65, 5, 'Przyjmij, że n to rozmiar tablicy sortowanej algorytmem Sortowania przez wybór. Ile operacji zamiany wykona algorytm w najlepszym przypadku?', '0', '1', 'n - 1', 'n', 'A', 'Najlepszy przypadek dla Sortowania przez wybór występuje w momencie gdy tablica jest posortowana w odpowiedniej kolejności. W takim przypadku nie wykona się żadna operacja zamiany elementów, gdyż wszystkie są na odpowiednim miejscu.'),
(66, 4, 'Które z podanych zdań na temat Sortowania przez wstawianie jest prawdziwe?', 'Sortowanie przez wstawianie jest stabilny i online, ale nie jest przystosowany do przetworzenia dużej liczby elementów', 'Sortowanie przez wstawianie jest niestabilne, ale jest online', 'Sortowanie przez wstawianie jest online i jest efektywne przy sortowaniu zbioru posiadającego dużą liczbę elementów', 'Sortowanie przez wstawianie jest stabilne i online i jest efektywne przy sortowaniu zbioru posiadającego dużą liczbę elementów', 'A', 'Sortowanie przez wstawianie działa dobrze tylko przy tablicy o małej ilości elementów, ponieważ ilość operacji do wykonania wzrasta z kwadratem ilości elementów tablicy.'),
(67, 4, 'Istnieje tablica {1, 2, 3, 5, 6, 7, 8, 4} sortowana algorytmem Sortowania przez wstawianie. Tablica zdążyła już posortować elementy od 1 do 8 i za chwilę posortuje ostatni element o wartości 4. Ile porównań i zamian zajmie algorytmowi umiejscowienie elementu 4 na swoim miejscu?', '5 porównań, 4 zamiany', '4 porównania, 4 zamiany', '5 porównań, 5 zamian', '4 porównania, 5 zamian', 'A', 'Procedura umiejscowienia ostatniego elementu na swoim miejscu wygląda następująco:<br/>\r\nPorównanie z elementem 8 - element 4 jest mniejszy, więc zamiana<br/>\r\nPorównanie z elementem 7 - element 4 jest mniejszy, więc zamiana<br/>\r\nPorównanie z elementem 6 - element 4 jest mniejszy, więc zamiana<br/>\r\nPorównanie z elementem 5 - element 4 jest mniejszy, więc zamiana<br/>\r\nPorównanie z elementem 3 - element 4 jest większy, więc jest na prawidłowym miejscu'),
(68, 4, 'Istnieje tablica {95, 91, 78, 77, 58, 52, 41, 36, 30, 4}. Ile czasu zajmie algorytmowi Sortowania przez wstawianie posortowanie tej tablicy w malejącej kolejności?', 'O(log(n))', 'O(n)', 'O(n*log(n))', 'O(n^2)', 'B', 'Podana tablica to najlepszy przypadek dla tego algorytmu sortującego w malejącej kolejności. Algorytm zwyczajnie wykona n porównań oraz zakończy pracę, więc jego czas działania to O(n).'),
(69, 4, 'Istnieje tablica {14, 50, 87, 71, 7, 100, 27, 41, 68, 36}. Ile czasu zajmie algorytmowi Sortowania przez wstawianie posortowanie tej tablicy w rosnącej kolejności?', 'O(log(n))', 'O(n)', 'O(n*log(n))', 'O(n^2)', 'D', 'Elementy tej tablicy są ułożone losowo, więc tutaj należy spojrzeć na złożoność obliczeniową tego algorytmu w typowym przypadku, a wynosi ona O(n^2).'),
(70, 4, 'Które z podanych zdań na temat Sortowania przez wstawianie jest fałszywe?', 'Sortowanie przez wstawianie jest algorytmem in-place', 'Algorytm Sortowania przez wstawianie jest optymalnym do posortowania tablic jedynie częściowo posortowanych', 'Sortowanie przez wstawianie wymaga O(1) dodatkowej pamięci do przeprowadzenia sortowania', 'Liczba porównań wymagana do umieszczenia pojedynczego elementu na prawidłowym miejscu jest zawsze równa liczbie elementów w tablicy', 'D', 'Rozważmy sytuację, gdzie istnieje tablica {1, 2, 3, 4, 5, 6, 8, 9, 7}. Elementy od 1 do 9 są już posortowane i algorytm zamierza teraz posortować element o wartości 7 znajdujący się na ostatnim miejscu. Algorytm Sortowania przez wstawianie porówna go z elementem 9 i zamieni miejscami, następnie porówna z elementem 8 i zamieni miejscami. Na końcu porówna go z elementem 6 i zakończy pracę. Liczba porównań w tym przypadku to 3, czyli mniejsza niż ilość elementów.'),
(71, 4, 'Na czym polega mechanika działania algorytmu Sortowania przez wstawianie?', 'Na wytypowaniu najmniejszego elementu i zamienieniu go z pierwszym elementem listy', 'Na dzieleniu tablicy na mniejsze podtablice i potem scalanie ich w odpowiedniej kolejności', 'Na porównywaniu bieżącego elementu z elementem go poprzedzającym i przesuwaniu go w dół listy do momentu aż bieżący element napotka element mniejszy od siebie', 'Na porównywaniu każdej kolejnej pary elementów i zamianie ich miejscami, jeżeli są w złej kolejności', 'C', 'Odpowiedzi przedstawiają kolejno schemat działania następujących algorytmów:<br/>\r\nA: Sortowanie przez wybór<br/>\r\nB: Sortowanie przez scalanie<br/>\r\nC: Sortowanie przez wstawianie<br/>\r\nD: Sortowanie bąbelkowe'),
(72, 4, 'Co zawiera struktura typowej reprezentacji algorytmu Sortowania przez wstawianie?', 'Dwie pętle while, z czego jedna jest zagnieżdżona w drugiej', 'Dwie pętle for, z czego jedna jest zagnieżdżona w drugiej', 'Pojedynczą pętlę while', 'Pojedynczą pętlę for', 'A', 'Pseudo kod podstawowej wersji algorytmu Sortowania przez wstawianie wygląda następująco:<br/>\r\n<div class=\'border border-dark p-1 mt-1\' style=\'font-family: Consolas; background-color: #ededed;\'>\r\ni ← 1<br/>\r\nwhile i < length(A)<br/>\r\n    j ← i<br/>\r\n    while j > 0 and A[j-1] > A[j]<br/>\r\n        swap A[j] and A[j-1]<br/>\r\n        j ← j - 1<br/>\r\n    end while<br/>\r\n    i ← i + 1<br/>\r\nend while<br/>\r\n</div>'),
(73, 4, 'Ile wynosi najlepszy oraz najgorszy przypadek algorytmu Sortowania przez wstawianie?', 'O(n), O(n^2)', 'O(n), O(n*log(n))', 'O(n*log(n)), O(n^2)', 'O(n^2), O(n^2)', 'A', 'Najlepszy przypadek dla algorytmu Sortowania przez wstawianie istnieje gdy tablica jest już posortowana. Wtedy wystarczy że algorytm porówna wszystkie istniejące elementy by zakończył on pracę. Z kolei gdy tablica jest w odwrotnej kolejności, następuje najgorszy przypadek i algorytm wykona O(n^2) operacji.'),
(74, 4, 'Istnieje tablica {15, 5, 2, 20, 7}. Jak będzie wyglądać tablica po trzech pierwszych operacjach zamiany wykonanych podczas sortowania algorytmem Sortowania przez wstawianie?', '{5, 2, 15, 20, 7}', '{2, 5, 15, 20, 7}', '{15, 2, 5, 7, 20}', '{2, 5, 7, 15, 20}', 'B', 'Pierwsze kilka operacji podczas sortowania podanej tablicy tym algorytmem będą wyglądać następująco:<br/>\r\nPorównanie elementów 15 i 5 - zamiana miejscami<br/>\r\nPorównanie elementów 15 i 2 - zamiana miejscami<br/>\r\nPorównanie elementów 5 i 2 - zamiana miejscami'),
(75, 4, 'Ile wynosi złożoność obliczeniowa dla typowego przypadku Sortowania przez wstawianie?', 'O(n)', 'O(n*log(n))', 'O(n^2)', 'O(2^n)', 'C', 'Najlepszy, typowy oraz najgorszy przypadek Sortowania przez wstawianie posiada złożoność obliczeniową kolejno O(n), O(n^2), O(n^2).');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `uzytkownik`
--

CREATE TABLE `uzytkownik` (
  `id` int(11) NOT NULL,
  `nazwa` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `haslo` varchar(42) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `uzytkownik`
--

INSERT INTO `uzytkownik` (`id`, `nazwa`, `email`, `haslo`) VALUES
(1, 'Jan Kowalski', 'jankowalski@gmail.com', '4f788963a3614ac5998f80a9c5a7ceb6');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `kategorie_pytan`
--
ALTER TABLE `kategorie_pytan`
  ADD PRIMARY KEY (`id_kategorii`);

--
-- Indeksy dla tabeli `postepy`
--
ALTER TABLE `postepy`
  ADD PRIMARY KEY (`id_postepu`),
  ADD KEY `id_uzytkownika` (`id_uzytkownika`),
  ADD KEY `id_kategorii` (`id_kategorii`);

--
-- Indeksy dla tabeli `pytania`
--
ALTER TABLE `pytania`
  ADD PRIMARY KEY (`id_pytania`),
  ADD KEY `id_kategorii` (`id_kategorii`);

--
-- Indeksy dla tabeli `uzytkownik`
--
ALTER TABLE `uzytkownik`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `login` (`email`);

--
-- AUTO_INCREMENT dla zrzuconych tabel
--

--
-- AUTO_INCREMENT dla tabeli `kategorie_pytan`
--
ALTER TABLE `kategorie_pytan`
  MODIFY `id_kategorii` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT dla tabeli `postepy`
--
ALTER TABLE `postepy`
  MODIFY `id_postepu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT dla tabeli `pytania`
--
ALTER TABLE `pytania`
  MODIFY `id_pytania` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT dla tabeli `uzytkownik`
--
ALTER TABLE `uzytkownik`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `postepy`
--
ALTER TABLE `postepy`
  ADD CONSTRAINT `postepy_ibfk_1` FOREIGN KEY (`id_uzytkownika`) REFERENCES `uzytkownik` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `postepy_ibfk_2` FOREIGN KEY (`id_kategorii`) REFERENCES `kategorie_pytan` (`id_kategorii`) ON DELETE CASCADE;

--
-- Ograniczenia dla tabeli `pytania`
--
ALTER TABLE `pytania`
  ADD CONSTRAINT `pytania_ibfk_1` FOREIGN KEY (`id_kategorii`) REFERENCES `kategorie_pytan` (`id_kategorii`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
