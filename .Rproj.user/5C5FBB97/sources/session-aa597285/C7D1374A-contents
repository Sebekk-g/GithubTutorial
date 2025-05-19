###zad006

library(tidyverse)
mov <- read.csv2(file = './data/movies.csv')
mov$genre <- factor(mov$genre)
    
##zad101
#a
mov %>% 
    filter(duration > 180) %>% 
    select(title, genre, year, duration)
#b
mov %>% 
    filter(gross > 600000000 | rating > 8.5) %>% 
    select(title, year, gross, rating)

##zad102
#a
mov %>% 
    filter(year >= 2011 & year <= 2016, rating >= 8.2) %>% 
    select(title, year, rating) %>% 
    arrange(rating)
#b
mov %>% 
    filter(genre == 'Comedy', budget > 90000000) %>% 
    select(title, year, genre, budget) %>% 
    arrange(desc(budget))

##zad103
#a
mov %>% 
    group_by(year) %>% 
    summarise(mean.duration = mean(duration),
              mean.rating = mean(rating))
#b 
mov %>% 
    group_by(genre) %>% 
    summarise(mean.budget = mean(budget), 
              mean.gross = mean(gross))

##zad104
#a
mov %>% 
    filter(year %in% c(2010, 2011)) %>% 
    group_by(year, genre) %>% 
    summarise(mean.reviews = mean(reviews))

##zad105
#a
mov %>% 
    mutate(budget_mln = budget / 1000000, 
           gross_mln = round(gross / 1000000, 2)) %>% 
    select(title, year, budget_mln, gross_mln) %>% 
    head(n = 15)
#b
mov %>% 
    mutate(profit = gross - budget) %>% 
    select(title, profit) %>% 
    arrange(desc(profit)) %>% 
    head(n = 10)

##zad106 
mov %>% 
    mutate(duration2 = cut(duration, breaks = c(-Inf, 90, 120, 180, Inf))) %>% 
    select(title, rating, duration, duration2) %>% 
    arrange(desc(rating)) %>% 
    head(n = 10)

##zad107
mov.action10 <- mov %>% 
    filter(genre == 'Action') %>% 
    select(title, director, year, gross) %>% 
    arrange(desc(gross)) %>% 
    head(n = 10)
mov.action10

##zad108
mov.genre.rating <- mov %>% 
    group_by(genre) %>% 
    summarise(mean.rating = mean(rating),
              median.rating = median(rating),
              max.rating = max(rating), 
              min.rating = min(rating))
mov.genre.rating

##zad109
barplot(mov.genre.rating$median.rating, ylim = c(0,7), space = 3, col = 'gold',
        names.arg = as.factor(mov.genre.rating$genre), ylab = 'mediana ocen')

##zad110
mov.year.rating <- mov %>% 
    group_by(year) %>% 
    summarise(mean.rating = mean(rating))
head(mov.year.rating, n = 5)

##zad111
mov.year.genre <- mov %>% 
    group_by(year, genre) %>% 
    summarise(mean.rating = mean(rating), 
              n = n())
head(mov.year.genre, n = 8)

##zad112
mov %>% 
    mutate(profit = gross - budget) %>% 
    group_by(director) %>% 
    mutate(dir.n.films = n()) %>% 
    filter(dir.n.films >= 5) %>% 
    summarise(mean.profit = mean(profit) / 1000000, 
              n = mean(dir.n.films)) %>% 
    arrange(desc(mean.profit)) %>% 
    head(n = 10) %>% 
    as.data.frame()

##zad113
pir <- pirates
pir$sex <- factor(pir$sex)
pir$headband <- factor(pir$headband)
pir$college <- factor(pir$college)
pir$favorite.pirate <- factor(pir$favorite.pirate)
pir$sword.type <- factor(pir$sword.type)
pir$fav.pixar <- factor(pir$fav.pixar)
str(pir)

##zad114
pir %>% 
    select(id, sex, age) %>% 
    arrange(desc(age)) %>% 
    head(n = 10)

##zad115 
pir %>% 
    select(id, sex, beard.length) %>% 
    arrange(desc(beard.length)) %>% 
    head(n = 10)

##zad116
pir %>% 
    filter(eyepatch == 1) %>% 
    select(id, sex, eyepatch, parrots) %>% 
    arrange(desc(parrots)) %>% 
    head(n = 10)

##zad117
pir %>% 
    filter(favorite.pirate == 'Blackbeard') %>% 
    select(id, sex, favorite.pirate, sword.type, tchests) %>% 
    arrange(desc(tchests)) %>% 
    head(n = 10)

##zad118
pir %>% 
    group_by(college) %>% 
    summarise(mean.tchests = mean(tchests), 
              n = n())

##zad119
pir %>% 
    group_by(college, sex) %>% 
    summarise(mean.tchests = mean(tchests), 
              n = n())

##zad120
pir %>% 
    group_by(sex) %>% 
    summarise(mean.age = mean(age),
              mean.beard = mean(beard.length),
              mean.grogg = mean(grogg))

##zad121
pir %>% 
    group_by(sex) %>% 
    summarise(mean.x = mean(height)) %>% 
    arrange(desc(mean.x))

##zad122
pir %>% 
    group_by(headband) %>% 
    summarise(mean.x = mean(tattoos)) %>% 
    arrange(desc(mean.x))

##zad123
pir %>% 
    group_by(sword.type) %>% 
    summarise(mean.x = mean(tchests)) %>% 
    arrange(desc(mean.x))

##zad124
pir %>% 
    group_by(headband) %>% 
    summarise(mean.x = mean(sword.time)) %>% 
    arrange(desc(mean.x))
