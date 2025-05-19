# *************************************************************************** #
#                                                                             #
#                                Idziemy dalej!                               #
#                                                                             #
# *************************************************************************** #





# WEKTORY LOGICZNE --------------------------------------------------------

### operacje zwracajace wektory logiczne ####

# wszystkie porownania albo nierownosci na wektorach zwracaja wektory logiczne
# np.
1:10 == 5 # efekt: wektor logiczny z TRUE tam gdzie jest 5
1:10 != 5 # efekt: wektor logiczny z TRUE tam gdzie nie ma 5
1:10 > 5  # efekt: wektor logiczny z TRUE tam gdzie liczba wieksza niz 5
1:10 < 5  # itd.
1:10 <= 5
1:10 >= 5

# wektory logiczne mozna sumowac: TRUE sa traktowane jako 1 a FALSE jako 0
# dzieki temu mozna sprawdzic, ile elementow wektora spelnia dany warunek, np.

sum(1:20 < 7) # wyrazenie z nawiasu zwraca wektor logiczny, ktory sumujemy



### operacje logiczne ####

# na wektorach logicznych mozna stosowac operatory logiczne:
##  | (pionowa kreska) - OR (LUB)
##  & - AND (ORAZ, I)
##  ! - NOT (zaprzeczenie)

# utworzmy wektor x = 11:15
x <- 11:15

# przyklady:
x == 12
x == 12 | x == 14 # OR
x > 11 & x < 15   # AND
!x == 11          # NOT (zaprzeczenie ze x == 11)
x == 11 & x > 13  # same FALSE, bo zaden element x nie spelnia tych warunkow


# chcac sprawdzic, ktore elementy wektora wystepuja w innym wektorze, mozna 
# uzyc operatora %in%
x %in% c(12, 15)
!x %in% c(12, 15) # tutaj TRUE dla elementow, ktore nie sa w wektorze c(12, 15)


### UWAGA! ####
# Ponizszy kod nie zadziala prawidlowo
x == c(12, 15)
# jezeli szukamy elementow, ktore znajduja sie w innym wektorze, to nalezy 
# uzyc %in%





# WYBIERANIE ELEMENTOW WEKTORA --------------------------------------------

### wybieranie po indeksie ####

# wektor to uporzadkowany zbior wartosci, a kazda wartosc wektora ma swoj numer
# indeksu; elementy wektora mozna wybierac po numerach stosujac operator []
# indeksowanie elementow w R zaczyna sie od 1
# jesli chcemy kilka elementow wektora, to zbior indeksow  powinien byc wektorem

x[3]           # trzeci element wektora x
x[1:3]         # pierwsze 3 elementy wektora x
x[c(1, 3, 5)]  # chyba juz wiadomo, jak to dziala


# kolejnosc indeksow moze byc dowolna

x[c(5, 2)]  # najpierw piaty, potem drugi element
x[5:1]      # wszystkie elementy, ale w odwroconej kolejnosci


# indeksowanie moze tez byc wykluczajace, ze znakiem - (minus)

x[-3]           # wszystkie poza trzecim elementem
x[-(1:3)]       # wszystkie poza pierwszymi trzema, tutaj nalezy uzyc nawiasu
x[-c(1, 3, 5)]  # wszystkie poza 1., 3. i 5. elementem, tym razem funkcja c 


# wyjscie poza indeks zwroci wartosc nieznana (NA) 
x[6]
x[c(22, 33)]



### wybieranie po wektorze logicznym ####

# wartosci wektora mozna tez wybrac na podstawie wektora logicznego
# nalezy wewnatrz [] podac wektor logiczny o tej samej dlugosci i zwrocone
# zostana elementy na pozycjach TRUE

x[c(TRUE, FALSE, FALSE, TRUE, TRUE)]


# najczesciej wykorzystuje sie to wraz z operacjami zwracajacymi wektor
# logiczny, w ten sposob latwo wybrac wartosci spelniajace okreslony warunek

x[x > 12]  # x > 12 zwraca wektor logiczny, ktory stanowi filtr dla x
x[x == 12 | x == 14] # te elementy z x, ktore sa rowne 12 lub 14


### UWAGA! ####
# zwroc uwage na roznice miedzy tymi dwiema liniami kodu:

x == 12 | x == 14 # (to samo, co w linii 43)
x[x == 12 | x == 14]

# - pierwsza zwraca wektor logiczny z TRUE na odpowiednich pozycjach
# - druga zwraca elementy wektora x, ktore znajduja sie na pozycjach TRUE
#   tego poprzedniego wektora



### korzystanie z kilku wektorow ####
# najczesciej w ten sposob korzysta sie z kilku wektorow

