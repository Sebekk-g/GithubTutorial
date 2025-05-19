# *************************************************************************** #
#                                                                             #
#                           Jeszcze więcej zabawy!                            #
#                                                                             #
# *************************************************************************** #






# WIECEJ O RAMKACH DANYCH -------------------------------------------------


### tworzenie - funkcja data.frame() ####

# Ramke danych mozna utworzyc z wektorow i factorow o tej samej dlugosci
# za pomoca funkcji data.frame


# tworzymy dwa wektory
height <- c(175, 180, 164, 156, 178, 171, 184, 170, 156, 179, 180)
sex <- c("m", "m", "f", "f", "m", "f", "m", "f", "f", "f", "m")

# tworzymy nowa zmienna o nazwie weight, ktora jest zalezna od wzrostu,
# ale tez troche "losowa"
set.seed(12)
weight <- height - 115 + sample.int(30, 11)
# weight to height pomniejszony o 115 plus liczba losowana z wartosci 1-30
# dzieki ustawieniu set.seed() na te sama liczbe, wylosowane sa te same wartosci

# tworzymy ramke danych z trzech zmiennych
dat <- data.frame(height, weight, s = sex)
# pierwsze dwie kolumny maja takie same nazwy jak te zmienne, 
# a trzecia nazywa sie "s"

# zobaczmy te ramke
dat



### najwazniejsze funkcje dla ramek #####

# przypomnienie: str(), names(), dim(), rownames()
str(dat)
names(dat)
dim(dat)
rownames(dat)

# pierwsze wiersze
head(dat)
head(dat, n = 3)

# liczba wierszy, liczba kolumn - czasem sie przydaje
nrow(dat)
ncol(dat)

# summary dziala tez na ramce - szybkie podsumowanie poszczegolnych kolumn
summary(dat)



### modyfikacja wartosci ####

# pojedyncze wartosci wektorow czy ramek danych mozna oczywiscie modyfikowac
# jezeli mamy wektor, to wystarczy pod wybrany element wektora podstawic
# nowa wartosc, np.
x <- 1:10
x[1] <- 11 # pierwszy element modyfikujemy na 11
x

# mozna tez modyfikowac kilka wartosci jednoczesnie, np.
x[c(8, 10)] <- 1
x

# wykorzystujac operacje zwracajace wartosci logiczne mozna tez modyfikowac
# wartosci innymi wartosciami, 
# np. zwiekszmy wzrost kobiet w ramce dat o 1
dat # sprawdzamy ramke przed zmiana
dat$height[dat$s == "f"] <- dat$height[dat$s == "f"] + 1 # zwiekszamy
dat # po zmianie
# tylko trzeba przy tym uwazac, bo latwo o pomylke



### zmiana nazw kolumn ####

# bywa, ze chcemy zmienic nazwy kolumn, mozna to latwo zrobic korzystajac 
# z funkcji names(), np. zmienmy nazwe trzeciej kolumny na "sex"
names(dat)[3] <- "sex" 
names(dat)
# pod trzeci element wektora zwracanego przez names podstawilismy "sex"



### nowa kolumna ####
# za pomoca $ do ramki mozemy dodac nowa kolumne o wskazanej nazwie
# dolozmy nowa kolumne o nazwie bmi, ktora na podstawie wzrostu i wagi 
# wyliczy wskaznik BMI
dat$bmi <- dat$weight / (dat$height / 100)^2
str(dat) # ramka ma juz 4 kolumny, ostatnia to bmi



### zapisywanie danych ####

# podstawowa funkcja do zapisywania danych jest write.table, ale wygodniej 
# korzystac z jej wariantow:
# write.csv lub write.csv2
?write.table
# wymagane argumenty to nazwa ramki oraz sciezka do pliku, np.
write.csv(dat, "dane.csv") # zapis w folderze projektu

# domyslnie zapisywane sa tez nazwy wierszy, wiec warto pamietac, zeby dodac 
# jeszcze opcje row.names = FALSE

write.csv(dat, "./data/dane1.csv", row.names = FALSE) # zapis w folderze data
write.csv2(dat, "./data/dane2.csv", row.names = FALSE) # zapis w folderze data

# miedzy write.csv i write.csv2 wystepuje pewna roznica, ktora mozna sprawdzic
# w pomocy tych funkcji:
# 
# write.csv uses "." for the decimal point and a comma for the separator.
# 
# write.csv2 uses a comma for the decimal point and a semicolon for the 
# separator, the Excel convention for CSV files in some Western European 
# locales.



### wczytywanie danych z pliku tekstowego ####

# podstawowym poleceniem z podstawowego R (base R) wczytujacym dane z pliku 
# tekstowego jest read.table
?read.table
# polecenie to ma bardzo duzo opcji, ktore pozwalaja na wczytywanie danych 
# zapisanych w roznych formatach

