# *************************************************************************** #
#                                                                             #
#                                  Zaczynamy!                                 #
#                                                                             #
# *************************************************************************** #





# OBSLUGA SKRYPTOW W RSTUDIO ----------------------------------------------

### wykonywanie kodu ####
# - skrot CTRL + ENTER lub ikona Run w gornej czesci okna spowoduje
#   wykonanie kodu z danej linii albo caly zaznaczony fragment fragment kodu
# - jesli instrukcja sklada sie z kilku linii, to wystarczy zeby kursor byl
#   ktorejkolwiek z nich

### przydatne skroty #### 
# - LAlt + o - "zwiniecie" kodu (stworzy sie tak jakby spis tresci)
# - SHIFT + LAlt + o - "rozwiniecie" kodu
# - LAlt + L - "zwiniecie" pojedynczego fragmentu kodu
# - SHIFT + LAlt + L - "rozwiniecie" pojedynczego fragmentu kodu

### komentarze ####
# - wszystko, co na poczatku ma # jest komentarzem i nie jest wykonywane,
#   a wiec po # mozna napisac dowolne rzeczy i nie zepsuja one skryptu
# - skrot komentujacy zaznaczone linie: CTRL + SHIFT + C





# PODSTAWOWE DZIALANIA I ZMIENNE ------------------------------------------

### podstawowe dzialania ####

# dodawanie
3 + 5
2.41 + 3.89 # ulamki oddzielamy kropka

# pozostale
3 - 5
3 * 5
3 / 5
3 ^ 5
10 %% 3  # reszta z dzielenia (modulo)
10 %/% 3 # dzielenie calkowite (bez ulamka)



### zmienne - tworzenie i wywolywanie ####

# <- - przypisywanie zmiennych (skrót LAlt + -)
x <- 5
x <- 6

# wywolanie zmiennej domyslnie zwraca ja na konsole
x

# przypisywac zmienna mozna tez za pomoca =,
y = 7
y
# ale w pewnych sytuacjach = i <- dzialaja inaczej wiec lepiej stosowac <-

# stosowanie zmiennych jest naturalne
x ^ y  # wynik dzialania 6 do potegi 7
x - 2 * y # wynik dzialania 6 - 2 * 7, kolejnosc dzialan oczywiscie obowiazuje

# w R wazna jest wielkosc liter w nazwach
X <- 1 # to jest duze iks (IKS)
x # male x
X # duze X

# w nazwach mozna stosowac liczby, kropki, podkreslniki, ale nie myslniki
x1 <- 1
x.1 <- 1
x_1 <- 1
x-1 <- 1 # to spowoduje blad



### rodzaje danych ####

# liczby zmiennoprzecinkowe - numeric
x <- 5
class(x) # funkcja class() zwraca rodzaj danych

# dane znakowe (w cudzyslowie, pojedynczym albo podwojnym - jak wygodniej)
c <- "t"
class(c)

# znaki bez cudzyslowu traktowane sa jako zmienne
c2 <- a
# BŁĄD: nie znaleziono obiektu 'a' 
# Error: object 'a' not found - czyli bledne polecenie, bo nie ma zmiennej 'a'

# dane logiczne - TRUE, FALSE (koniecznie WIELKIMI LITERAMI)
g <- TRUE
class(g)





# WEKTORY - PODSTAWY ------------------------------------------------------

### tworzenie wektorow #####

# wektor to podstawowy typ danych w R, musi skladac sie z wartosci tego samego
# typu, 
# pojedyncza liczba lub znak to tak naprawde takze wektor, tylko jednoelementowy
# wektory tworzy sie za pomoca funkcji c() (c - combine)

# wektor liczbowy
x <- c(3, 4, 7)
x
class(x) # numeric - to samo o przy pojedynczej liczbie

# wektor znakowy
a <- c("a", "aaa", "ale o co chodzi?")
a
class(a)

# wektor logiczny
b <- c(TRUE, FALSE, TRUE)
b
class(b)


# nie da sie polaczyc w jeden wektor roznych typow danych, nastapi automatyczna
# konwersja

# tekst i liczba
crazy <- c("a", 5)
crazy # wektor znakowy, liczba 5 zamieniona na znak "5"

# tekst i wartosc logiczna
crazy <- c("a", TRUE)
crazy # wektor znakowy, TRUE zamienione na tekst "TRUE"

# wartosc logiczna i liczba
crazy <- c(FALSE, TRUE, 5, 0)
crazy # wektor liczbowy, TRUE zamienione na 1, a FALSE na 0


# wektor mozna tworzyc z innych wektorow, np.
x1 <- c(1, 4)
x2 <- c(4, 6)
x3 <- c(x1, x2)
x3



### sekwencje wartosci ####

# symbol : pomiedzy liczbami oznacza wektor liczb calkowitych z wartosciami
# od liczby przed : do liczby po :

1:5   # od 1 do 5
13:27 # od 13 do 27
1:200 # od 1 do 200 (zwrocic uwage na numerki wierszy wyniku)
-5:5  # od -5 do 5
5:-5  # od 5 d -5

# jesli potrzebna nam duza liczba mozna uzyc skrotowego zapisu
1:1e6 # od 1 do miliona (nie wszystko sie wyswietla)


# kiedy chcemy utworzyc wektor zlozony z liczb skladajacych sie na ciag 
# arytmetyczny o dowolnej roznicy, mozna skorzystac z funkcji seq(), 
# podajac kolejno punkt startu (from), punkt koncowy (to) i roznice (by)