# utworzmy 2 wektory
x <- 1:10
type <- c("a", "a", "a", "a", "b", "b", "b", "c", "c", "c")


# liczby z wektora x, ktore odpowiadaja pozycjom rownym "a" w wektorze type
x[type == "a"]

# liczby z wektora x, ktore odpowiadaja pozycjom innym niż "a" w wektorze type
x[type != "a"]

# liczby z wektora x, ktore odpowiadaja pozycjom "a" lub "c" w wektorze type
x[type %in% c("a", "c")]

# litery z wektora type, ktorym odpowiadaja parzyste liczby z wektora x
type[x %% 2 == 0]






# RAMKI DANYCH - PODSTAWY -------------------------------------------------


### informacje ogolne ####

# Ramka danych (dataframe) to podstawowa struktura danych wielowymiarowych w R.
# To tabela, ktora sklada sie z kilku wektorow o tej samej dlugosci, wektory 
# moga byc roznego typu (liczbowe, znakowe, logiczne), moga tez byc zmiennymi 
# kategorycznymi (tzw. factorami). Jest bardzo podobna do tabel w bazach danych.

# W podstawowych pakietach R znajduje sie wiele roznych zbiorow danych,
# w tym ramki danych, ktorymi mozna sie poslugiwac bezposrednio, np.
iris
mtcars
# o kazdym z tych zbiorow mozna przeczytac wywolujac pomoc do nich, np.
?iris
?mtcars

# Zaladowanie ramki danych do aktualnego srodowiska nastepuje po wykonaniu
# polecenia data(nazwa_danych), a pozniej ich wywolaniu, np.
data(iris)
head(iris) # polecenie head() domyslnie wyswietla 6 pierwszych rekordow
           # po wykonaniu tych dwoch linii kodu iris jest w srodowisku

# jak wszystko w R, ramki danych mozna podstawiac pod inne zmienne, np.
mtcars1 <- mtcars
# od teraz w srodowisku jest ramka mtcars1 zawierajaca kopie danych z mtcars



##### names(), colnames(), rownames() - nazwy kolumn, wierszy ####

# ramki danych musza miec nazwy kolumn (moga tez miec nazwy wierszy, np. ramka
# mtcars ma w nazwach wierszy nazwy samochodow)
# nazwy kolumn zwracaja polecenia names() lub colnames() (jako wektor znakowy)
names(mtcars1)
colnames(mtcars1)

# nazwy wierszy zwraca polecenie rownames()
rownames(mtcars1)



##### dim() - wymiary ramki danych ####

# ramki danych maja wiersze i kolumny, ich liczbe zwraca funkcja dim()
dim(mtcars1) # 32 wiersze i 11 kolumn, wynik to dwuelementowy wektor



##### str() - podstawowe informacje o ramce danych ####

# funkcja str() pelni role informacyjna: zwraca wymiary ramki, nazwy jej kolumn
# oraz typy tych kolumn wraz z pierwszymi wartosciami
str(iris)
str(mtcars1)



### symbol $ - wybieranie kolumn po nazwach ####

# symbol $ (dolar) pozwala na wybieranie kolumny z ramki po jej nazwie
# taka kolumna jest traktowana jako wektor (lub factor - o tym bedzie pozniej)

iris$Sepal.Length # kolumna z ramki iris o nazwie Sepal.Length
mtcars1$hp        # kolumna z ramki mtcars1 o nazwie hp (konie mechaniczne)
mtcars1$cyl       # kolumna z ramki mtcars1 o nazwie cyl (liczba cylindrow)


# wykorzystujac wybieranie elementow wektora po wektorze logicznym mozna np.
# wybrac wartosci z kolumny hp dla tych rekordow, ktore w kolumnie cyl
# maja wartosc 4
mtcars1$hp[ mtcars1$cyl == 4 ] # spacje dla dodania przejrzystoci

# albo wartosc 6
mtcars1$hp[ mtcars1$cyl == 6 ]

# albo wartosc 8
mtcars1$hp[ mtcars1$cyl == 8 ]

# mozna tez np. policzyc srednia hp dla rekordow z wybrana liczba cylindrow
mean( mtcars1$hp[ mtcars1$cyl == 4 ] )
mean( mtcars1$hp[ mtcars1$cyl == 6 ] )
mean( mtcars1$hp[ mtcars1$cyl == 8 ] )



### ramka[ktore_wiersze, ktore_kolumny] - wybor wartosci ramki #####

# z ramki danych mozna wybierac kolumny, wiersze, albo jedno i drugie
# ramka danych ma dwa wymiary: pierwszy dotyczy wierszy, drugi kolumn


