# *************************************************************************** #
#                                                                             #
#                         Podstawowe funkcje z dplyr                          #
#                                                                             #
# *************************************************************************** #




# PRZYGOTOWANIE -----------------------------------------------------------

# zaladowanie tidyverse
library(tidyverse)


# wczytanie danych o pasazerach Titanika 
tt <- read.csv("./data/titanic.csv")


# zmiana niektórych kolumn na factory
tt$Survived <- factor(tt$Survived, levels = c("0", "1"),
                      labels = c("not survived", "survived")) 
tt$Pclass <- as.factor(tt$Pclass)
tt$Sex <- as.factor(tt$Sex)
tt$Embarked <- factor(tt$Embarked)





# OPERATOR POTOKOWY %>% ---------------------------------------------------


# operator potokowy przekazuje rezultat z lewej strony jako pierwszy argument 
# do funkcji z prawej strony, czyli np. takie polecenie:
summary(tt)
# mozna zapisac tak:
tt %>% summary()

# inny przyklad, juz na podstawie funkcji z dplyr
# wybierzmy wiek i Name kobiet, ktore nie przezyly

# najpierw standardowo, ale korzystajac z funkcji z pakietu dplyr:
select(filter(tt, Sex == "female", Survived == "not survived"), Age, Name) 

# a teraz potokowo:
tt %>% 
    filter(Sex == "female", Survived == "not survived") %>%  
    select(Age, Name)                           

# operator potokowy zwieksza czytelnosc kodu i ulatwia prace w R
# skrot w RStudio: CTRL + SHIFT + m





# PODSTAWOWE FUNKCJE Z dplyr ----------------------------------------------


# najwazniejsze funkcje z pakietu dplyr:
# filter() - wybieranie wierszy
# select() - wybieranie kolumn
# arrange() - sortowanie wierszy
# group_by() - okreslanie grup
# summarise() - liczenie agregatow, podsumowan
# mutate() - tworzenie nowych kolumn

# UWAGA: wszystkie te funkcje jako pierwszy argument przyjmuja dane w postaci
#        tabelarycznej (data.frame albo tibble) i zwracaja wynik w tej samej
#        postaci, wiec sa przystosowane do potokowego przekazywania swoich 
#        rezultatow




### filter - kryteria dla wierszy #####

# filter dziala podobnie jak WHERE w SQL - pozwala okreslic warunki dla wierszy,
# warunki wymieniamy po przecinku (wtedy to dziala jak &), ale mozna tez 
# uzywac symbolu | (pionowa kreska) jako OR


##### przyklad 1 - wszystkie dane kobiet ####

# bez dplyra, to juz znamy:
tt[tt$Sex == "female", ]        

# z dplyrem, ale bez potokow:
filter(tt, Sex == "female")    

# z dplyrem potokowo:
tt %>% filter(Sex == "female")


##### przyklad 2 - ile jest kobiet, ktore przezyly ####

# bez dplyra:
sum(tt$Sex == "female" & tt$Survived == "survived")

# z dplyrem, bez potokow:
nrow(filter(tt, Sex == "female", Survived == "survived"))

# z dplyrem potokowo:
tt  %>% 
    filter(Sex == "female", Survived == "survived") %>% 
    nrow # jesli funkcja nie ma zadnych 
         # innych argumentow, to mozna pominac nawiasy


##### przyklad 3 - liczba osob w wieku ponizej 10 lub powyzej 70 ####

# podstawowy R
sum(tt$Age < 10 | tt$Age > 70, na.rm = TRUE)

# potokowo
tt %>% filter(Age < 10 | Age > 70) %>% nrow


##### przyklad 4 - wyszukiwanie po tekscie z grepl ####

# wszystkie dane osob o imieniu Maria - podstawowy R
tt[grepl("Maria ", tt$Name), ]

# wszystkie dane osob o imieniu Maria - z dplyr, potokowo
tt %>% filter(grepl("Maria ", Name))



##### UWAGA ####
# - porownanie wymaga podwojnego ==
# - w nazwach kolumn nie stosujemy cudzyslowu (to dotyczy tez innych funkcji),
#   nie trzeba tez podawac nazwy ramki danych (tylko czyste kolumny)
# - filtrowanie po tekscie wymaga grepl (nie grep)





### select - wybor kolumn #####

# kolumny mozna wybierac po nazwach, po numerkach (oddzielamy przecinkiem), 
# mozna tez jeszcze troche inaczej, korzystajac z pomocniczych funkcji
# ponizej zawsze koncze przeslaniem calosci do funkcji head(), 
# zeby nie wyswietlac zbyt duzo


