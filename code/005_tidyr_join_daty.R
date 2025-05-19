# *************************************************************************** #
#                                                                             #
#                   Postacie danych, laczenie tabel, daty                     #
#                                                                             #
# *************************************************************************** #




# PRZYGOTOWANIE -----------------------------------------------------------

# zaladowanie tidyverse
library(tidyverse)


# wczytanie danych o pasazerach Titanika 
# (przydadza sie do przykladow)
tt <- read.csv("./data/titanic.csv")

# zmiana niektórych kolumn na factory
tt$Survived <- factor(tt$Survived, levels = c("0", "1"),
                      labels = c("not survived", "survived")) 
tt$Pclass <- factor(tt$Pclass)
tt$Sex <- factor(tt$Sex)
tt$Embarked <- factor(tt$Embarked)






# FUNKCJE Z PAKIETU tidyr -------------------------------------------------

# funkcje z pakietu tidyr sluza do obrobki (przygotowania) danych
# pozwalaja przede wszystkim na zamiane jednej postaci danych w inna
# oraz laczenie lub rozdzielanie danych w kolumnach



### Zmiana postaci danych ####
# za pomoca funkcji pivot_longer() i pivot_wider() mozna zmienic postac danych
# tabelarycznych
# (szczegoly dotyczace postaci danych w materialach z wykladu)

# tworzymy ramke do cwiczen
df.wide <- data.frame(
    country = c("Poland", "Germany", "Brasil"),
    continent = c("Europe", "Europe", "South America"),
    yr2015 = c(20, 34, 32),
    yr2016 = c(22, 33, 31),
    yr2017 = c(25, 36, 33),
    yr2018 = c(28, 39, 35)
)
# ramka jest w "szerokiej" postaci, ma kolumny oznaczajace rok
df.wide



##### pivot_longer - wydluzanie tabeli ####
# za pomoca pivot_longer() zmieniamy tabele w waska postac
# cztery ostatnie kolumny zamienimy na dwie o nazwach "year" i "val"
# skorzystamy z funkcji pivot_longer
# i zrobimy to na kilka sposobow

# 1. sposob
# podajemy nazwy wszystkich kolumn, ktore chcemy zebrac
df.wide %>% pivot_longer(cols = c("yr2015", "yr2016", "yr2017", "yr2018"),
                         names_to = "year", values_to = "val")

# 2. sposob
# wybieramy kolumny "od ... do ..."
df.wide %>% pivot_longer(cols = yr2015:yr2018,
                         names_to = "year", values_to = "val")

# 3. sposob
# wybieramy kolumny po numerkach
df.wide %>% pivot_longer(cols = 3:6,
                         names_to = "year", values_to = "val")

# 4. sposob
# wybieramy wszystkie kolumny oprocz pierwszych dwoch
df.wide %>% pivot_longer(cols = -c(1, 2),
                         names_to = "year", values_to = "val")

# 5. sposob
# wybieramy kolumny zaczynajace sie od "yr", korzystajac z funkcji starts_with()
df.wide %>% pivot_longer(cols = starts_with("yr"),
                         names_to = "year", values_to = "val")

# mozna to jeszcze zrobic na kilka innych sposobow
# jak widac tidyr oferuje wiele mozliwosci zrobienia tego samego, 
# po to by wybrac najlepszy (w zaleznosci od danych)



##### pivot_wider - rozszerzanie tabeli ####
# utworzmy teraz ramke danych w 'dlugiej' postaci
# po to zeby pozniej ja przywrocic do postaci szerokiej
# skorzystamy z trzeciego sposobu, bo najkrotszy
df.long <- df.wide %>% 
    pivot_longer(cols = 3:6, names_to = "year", values_to = "val")
df.long

# a teraz wykorzystamy funkcje pivot_wider()) zeby z powrotem zamienic ja 
# na postac szeroka
# wewnatrz funkcji trzeba wskazac dwie kolumny: names_from i values_from
df.long %>% pivot_wider(names_from = year, values_from = val)

# pivot_longer() i pivot_wider() to naprawde potezne narzedzia obrobki danych
# choc z poczatku moze troche trudno to ogarnac



##### przyklady ####

# a) dla kazdej klasy wyswietl sredni wiek kobiet i mezczyzn 
#    (w osobnych kolumnach)
tt %>%
    group_by(Pclass, Sex) %>%       
    summarise(mean.age = mean(Age, na.rm = TRUE)) %>%     
    pivot_wider(names_from = Sex, values_from = mean.age)

# b) wyswietl PassengerId, Survived oraz dwie kolumny o nazwach: 
#    - measure - jej wartosci to nazwy zmiennych Age i Fare
#    - val - w niej beda wartosci Age lub Fare (w zaleznosci od measure)
tt %>% 
    select(PassengerId, Survived, Age, Fare) %>% # wybieram kolumny
    pivot_longer(cols = Age:Fare, names_to = "measure", values_to = "val") 