# podobnie jak przy zapisywaniu, najczesciej wygodniej jest skorzystac 
# z wariantow tej funkcji ukrytych pod nazwami read.csv i read.csv2

# obowiazkowym parametrem jest sciezka dostepu do pliku
# i wczytywac mozna zarowno dane z dysku, jak i z internetu, np.
b.cars <- read.csv2("http://www.biecek.pl/R/auta.csv", dec = ".") 
# dane z tego pliku sa rozdzielane srednikami, ale separatorem dziesietnym
# jest kropka, wiec trzeba zmodyfikowac domyslne wartosci funkcji read.csv
# (inaczej wartosci liczbowe z kropka bylyby traktowane jako tekst)

# zobaczmy te dane:
str(b.cars)
summary(b.cars)






# DANE TITANIC ------------------------------------------------------------

# W dalszej czesci bedziemy pracowac na ramce tt pod ktora wczytamy dane 
# z pliku titanic.csv. Sa to dane o pasazerach Titanika (tak, tego prawdziwego 
# Titanika, nie mylic z filmem). To nie jest kompletna lista pasazerow, ale ich 
# czesc. Dane pochodza z serwisu Kaggle 
# (https://www.kaggle.com/c/titanic/data) i mozna tam o nich poczytac.

# Zakladamy, ze plik znajduje sie w folderze data w naszym projekcie.
# Plik ten jest tak przygotowany, zeby wczytac go za pomoca funkcji read.csv.
tt <- read.csv(file = "./data/titanic.csv")

# pierwsza rzecz - sprawdzmy jakie tam sa kolumny i typy danych
str(tt)

# podsumujmy te dane
summary(tt)

# Widac pierwsze mankamenty:
# - zmienna Age ma 177 brakow (NA)
# - zmienne Survived i Pclass to liczby, ale raczej powinno sie je 
#   traktowac jako zmienne kategoryczne: 
#  -- Survived informuje o tym, czy ktos przezyl, czy nie 
#  -- Pclass wskazuje klase, ktora podrozwala dana osoba


# sprawdzmy wartosci w kolumnach Sex i Embarked:
table(tt$Sex)
table(tt$Embarked)

# Kolejne mankamenty:
# - zmienne Sex i Embarked sa traktowane jako wektory znakowe, ale to tez 
#   zmienne kategoryczne: 
#  -- Sex wskazuje na plec pasazera
#  -- Embarked to port zaokretowania


# sprawdzmy liczbe unikatowych wartosci pozostalych zmiennych znakowych:
length(unique(tt$Name))
length(unique(tt$Ticket))
length(unique(tt$Cabin))
# w ich wypadku wektory znakowe sa odpowiednie (zmienne kategoryczne maja 
# kilka lub co najwyzej kilkanascie unikatowych wartosci)






# ZMIENNA KATEGORYCZNA - factor -------------------------------------------


# factor, czyli zmienna kategoryczna (czynnikowa), to taki specyficzny wektor, 
# ktory moze przyjmowac ograniczony zbior wartosci
# korzystanie z factorow ulatwia prace na danych, poniewaz wiekszosc funkcji
# traktuje je inaczej niz wektory znakowe

# przykladowo, w podstawowym R nie da sie "pokolorowac" punktow wg wektora
# znakowego:
plot(tt$Age, tt$Fare, col = tt$Sex)

# ale wg factora juz tak:
plot(tt$Age, tt$Fare, col = factor(tt$Sex) )

# do zmiany wektora na factor mozna uzyc funkcji as.factor() lub factor()
# domyslnie unikatowe wartosci z oryginalnego wektora staja sie "poziomami"
# czyli dozwolonymi wartosciami factora, ale mozna je zmienic za pomoca 
# funkcji factor()


# zamienmy na factory kolumny Survived, Pclass, Sex i Embarked, przy czym 
# w kolumnie survived zamiast 0 i 1 chcemy odpowiednie napisy

# Survived
tt$Survived <- factor(tt$Survived, 
                      levels = c(0, 1), 
                      labels = c("not survived", "survived"))
# Pclass
tt$Pclass <- factor(tt$Pclass)

# Sex
tt$Sex <- factor(tt$Sex)

# Embarked
tt$Embarked <- factor(tt$Embarked)

# ponownie podsumujmy ramke:
summary(tt)
# od razu widzimy liczby poszczegolnych wartosci w factorach

# warto podkreslic, ze Pclass to teraz tez factor, pomimo ze wciaz wyswietla 
# te same liczby, co widac np. po wywolaniu funkcji str()
str(tt)

# poniewaz Pclass jest factorem, to nie mozna jej traktowac jak liczby 
# i wykonywac np. dzialan matematycznych (tzn. mozna, ale nic nie wyjdzie)
tt$Pclass * 2

# PODSUMOWUJAC: faktory sa traktowane jako zmienne kategoryczne