seq(from = 0, to = 1, by = 0.1) # wektor liczb od 0 do 1 co 0.1
seq(0, 1, 0.1) # nazw atrybutow mozna nie podawac, o ile zachowa sie kolejnosc



### podstawowe dzialania na elementach wektora ####

# dzialania na wektorach liczbowych sa dzialaniami na jego poszczegolnych
# wartosciach

# tworzymy wektor zlozony z liczb od 11 do 20
x <- 11:20 

# wyswietlamy go
x

# przyklady dzialan
x + 5  
x - 15
x * 4
x / 3
x ^ 2
x %% 2 # reszta z dzielenia x przez 2, dla parzystych 0, dla nieparzystych 1
2 ^ x # to jest ciekawe: wynikiem jest wektor poteg liczby 2

# jezeli wektory maja taka sama dlugosc, to mozna bez problemu wykonywac
# na nich dzialania
# rezultatem jest wektor takiej samej dlugosci, ktorego elementy sa wynikami
# dzialana na poszczegolnych wyrazach tych wektorow
y <- 1:10
x + y
x * y
x / y
# jesli dlugosci wektorow nie sa swoja wielokrotnoscia, to dzialanie takze 
# sie wykona, ale zostanie wyswietlone ostrzezenie (Warning message)
x + 1:3





# PODSTAWOWE FUNKCJE DZIALAJACE NA WEKTORACH ------------------------------

### tworzymy nastepujacy wektor ####
x <- c(3:9, 3, 8, 9, 4, 8, -3, -5, 0)

# wyswietlenie
x


### length - rozmiar wektora (czyli liczba jego elementow) ####
# dziala na wszystkich typach wektorow
length(x)
length(c("a", "bb", "ccc"))


### sum - suma ####
sum(x)


### min, max - oczywiste ####
min(x)
max(x)


### mean - srednia ####
mean(x)


### var, sd - wariancja, odchylenie standardowe ####
var(x)
sd(x)


### sqrt - pierwiastek kwadratowy ####
sqrt(x)
# Warning: NaN - wartosc niemozliwa do obliczenia, stad to NaN (non-numeric)


### abs - wartosc bezwzgledna ####
abs(x)


### summary - wektor zlozony z kilku wartosci, jego elementy maja nazwy ####
summary(x)


### table - wektor z liczebnoscia poszczegolnych elementow ####
# dziala na wszystkich typach wektorow
table(x)
table(c("a", "a", "b", "bb", "bb", "bb", "c"))


### unique - wektor bez powtarzajacych sie elementow ####
# dziala na wszystkich typach wektorow
unique(x)
unique(c("a", "a", "b", "bb", "bb", "bb", "c"))



### laczenie funkcji ####

# funkcje mozna wykorzystywac w obliczeniach i zagniezdzac, budujac bardziej 
# skomplikowane formuly, np.

x - mean(x) # wektor roznic x i sredniej x
sum(x - mean(x)) # suma wektora roznic, wynik to 0 (niedokladnosc zaokraglen)
sqrt(abs(x)) # pierwiastek z wartosci bezwglednej elementow x





# PODSTAWOWY WYKRES -------------------------------------------------------    


### funkcja plot() ####

# funkcja plot() wyswietla na osi Y wartosci wektora liczbowego w kolejnosci
# ich wystepowania
plot(x)

# przewaznie jednak wykorzystuje sie ja z dwoma wektorami, wtedy pierwszy
# wskazuje na wartosci na osi X, a drugi na osi Y
x0 <- seq(-5, 5, 0.2) # liczby od -5 do 5 co 0.2
y0 <-  x0 ^ 2 # liczby z wektora x podniesione do kwadratu

# wykres
plot(x0, y0)

# zmieniajac argument type (domyslnie rowny "p") mozna utworzyc wykres 
# liniowy ("l") lub punkty polaczone linia ("b")
plot(x0, y0, type = "l")
plot(x0, y0, type = "b")

# argument col pozwala zmienic kolor, mozna podac nazwe albo zapis szesnastkowy
plot(x0, y0, type = "l", col = "red")
plot(x0, y0, type = "b", col = "#330099")

# atrybuty xlab, ylab i main pozwalaja opisac osie i nadac tytul wykresowi
plot(x0, y0, type = "l", col = "orange", 
     xlab = "wartości x", ylab = "wartości y", 
     main = "Wykres funkcji kwadratowej dla przedziału od -5 do 5")
# jesli instrukcja jest dluga, to mozna pisac ja w kilku liniach
# dobra praktyka jest pisanie kodu w taki sposob, zeby w jednej linii bylo 
# nie wiecej niz niz 80 znakow, taki kod jest bardziej czytelny



### funkcja abline() ####

# abline() pozwala dolozyc linie do istniejacego wykresu: 
# - pozioma - nalezy podac h - horizontal (wspolrzedne Y linii), 
# - pionowa - trzeba podac v - vertical (czyli wspolrzedne X linii) 
# - o dowolnym kierunku - podajemy a i b (jak w rownaniu y = bx + a)
# typ linii mozna zmienic argumentem lty (to dziala takze w funkcji plot)
abline(h = 5, col = "red")
abline(v = 0, lty = 3)
abline(a = 5, b = 2, col = "chocolate", lty = 2)