##### wybieranie po indeksach ####

# pojedyncze indeksy: [nr wiersza, nr kolumny]
mtcars1[2, 5]

# kilka wierszy, 1 kolumna: [nry wierszy jako wektor, nr kolumny]
mtcars1[ c(2, 3, 6),  5 ] # wynikiem jest wektor

# 1 wiersz, kilka kolumn: [nr wiersza, nry kolumn jako wektor]
mtcars1[ 4,  c(1, 3, 4) ] # wynikiem jest ramka danych

# kilka wierszy, kilka kolumn: [nry wierszy jako wektor, nry kolumn jako wektor]
mtcars1[ 1:5,  c(1, 3, 4) ] # ramka: 5 pierwszych rekordów i kolumny 1, 3 oraz 4



### wybor kolumn i filtrowanie rekordow ####

# czesto chce sie wybrac kilka kolumn, wtedy mozna po przecinku podac wektor
# znakowy z ich nazwami
mtcars1[ , c("hp", "am", "cyl")] # wynikiem jest ramka danych
# brak wartosci PRZED przecinkiem oznacza wszystkie rekordy

# jesli chcemy wybrac pelne rekordy spelniajace jakis warunek, to wewnatrz [] 
# przed przecinkiem nalezy wstawic wektor logiczny, np.
mtcars1[ mtcars1$cyl == 4, ] # pelne wiersze z cyl == 4
# brak wartosci PO przecinku oznacza wszystkie kolumny

# obie rzeczy mozna laczyc, np. chcemy ramke zlozona: 
# - z wierszy spelniajacych kryterium hp > 120,
# - z kolumn hp, cyl, am, qsec, gear
# mozna to zapisac tak:
mtcars1[ mtcars1$hp > 120, c("hp", "cyl", "am", "qsec", "gear") ]

# taki wybor mozna zapisac pod nowa zmienna:
fast_cars <- mtcars1[mtcars1$hp > 120, c("hp", "cyl", "am", "qsec", "gear")]
# i w dalszej czesci skryptu operowac juz na niej (jezeli jest potrzeba)






# WYKRES HISTOGRAM --------------------------------------------------------

# histogram to wykres przedstawiajacy rozklad zmiennej liczbowej
# domyslnie funkcja hist samodzielnie dobiera granice przedzialow dla kolumn
# w histogramie
hist(mtcars1$hp)

# mozna to zmienic parametrem breaks podajac liczbe przedzialow 
# (ale ona niekoniecznie musi byc uwzgledniona, poniewaz funkcja stosuje 
# algorytm wyznaczania granic) 
# lub dokladne granice przedzialow w postaci wektora
# (wtedy te granice sa dokladnie takie, jak podamy)
hist(mtcars1$hp, breaks = 20) # podalismy 20, ale przedzialow jest 15
hist(mtcars1$hp, breaks = c(50, 150, 250, 350)) # dokladnie tak, jak podalismy

# w przypadku histogramu parametr col odpowiada za kolor wypelnienia a kolor
# krawedzi mozna zmienic za pomoca parametru border
hist(iris$Petal.Length, col = "darkorange", border = "white")

# przy histogramie mozna stosowac standardowe opcje wykresow jak np. xlab,
# ylab czy main
hist(iris$Petal.Length, col = "darkorange", border = "white",
     main = "Rozkład zmiennej Petal.Length w zbiorze iris",
     xlab = "centymetry", ylab = "")





# WYKRES PUDELKOWY --------------------------------------------------------

# wykres pudelkowy, podobnie jak histogram, przedstawia rozklad zmiennej 
# liczbowej, przy czym robi to w formie pudelka, ktore reprezentuje kwartyle
# rozkladu
boxplot(mtcars1$hp)

# czesto funkcje boxplot() stosuje sie do porownania rozkladu pewnej zmiennej 
# dla roznych wartosci innej zmiennej (ktora powinna przyjmowac niewiele 
# roznych wartosci, zazwyczaj jest to zmienna kategoryczna, ale niekoniecznie)
# stosuje sie wtedy zapis: zmienna ~ podzial, np.

# rozklad wartosci hp (koni mechanicznych) dla samochodow z 4, 6 i 8 cylindrami
boxplot(mtcars1$hp ~ mtcars1$cyl)

# rozklad dlugosci Petal dla poszczegolnych gatunkow
boxplot(iris$Petal.Length ~ iris$Species)

# jeszcze raz to samo, ale z kolorami i opisami
boxplot(iris$Petal.Length ~ iris$Species, 
        col = "#349911", border = "#555555",
        xlab = "gatunek", ylab = "długość (cm)", 
        main = "Rozkład długości Petal")
