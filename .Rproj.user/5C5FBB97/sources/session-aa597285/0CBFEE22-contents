imdb <- read.csv2(file = './data/imdb.csv')
imdb <- imdb[complete.cases(imdb), 2:12]
str(imdb)

##zad76
x <- c("a", "aaa", "aa")
nchar(x)
#a
summary(nchar(imdb$Title))
#b
hist(nchar(imdb$Description), breaks = 20, xlim = c(0, 500), xlab = "" )

##zad77
#W funkcjach grep/l domyślnie są stosowane wyrażenia regularne 
#(regular expressions). Bardzo użyteczne są symbole ^ (początek tekstu),
#$ (koniec tekstu) oraz zapis [0-9] oznaczający dowolną cyfrę. 
#Dodatkowo opcja value=TRUE (tylko w funkcji grep) zwraca konkretne wartości, 
#które spełniają podany wzorzec (a nie ich indeksy, jak to jest domyślnie). 
#Przykłady działania:

x <- c("tomek", "t0mek", "tom3k", "matys", "maty5")
grep("^t", x, value = TRUE) # poczatek na "t"
grep("ek$", x, value = TRUE) # na koncu "ek"
grep("[0-9]", x, value = TRUE) # ciag zawiera dowolna cyfre w dowolnym miejscu

#a
grep("^[0-9]", imdb$Title, value = TRUE)
#b
grep(" [2-9]$", imdb$Title, value = TRUE)

##zad78
#Funkcja gsub pozwala na podmianę dowolnego ciągu znaków na inny i zwraca
#wektor z tymi zmianami. Przykład działania:
x <- c("tomek", "t0mek", "tom3k", "matys", "maty5")
gsub("t", "r", x) # wszystkie "t" zamienione na "r
gsub("[0-9]", "", x) # wszystkie cyfry zamienione na pusty ciag znakow (czyli usuniete)

#a
gsub("&", "and", grep("&", imdb$Title, value = TRUE))
#b
grep("  ", imdb$Title, value = TRUE)
gsub("  ", " ", grep("  ", imdb$Title, value = TRUE))

##zad79
#Funkcja ifelse zwraca wektor, którego wartości są uzależnione od innego wektora. 
#Przykłady działania:
y <- 1:5
ifelse(y < 3, "mniejsze niż 3", "3 lub więcej")
x <- c("tomek", "t0mek", "tom3k", "matys", "maty5")
ifelse(grepl("[0-9]", x), "zawiera liczbę", "nie zawiera liczby")

#a
imdb$dummy_comedy <- ifelse(grepl("Comedy", imdb$Genre), 1, 0)
#b
barplot(table(imdb$dummy_comedy), ylim = c(0, 600), xlab = 'czy komedia?')

##zad80
sum(grepl("Action" ,imdb$Genre))

##zad81
#a
imdb[grep("Ryan Gosling", imdb$Actors), c("Title")]
#b
imdb[grepl("Ryan Gosling", imdb$Actors) & grepl("Emma Stone", imdb$Actors), 
     c("Title")]
#c
imdb[grepl("Adam Sandler", imdb$Actors),
     c('Title', 'Rating', 'Revenue.Millions.')]

##zad82
imdb$czy_scifi <- ifelse(grepl("Sci-Fi", imdb$Genre),'Sci-Fi', 'nie Sci-Fi')
table(imdb$czy_scifi)

##zad83
#a
tapply(imdb$Rating, imdb$czy_scifi, mean)
#b
tapply(imdb$Revenue.Millions., imdb$czy_scifi, mean)

##zad84
plot(imdb[grep("Sci-Fi", imdb$Genre), c('Rating', 'Metascore')], pch = 21, 
     xlab = 'oceny widzów', ylab = 'oceny krytyków', bg = 'purple')

##zad85
imdb[imdb$Rating <= 5 & imdb$czy_scifi == 'Sci-Fi', 
     c('Title', 'Year', 'Director', 'Rating', 'Metascore')]

##zad86
vgs <- read.csv2(file = './data/vgs.csv')
#a
str(vgs)
#b
summary(vgs)
#c
sum(complete.cases(vgs))