##### przyklad 1 - tylko kolumny Name, Age i Survived ####
tt %>% select(Name, Age, Survived) %>% head


##### przyklad 2 - kolumny nr 2, 3 i 5 ####
tt %>% select(2, 3, 5) %>% head


##### przyklad 3 - kolumny Name, Age i Survived osob, ktore przezyly ####

# laczymy filter i select
tt %>% 
    filter(Survived == "survived") %>% 
    select(Name, Age, Survived) %>% head


# a to nie zadziala, dlaczego? 
tt %>% 
    select(Name, Age) %>% 
    filter(Survived == "survived") %>% head



##### wiecej przykladow ####

# bez kolumn Ticket i Embarked
tt %>% select(-Ticket, -Embarked) %>% head

# kolumny zawierajace w nazwie "s"
tt %>% select( contains("s") ) %>% head

# kolumny od Age do Fare
tt %>% select( Age:Fare ) %>% head





### arrange - sortowanie #####

#### przyklad 1 - sortowanie wg Name ####

# sortujemy alfabetycznie po Name
tt %>% arrange(Name) %>% head(n = 20)


#### przyklad 2 - sortowanie malejaco wg Fare ####
tt %>% 
    select(Name, Survived, Fare) %>% 
    arrange(desc(Fare)) %>%  # desc odwraca kolejnosc sortowania
    head(n = 20)


#### przyklad 3 - sortowanie najpierw wg Fare, potem wg Name ####
tt %>% 
    select(Name, Fare) %>% 
    arrange(Fare, Name) %>% 
    head(n = 20)





### summarise - podsumowywanie #####

# to samo co funkcje agregujace w SQL, ale wygodniejsze
# bez grupowania summarise podsumowuje cala ramke


##### przyklad 1 - srednia i odchylenie standardowe Fare ####

tt %>% 
    summarise(mean.fare = mean(Fare),
              sdev.fare = sd(Fare))


##### przyklad 2 - wiecej statystyk ####

# wyliczmy: 
# - liczbe osob, 
# - liczbe osob bez brakow w Age
# - sredni wiek, 
# - odchylenie stand. wieku
# - wspolczynnik zmiennosci wieku
tt %>% 
    summarise(n = n(),  # funkcja n() zlicza wiersze
              n2 = sum(!is.na(Age)),
              mean.age = mean(Age, na.rm = TRUE), 
              sdev.age = sd(Age, na.rm = TRUE),
              vx.age = sdev.age / mean.age * 100)
# mozna uzywac zmiennych, ktore tworzy sie w tym samym potoku

# funkcji summarise najczesciej uzywa sie z wczesniejszym grupowaniem





### group_by - grupowanie #####

# group_by doklada poziom grupowania
# w przeciwienstwie do SQL samo group_by niczego nie zmienia w danych, 
# ale zmienia sposob wyliczania agregacji


###### przyklad 1 - ile osob przezylo, a ile nie ####
tt %>% 
    group_by(Survived) %>% 
    summarise(n = n()) 
# w przeciwienstwie do funkcji table() tutaj wynikiem jest tibble,
# czy taka "ulepszona" ramka danych (zobacz materialy z wykladu)


##### przyklad 2 - liczba i sredni wiek w zaleznosci od przezycia ####
tt %>% 
    group_by(Survived) %>% 
    summarise(n = n(), 
              mean.age = mean(Age, na.rm = TRUE))


##### przyklad 3 - grupowanie po kilku kolumnach ####
tt %>% 
    group_by(Survived, Sex) %>% # grupowanie po dwoch kolumnach
    summarise(n = n(), 
              mean.age = mean(Age, na.rm = TRUE))



##### UWAGA ####
# po zastosowaniu funkcji summarise pojawia sie tylko te kolumny,
# po ktorych wczesniej nastapilo grupowanie oraz kolumny zdefiniowane
# wewnatrz summarise 
# (pozostale kolumny zostana "stracone" - nie mozna sie juz do nich odwolywac)





### mutate - tworzenie nowych kolumn #####


##### przyklad 1 - nowa kolumna z rokiem narodzin ####

# od daty katastrofy odejmowany jest "sufit" wieku 
# (czyli wiek zaokraglony w gore do liczby calkowitej)
tt %>% 
    mutate(BirthYr = 1912 - ceiling(Age)) %>% 
    select(Name, Age, BirthYr) %>% 
    head(n = 20)


##### UWAGA ####
# za pomoca mutate mozna tez dodawac wartosci obliczone dla grup,
# ale jednoczesnie nie dokonywac faktycznego grupowania