# przyjrzyj sie temu, co zrobilismy - tym razem przeszlismy do postaci dlugiej,
# kazdej osoby dotycza teraz 2 rekordy - dlatego wazne bylo, zeby wybrac
# tez kolumne PassengerId, bo zgubilibysmy informacje o ktora osobe chodzi




### Laczenie i rozdzielanie danych ####

##### separate ####
# za pomoca funkcji separate() mozna rozdzielic wartosci w kolumnie
# trzeba wybrac kolumne, nazwy nowych kolumn i separator 
# (albo liczbe znakow, wg ktorej nalezy podzielic kolumne)
# ponizej oddzielamy litery 'yr' z kolumny 'year'
df.long
df.long %>% separate(col = year, into = c('yr', 'year'), sep = 2)
# kolumna rok zostala rozdzielona po drugim znaku na yr i year
# domyslnie oryginalna kolumna znika, ale mozna to zmienic: remove = FALSE



##### unite ####
# funkcja unite() pozwala polaczyc kilka kolumn w jedna
# trzeba wybrac nazwe nowej kolumny, wskazac ktore kolumny laczymy
# oraz czym polaczymy ich wartosci
df.long %>% unite("country_yr", c(country, year), sep=':')
# kolumny country i year zostaly polaczone w country_yr za pomoca dwukropka




    

# LACZENIE DANYCH Z KILKU ZBIOROW (dplyr) ---------------------------------

### Przygotowanie ####
# wczytanie nowych danych o filmach
mov <- read.csv2("./data/movie2_movies.csv")
mov <- mov %>% distinct() # usuniecie duplikatow (jeden rekord sie powtarzal)

# sprawdzenie
str(mov)
head(mov)
# kazdy film ma swoje unikatowe id

# wczytanie danych o ocenach
votes <- read.csv2("./data/movie2_votes.csv")

# sprawdzenie
str(votes)
head(votes)
# w tym pliku znajduja sie oceny roznych filmow przyznane przez uzytkownikow
# identyfikator filmu to tutaj movieId


# zobaczmy np. oceny filmu Heat ("Goraczka", rez. M. Mann - super film!)

# najpierw znajdzmy id tego filmu
mov %>% filter(title == "Heat")
# 949

# a teraz znajdzmy oceny tego filmu w danych votes
votes %>% filter(movieId == 949)
# jest 16 ocen, oceny przyznali uzytkownicy 23, 102 itd., najwyzsza ocene
# wystawil uzytkownik 387




### Laczenie wewnetrzne - inner_join ####
# polaczmy te dane, zeby obliczyc srednia ocene kazdego ocenionego filmu
# W pakiecie dplyr znajduja sie funkcje inner_join, left_join itd.
# dzialajace dokladnie tak samo jak zlaczenia w SQL
?inner_join

# utworzmy tabele mov_votes, ktora bedzie zawierala dane o wszystkich filmach
# polaczone z danymi z votes, wspolne pola tych dwoch zbiorow danych
# to id filmu, ktore w mov nazywa sie "id", a w votes "movieId"
mov_votes <- inner_join(mov, votes, by = c("id" = "movieId"))
head(mov_votes)
# nowa ramka jest znacznie wieksza, bo kazdy film powtarza sie tyle razy, ile
# otrzymal ocen; w nowej ramce znajduja sie tez id uzytkownikow oraz ich oceny
# natomiast nie ma juz kolumny movieId, bo ona miala te same wartosci co id,
# wiec inner_join sprytnie ja pominal i teraz kolumna id to identyfiaktor filmu

# majac te dane polaczone mozna pytac o wszystko, np. o 20 filmow z najwyzsza 
# ocena, ale tylko tych, ktore maja przynajmniej 100 ocen
mov_votes %>% 
    group_by(id, title, release_date) %>%    # (1)
    summarise(votes.count = n(), mean.rate = mean(rating)) %>% 
    filter(votes.count >= 100) %>% 
    arrange(desc(mean.rate)) %>% 
    head(n = 20)
# hmm, Faceci w czerni 2 na czwartym miejscu? jakies niemadre sa te dane...
# (1) - grupuje po id, title i release_date, bo chce je zobaczyc




### Przyklad laczenia zewnetrznego - right_join ####

# ale w mov_votes jest znacznie mniej danych niz w votes, wynika to stad, ze
# wiele glosow dotyczy filmow, ktorych nie ma w danych mov
# sprawdzmy ile to glosow - tym razem right_join i wyliczenie ile jest brakow
# w kolumnie title
mov_allVotes <- right_join(mov, votes, by = c("id" = "movieId"))
tail(mov_allVotes, n = 10) # niepasujace dane sa umieszczane na koncu
mov_allVotes %>% filter(is.na(title)) %>% nrow()
# 72564 - tyle glosow dotyczy filmow, ktorych nie ma w danych mov