##zad87
plot(table(vgs[vgs$year <= 2016, c('year')]), type = 'l', ylab = 'liczba gier')

##zad88
head(sort(tapply(vgs$global_sales, vgs$platform, sum), decreasing = TRUE), n = 10)

##zad89

xplatform <- vgs[grepl('^X', vgs$platform) & vgs$genre == 'Platform', ]
table(xplatform$platform) / length(xplatform$platform)

##zad90
sum(grepl("\\bMario\\b", vgs$name, useBytes = TRUE))
grep("\\bMario\\b", vgs$name, useBytes = TRUE, value = TRUE,)
?grep
# do poprawy, wychodzi 112 a powinno 109 wg pliku z zadaniami 

##zad91
tit <- read.csv(file = './data/titanic1.csv')
str(tit)
summary(tit)
#a
tit$Survived <- factor(tit$Survived, levels = c(0, 1), labels = c('not', 'yes'))
table(tit$Survived)
#b
tapply(tit$Age[tit$Pclass == 1], tit$Survived[tit$Pclass == 1], 
       function(x) mean(x, na.rm = TRUE) )

##zad92
#a
tit$Fare_interval <- factor(cut(tit$Fare, breaks = c(0, 10, 20, 50, 100, 500, Inf)))
#b
table(tit$Pclass, tit$Fare_interval)
prop.table(table(tit$Pclass, tit$Fare_interval), margin = 1)
?round
round(prop.table(table(tit$Pclass, tit$Fare_interval), margin = 1), digits = 4) *100

##zad93
tapply(tit$Fare[tit$Embarked %in% c('Q', 'S', 'C')], 
       tit$Embarked[tit$Embarked %in% c('Q', 'S', 'C')],
       function(x) mean(x, na.rm = TRUE))

tit$Embarked[tit$Embarked %in% c('Q', 'S', 'C')] 

##zad94
plot(tapply(mov$duration, mov$year, mean), type = "b" ,lty = 2, pch = 21, 
     cex = 2, col = "grey", bg = "gold", ylim = c(100, 120), yaxt = "n", 
     xaxt = "n", xlab = 'rok', ylab = 'sredni czas trwania' )
axis(2, at = seq(100, 120, 5))
axis(1, at = c(5, 10, 15), labels = c(2005, 2010, 2015))

##zad95
head(sort(tapply(mov$rating, mov$director, mean), decreasing = TRUE), n = 3)

##zad96
mov[mov$director %in% names(head(sort(tapply(mov$rating, mov$director, mean), 
                                      decreasing = TRUE), n = 3)), 
    c("director", "title", "rating")]

##zad97
bik <- read.csv2(file = './data/bikes.csv')
#a
bik$season <- factor(bik$season, levels = c(1, 2, 3, 4), 
                     labels = c('winter', 'spring', 'summer', 'autumn'))
bik$yr <- factor(bik$yr, levels = c(0, 1), labels = c(2011, 2012))
#b
bikes2012 <- bik[bik$yr == 2012, ]
#c
boxplot(bikes2012$registered ~ bikes2012$season, col = "white", 
        main = 'Wypozyczenia zarejestrowanych uzytkoników w 2012')

##zad98
#a
bik$weathersit <- factor(bik$weathersit, levels = c(1, 2, 3), 
                         labels = c('clear', 'mist', 'snow or rain'))
bik$weathersit
#b
bik_april_2011 <- bik[bik$yr == '2011' & bik$mnth == 4, ]
#c
tapply(bik_april_2011$cnt, bik_april_2011$weathersit, 
       function(x) mean(x, na.rm = TRUE))

##zad99
#a
vgs1 <- vgs[vgs$genre %in% c('Adventure', 'Role-Playing', 'Strategy'), ]
#b
vgs1$genre <- factor(vgs1$genre)
#c
plot(vgs1$na_sales, vgs1$eu_sales, pch = 21, 
     bg = c("red", 'green', 'gold')[vgs1$genre])
legend('topleft', legend = levels(vgs1$genre), cex = 0.8, 
       fill = c("red", 'green', 'gold'))
