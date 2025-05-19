
mov <- read.csv2(file = './data/movies.csv')
summary(mov)

mov$genre <- factor(mov$genre)
mov$year <- factor(mov$year)

str(mov)

##zad51
set.seed(10) # seed dla jednakowych wynikow
x <- rnorm(100, mean = 5, sd = 2) # 100 liczb z rozkladu normalnego
x.interval <- cut(x, breaks = c(0, 2.5, 5, 7.5, 10)) # podzial na 4 ustalone przedzialy
table(x.interval) # sprawdzenie liczebnosci przedzialow


mov$duration.interval <- cut(mov$duration, breaks = c(60, 90, 120, 300))

table(mov$duration.interval)

##zad52
barplot(c(3, 5, 2, 7), names.arg = letters[1:4]) # letters - wektor z literami alfabetu

barplot(table(x.interval), space = 1.5) # space pozwala zwezyc kolumny

#a
barplot(table(mov$genre), space = 1)
#b
barplot(table(mov$duration.interval), col = 'orange2')


##zad53
barplot(table(x.interval), space = 1.5, ylim = c(0, 50)) # ylim - zakres osi

#a
hist(mov$duration, breaks = 20, xlim = c(0, 300), 
     xlab = 'czas trwania', ylab = 'liczba', main = "")
?hist
#b
boxplot(mov$duration, horizontal = TRUE, ylim = c(0, 300), 
        xlab ='czas trwania', ylab = "", main = "")

##zad54
plot(1:5, c(2, 3, 6, 4, 5)) # bez zmian
plot(1:5, c(2, 3, 6, 4, 5), pch = 4, cex = 2) # zmiana ksztaltu i wielkosci
plot(1:5, c(2, 3, 6, 4, 5), pch = 21, cex = 1.5, bg = "orange") # ksztalt, wielkosc,
# wypelnienie

plot(mov$budget, mov$gross, pch = 23, bg = 'gold')


##zad55
x <- 1:5
y <- c(2, 3, 6, 4, 5)
type <- factor(c("a", "a", "b", "a", "b"))
plot(x, y, pch = 19, col = c("red", "navy")[type], cex = 1.5) # kolory wg type
legend("topleft", legend = levels(type), fill = c("red", "navy"))

#a
plot(mov$budget, mov$gross, pch = 18, 
     col = c('red', 'gold1', 'lightgreen', 'cornflowerblue')[mov$genre])
legend('topleft', legend = levels(mov$genre), 
       fill = c('red', 'gold1', 'lightgreen', 'cornflowerblue'))
#b
plot(mov$budget, mov$gross, pch = 21, 
     bg = c('red', 'gold1', 'lightgreen', 'cornflowerblue')[mov$genre])
legend('topleft', legend = levels(mov$genre), 
       fill = c('red', 'gold1', 'lightgreen', 'cornflowerblue'))

##zad56
head(mov[order(mov$gross, decreasing = TRUE), c('title', 'gross', 'year')], n = 10)

##zad57
barplot(tapply(mov$rating, mov$genre, mean), space = 2, col = 'darkred', 
        main = 'Srednia ocena filmów z poszczególnych lat', ylim = c(0,7))

##zad58

mov$profit <- mov$gross - mov$budget

plot(mov$duration, mov$profit, pch = 21, 
     bg = c('red', 'yellow', 'lightblue')[mov$duration.interval])

##zad59
head(mov[order(mov$profit, decreasing = FALSE), 
         c('title', 'gross', 'genre', 'director', 'year', 'profit')], n = 10)

##zad60
#a
boxplot(mov$profit ~ mov$genre)
#b
tapply(mov$profit, mov$genre, function(x) sd(x))

##zad61
plot(mov$budget / 1e6, mov$profit / 1e6, pch = 21,
     col = c('red', 'gold1', 'lightgreen', 'cornflowerblue')[mov$genre],
     xlab = 'budzet w milionach', ylab = 'zysk w milonach')
legend('topright', legend =  levels(mov$genre), 
       fill = c('red', 'gold1', 'lightgreen', 'cornflowerblue'))
abline(h = 0, lty = 2 )

##zad62
mov$profitable <- mov$profit >= 0
mov$profitable <- factor(mov$prfitable)

boxplot(mov$rating ~ mov$profitable)
mov$prfitable <- NULL #usunięcie zbędnej kolumny 

##zad63
prop.table(table(mov$profitable, mov$genre), margin = 2)

##zad64

bikes <- read.csv2(file = './data/bikes.csv')
str(bikes)
summary(bikes)

bikes$season <- factor(bikes$season, levels = c(1, 2, 3, 4), 
                       labels = c('winter', 'spring', 'summer', 'autumn'))
bikes$yr <- factor(bikes$yr, levels = c(0, 1), labels = c(2011, 2012))
table(bikes$season)

##zad65 

bikes$weekday <- factor(bikes$weekday, levels = c(1, 2, 3, 4, 5, 6, 0), 
                        labels = c('Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'))
table(bikes$weekday)

##zad66

bikes$weathersit <- factor(bikes$weathersit, levels = c(1, 2, 3), 
                           labels = c('clear', 'mist', 'rain/snow'))
table(bikes$weathersit)

##zad67

bikes$mnth <- factor(bikes$mnth)
bikes$holiday <- factor(bikes$holiday)
bikes$workingday <- factor(bikes$workingday)

str(bikes)

##zad68
table(bikes$registered + bikes$casual == bikes$cnt)

##zad69
tapply(bikes$cnt, bikes$yr, mean)

##zad70
plot(bikes$cnt, pch = 21, 
     col = c('cornflowerblue', 'springgreen2', 'red', 'orange3')[bikes$season])

##zad71
plot(bikes[bikes$yr == 2012, c("temp", "cnt")], pch = 21, yaxt = "n", 
     bg = c('cornflowerblue', 'springgreen2', 'red', 'orange3')[bikes$season], 
     main = 'Temperatura i wypożyczenia w 2012 roku', xlab = 'temperatura', 
     ylab = 'liczba wypożyczeń' )
axis(2, at = seq(0, 8000, 2000), labels = c('0', '2000', '', '6000', ''))
legend('topleft', legend = levels(bikes$season), 
       fill = c('cornflowerblue', 'springgreen2', 'red', 'orange3'))

##zad72
boxplot(bikes$registered ~ bikes$weekday, ylim = c(0, 7000), main = 'Registered')
boxplot(bikes$casual ~ bikes$weekday, ylim = c(0, 7000), main = 'Casual')

##zad73
bikes[bikes$casual > bikes$registered, ]

##zad74
boxplot(bikes$hum ~ bikes$weathersit)

##zad75
imdb <- read.csv2(file = './data/imdb.csv')
str(imdb)
imdb$Actors
sum(unique(imdb$Actors))

# Rozdzielenie aktorów, jeśli są w jednej kolumnie (zakładam kolumnę "actors")
library(tidyr)
library(dplyr)

# Jeśli aktorzy są zapisani w jednej kolumnie jako "aktor1, aktor2, aktor3"
imdb_long <- imdb %>%
    separate_rows(actors, sep = ", ")  # Rozdzielenie na osobne wiersze

# Liczenie liczby filmów dla każdego aktora
top_actors <- imdb_long %>%
    count(actors, sort = TRUE) %>%
    top_n(20, n)  # Pobranie top 20 aktorów

# Wyświetlenie wyników
print(top_actors)