# FUNKCJE PRZYDATNE W ANALIZIE DANYCH -------------------------------------

### sort(), order() - sortowanie ####

# funkcja sort zwraca posortowany wektor (domyslnie rosnaco, malejaco jesli
# zmieni sie parametr decreasing na TRUE), np.
sort(c(12, 11, 13))
sort(c(12, 11, 13), decreasing = TRUE)

# funkcja order() zwraca indeksy posortowanego wektora, np.
order(c(12, 11, 13))
order(c(12, 11, 13), decreasing = TRUE)

# dzieki funkcji order mozna posortowac ramke danych:

# 10 pierwszych kolumn Name i Age posortowanych wg Name
head( tt[order(tt$Name), c("Name", "Age")], n = 10 )

# 10 pierwszych kolumn Name i Age posortowanych wg Age malejaco
head( tt[order(tt$Age, decreasing = TRUE), c("Name", "Age")], n = 10)



### complete.cases() - sprawdzenie kompletnosci rekordow ####

# funkcja complete.cases() przyjmuje ramke danych i zwraca wektor logiczny 
# z wartosciami TRUE gdy w rekordzie nie ma brakow
complete.cases(tt)

# dzieki niej mozna szybko sprawdzic ile rekordow ma braki
table(complete.cases(tt))
# 177 rekordow z brakami, czyli tyle ile jest brakow w kolumnie Age

# funkcja pozwala na wybor tylko kompletnych rekordow, np. tak
tt.complete <- tt[complete.cases(tt), ]
summary(tt.complete)



### tapply() - wyliczanie w grupach ####

# funkcja tapply() pozwala na szybkie wyliczenie wartosci z pewnego wektora
# wg okreslonej funkcji, ale w podziale na grupy wyznaczone przez wartosci
# innego wektora
# wynikiem jest nazwany wektor

# srednia cena biletu kobiet i mezczyzn
tapply(tt$Fare, tt$Sex, mean)

# srednia cena biletu w poszczegolnych klasach
tapply(tt$Fare, tt$Pclass, mean)

# jesli chcemy w tapply uzyc funkcji z innymi parametrami niz domyslne, mozna
# skorzystac z konstrukcji funkcji anonimowej:
# function(x) nazwa_funkcji(x, pozostale_argumenty), np.
tapply(tt$Age, tt$Pclass, function(x) mean(x, na.rm = TRUE) )
# bez na.rm = TRUE otrzymalibysmy wartosci NA 
# (na.rm = TRUE - sprytne rozwiazanie podpunktow d) i e) w zadaniu 29.)



### table(), prop.table() - zestawienia ####

# podstawowe dzialanie funkcji table() juz znamy, ale mozna ja wykorzystywac
# tez z kilkoma wektorami

# ile osob przezylo - z podzialem na plec
table(tt$Survived, tt$Sex)

# funkcja prop.table pozwala wynik funkcji table() przedstawic jako czesc
# calosci
prop.table(table(tt$Survived, tt$Sex)) # udzial w calosci
prop.table(table(tt$Survived, tt$Sex), margin = 1) # udzial w wierszach
prop.table(table(tt$Survived, tt$Sex), margin = 2) # udzial w kolumnach



### grep(), grepl() - przeszukiwanie tekstu ####

# funkcje grep/grepl pozwalaja na wyszukiwanie ciagu znakow w wektorze znakowym
# grep domyslnie zwraca indeksy wektora zawierajace dany ciag znakow
# natomiast grepl wektor logiczny z wartosciami TRUE na pozycjach, ktore 
# zawieraja zadany ciag znakow

# przyklad 1
ch <- c("tomek", "romek", "ala", "kotek", "ekierka", "jan")

grep("ek", ch)  # indeksy wektora ch, w ktorych znajduje sie ciag znakow "ek"
grepl("ek", ch) # wektor logiczny z TRUE na pozycjach, gdzie jest "ek",
                # jego dlugosc jest taka sama jak wektora ch (co sie przydaje)

# przyklad 2
# ilu pasazerow Tytanika mialo w imieniu ciag znakow John?
sum(grepl("John", tt$Name))

# funkcje te maja kilka waznych parametrow, w tym parametr fixed
# domyslnie te funkcje stosuja tzw. wyrazenia regularne i niektore znaki 
# specjalne sa traktowane "specjalnie", ustawienie fixed = TRUE powoduje, ze
# znaki sa traktowane doslownie

# przyklady:

tt$Name[ grepl("Mr.", tt$Name) ][1:10] 
# w wyrazeniach regularnych kropka oznacza dowolny znak i stad w wynikach jest
# takze Mrs

tt$Name[ grepl("Mr.", tt$Name, fixed = TRUE) ][1:10] 
# ustawienie fixed = TRUE wylacza wyrazenia regularne, tym razem w wynikach 
# jest tylko Mr. czyli dokladnie tak, jak napisalismy