##### przyklad 2 - kolumna z liczba rekordow w calej tabeli ####
tt %>% 
    mutate(liczba_osob = n()) %>% 
    select(PassengerId, Pclass, liczba_osob) %>% 
    head(n = 20)
# nie ma grupowania wiec funkcja n() oblicza cala ramke


##### przyklad 3 - kolumna z liczba rekordow danej klasie ####
tt %>% 
    group_by(Pclass) %>% 
    mutate(liczba_osob_klasa = n()) %>% 
    select(PassengerId, Pclass, liczba_osob_klasa) %>% 
    head(n = 20)
# kazdy rekord ma w kolumnie liczba_osob_klasa liczbe rekordow z jego klasy






# PRZYKLADY STOSOWANIA FUNKCJI z dplyr ------------------------------------


### przyklad 1 - wiele funkcji jednoczesnie ####

# sprawdzmy liczbe mezczyzn z podzialem na klasy i przezycie oraz srednia liczbe
# ich krewnych (wyliczonych jako suma kolumn SibSp i Parch)

tt %>% 
    mutate(Relatives = SibSp + Parch) %>%   # (1)
    filter(Sex == "male") %>%               # (2)
    group_by(Pclass, Survived) %>%          # (3)
    summarise(n = n(),                      # (4)
              mean.rel = mean(Relatives))   

# co sie stalo krok po kroku:
# 1. dokladamy nowa kolumne Relatives
# 2. filtrujemy, zeby zostali tylko mezczyzni
# 3. grupujemy po Pclass i Survived
# 4. podsumowujemy dane wyliczajac liczbe rekordow i srednia kolumny Relatives
#    w kazdej grupie



### przyklad 2 - podwojne grupowanie ####

# sprawdzmy, jaki procent kobiet i mezczyzn byl w kazdej klasie
tt %>% 
    group_by(Pclass) %>%                 # (1)
    mutate(n = n()) %>%                  # (2)
    group_by(Pclass, Sex) %>%            # (3)
    summarise(n2 = n() / mean(n) * 100)  # (4)

# co sie stalo krok po kroku:
# 1. grupujemy po Pclass
# 2. tworzymy nowa kolumne, ktora ma informacje o liczbie osob w kazdej klasie;
#    dzieki grupowaniu po Pclass funkcja n() dziala na grupach i wylicza liczbe
#    pasazerow w kazdej klasie
# 3. nastepnie grupujemy po Pclass i Sex 
# 4. podsumowujemy ramke po Pclass i Sex
#    - ponownie korzystamy z funkcji n(), ale tym razem wyliczamy liczbe 
#      rekordow w tych nowych grupach (tworzonych przez klase i plec) 
#    - i dzielimy ja przez liczbe rekordow z poprzednich grup 
#      (pogrupowanych tylko po klasie - kolumna n), koniecznie trzeba ja objac
#      funkcja mean, zeby miec jedna wartosc dla kazdej grupy
# 
# Drugi raz uzyta funkcja n() dziala na nowych
# grupach, utworzona wczesniej zmienna n ma wartosc dla wczesniejszych grup
# (mean(n) zwroci nam po prostu odpowiednia wartosc n)



### przyklad 3 - wielokrotna modyfikacja kolumny za pomoca ifelse ####

# stworzmy nowe dane z dodatkowa kolumna z tytulami
# wykorzystamy do tego ifelse i grepl
tt2 <- tt %>% 
    mutate(Title = ifelse(grepl("Miss", Name), "Miss", "other")) %>%
    mutate(Title = ifelse(grepl("Master", Name), "Master", Title)) %>%
    mutate(Title = ifelse(grepl("Mr.", Name, fixed = TRUE), "Mr.", Title)) %>%
    mutate(Title = ifelse(grepl("Mrs.", Name, fixed = TRUE), "Mrs.", Title))

# co sie stalo krok po kroku:
# 1. dodajemy nowa kolumne title, ktora zawiera Miss lub other
# 2. modyfikujemy te kolumne, wstawiajac slowo Master jesli zostanie znalezione
#    w kolumnie Name (jesli nie bedzie Master, to title zostaje takie jak bylo)
# 3. podobnie robimy dla Mr.
# 4. Podobnie robimy dla Mrs.
# W efekcie otrzymamy nowa ramke tt2 z kolumna Title


# sprawdzmy podstawowe informacje na podstawie tytulow
tt2 %>% 
    group_by(Title) %>% 
    summarise(n = n(), 
              mean.age = mean(Age, na.rm=TRUE))

# kim sa ci other?
tt2 %>% filter(Title == "other") %>% select(Name)
# Don, Rev., Dr., Capt. Col. itd 