# DATY W R  ---------------------------------------------------------------

### Wprowadzenie ####

# daty to kolejny rodzaj danych, R tez sobie z nimi radzi
# zobaczymy to na przykladzie danych o UFO 

# wczytanie danych
ufo <- read.csv(unzip("./data/ufo.zip", exdir = "./data")) 
# dane zostana automatycznie wypakowane do wskazanego folderu
# (jesli nie podamy exdir to do folderu roboczego)

# sprawdzenie
str(ufo)
# dwie kolumny: datetime i date.posted jako character
# a to sa daty (datetime to nawet data i czas)

# podstawiamy ramke pod nowa zmienna
ufo1 <- ufo

# zamiana kolumny datetime w ufo1 na date
# korzystamy z funkcji as.Date i podajemy formatowanie
# as.Date jest w podstawowym R
ufo1$datetime <- as.Date(ufo$datetime,"%m/%d/%Y")

# sprawdzamy
ufo$datetime %>% head   # oryginalne dane z ufo - wektor znakowy
ufo1$datetime %>% head  # nowe dane z ufo1 - data bez godziny
ufo1$datetime %>% class # to nas upewnia, ze dostajemy date
# ale w ten sposob straclismy godziny




### Pakiet lubridate ####

# pakiet lubridate z tidyverse ulatwia prace z datami (i z czasem)
# library(lubridate)
# we wczesniejszych wersjach lubridate trzeba bylo zaladowac osobno

# rodzina funkcji ymd automatycznie stara sie rozpoznac separator daty
# wystarczy tylko wybrac odpowiednia funkcje
?ymd     # ymd - rok, miesiac, dzien; mdy - miesiac, dzien, rok itd.
?ymd_hm  # nie tylko daty ale tez godziny, minuty, (i sekundy jak trzeba)

# sprawdzenie
mdy_hm(ufo$datetime) %>% head # dostajemy date i czas

# poprawmy dane
ufo$datetime <- mdy_hm(ufo$datetime)
ufo$date.posted <- mdy(ufo$date.posted)

# i sprawdzmy jak teraz widzi je R
str(ufo)
# - kolumna datetime ma klase POSIXct (czas kalendarzowy)
# - kolumna date.posted ma klase Date (sama data)

# za pomoca funkcji z pakietu lubridate mozna z pola datetime wybierac sama 
# date, godzine, minute, rok, miesiac, dzien miesiaca, dzien w roku, 
# dzien w tygodniu itd.
ufo$datetime %>% head # data i czas
ufo$datetime %>% date() %>% head  # date() - tylko data
ufo$datetime %>% hour() %>% head  # hour() - tylko godzina
ufo$datetime %>% year() %>% head  # year() - rok z daty
ufo$datetime %>% month() %>% head # month() - numer miesiaca
ufo$datetime %>% mday() %>% head  # mday() - dzien w miesiacu
ufo$datetime %>% yday() %>% head  # yday() - numer dnia w roku
ufo$datetime %>% wday() %>% head  # wday() - numer dnia w tygodniu, domyslnie
                                             # 1 to ND
ufo$datetime %>% wday(week_start = 1) %>% head  # zmiana zeby 1 to byl PN




### Przyklady ####

##### przyklad 1 ####
# sprawdzmy (na rozne sposoby) w ktorych dniach tygodnia pojawilo 
# sie najwiecej UFO

# dplyr z funkcja count (count to jednoczesnie group_by i n() )
ufo %>% 
    mutate(week.day = wday(datetime, week_start = 1)) %>% 
    count(week.day)
# w sobote najwiecej

# z table - tradycyjnie
table(wday(ufo$datetime, week_start = 1)) # najwiecej 6 dnia

# z table - potokowo
ufo$datetime %>% wday(week_start = 1) %>% table

# z nazwami dni tygodnia
ufo$datetime %>% wday(week_start = 1, label = TRUE, abbr = FALSE) %>% table

# dolozmy wykres
ufo$datetime %>% wday(week_start = 1, label = TRUE) %>% table %>% barplot()

# lepiej po angielsku
ufo$datetime %>% 
    wday(week_start = 1, label = TRUE, locale = "English") %>% 
    table %>% 
    barplot(space = 1, col = "violet")
# czy fioletowy to kolor UFO?



##### przyklad 2 ####
# sprawdzmy liczbe pojawien sie UFO typu light, triangle lub circle
# w poszczegolnych dniach tygodnia

# to juz najlepiej zrobic z dplyrem
ufo %>% 
    filter(shape %in% c("light", "triangle", "circle")) %>% 
    mutate(week.day = wday(datetime, week_start = 1, label = TRUE, 
                           locale = "English")) %>% 
    group_by(shape, week.day) %>%
    summarise(n = n()) %>% 
    pivot_wider(names_from = week.day, values_from = n)
# w kazdym przypadku najwiecej w sobote - moze UFO ma wtedy wolne i zwiedza? 