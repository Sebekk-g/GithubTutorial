library(tidyverse)
vgs <- read.csv2(file = './data/vgs.csv')
vgs$genre <- factor(vgs$genre)
str(vgs)

##zad126
vgs %>% 
    filter(platform == 'PC') %>% 
    select(name, na_sales, eu_sales, jp_sales, other_sales) %>% 
    pivot_longer(cols = 2:5, names_to = 'market', values_to = 'sales') %>% 
    arrange(desc(sales)) %>% 
    head(n = 10)

##zad127
vgs %>% 
    filter(genre == 'Platform', year == 1983) %>% 
    select(name, na_sales, eu_sales, jp_sales) %>% 
    pivot_longer(cols = 2:4, names_to = 'sales', values_to = 'value') 

##zad128
vgs %>% 
    filter(genre == 'Platform', year == 1983) %>% 
    select(name, na_sales, eu_sales, jp_sales) %>% 
    pivot_longer(cols = 2:4, names_to = 'sales', values_to = 'value') %>% 
    separate(col = sales, into = 'market', sep = 2)

##zad129
vgs %>% 
    filter(year %in% c(2005:2010)) %>% 
    group_by(year, genre) %>% 
    summarise(n = n()) %>% 
    pivot_wider(names_from = year, values_from = n)

##zad130
vgs %>% 
    filter(year %in% c(2005:2010)) %>% 
    group_by(year, genre) %>% 
    summarise(n = n()) %>% 
    filter(grepl('s', genre, ignore.case = TRUE)) %>% 
    pivot_wider(names_from = genre, values_from = n) 

##zad131
vgs %>% 
    filter(year %in% c(2012:2016)) %>% 
    group_by(year, genre) %>% 
    summarise(mean.global_sale = round(mean(global_sales), 2)) %>% 
    pivot_wider(names_from = year, values_from = mean.global_sale)



ufo <- read.csv(unzip('./data/ufo.zip', exdir = './data'))

ufo$datetime <- mdy_hm(ufo$datetime)
ufo$date.posted <- mdy(ufo$date.posted)
ufo$country <- factor(ufo$country)
ufo$shape <- factor(ufo$shape)

##zd132
ufo %>% 
    mutate(year = year(ufo$datetime)) %>% 
    filter(year %in% c(1941:1960)) %>% 
    group_by(year) %>% 
    summarise(n = n())

##zad133
ufo %>% 
    mutate(year = year(ufo$datetime)) %>% 
    filter(year %in% c(1994:2002), shape %in% c('light', 'disk')) %>% 
    group_by(year, shape) %>% 
    summarise(n = n())

##zad134    
ufo %>% 
    mutate(year = year(ufo$datetime)) %>% 
    filter(year %in% c(1994:2002), shape %in% c('light', 'disk')) %>% 
    group_by(year, shape) %>% 
    summarise(n = n()) %>% 
    pivot_wider(names_from = shape, values_from = n)

##zad135
ufo %>% 
    filter(shape %in% c('disk', 'fireball', 'triangle'), 
           state %in% c('fl', 'tx', 'ny')) %>% 
    group_by(shape, state) %>% 
    summarise(n = n()) %>% 
    pivot_wider(names_from = state, values_from = n)

##zad136
ufo %>% 
    select(datetime, shape) %>% 
    separate(col = datetime, into = c('date', 'time'), sep = 10) %>% 
    head(n = 20)

##zad137
ufo %>% 
    mutate(hr = hour(ufo$datetime)) %>% 
    group_by(hr) %>% 
    summarise(n = n()) %>% 
    arrange(desc(n))

##zad138
ufo %>% 
    filter(year(datetime) >= 2001) %>% 
    count(shape) %>% 
    filter(n > 1000) %>% 
    arrange(desc(n))

##zad139
ufo %>% 
    mutate(age = ifelse(year(datetime) >= 2001, 'XXI w.', 'XX w.')) %>% 
    group_by(shape, age) %>% 
    summarise(n = n()) %>% 
    arrange(desc(n)) %>% 
    pivot_wider(names_from = age, values_from = n)

#chyba dobrze ale dopytać się 
ufo %>% 
    mutate(age = ifelse(year(datetime) >= 2001, 'XXI w.', 'XX w.')) %>% 
    count(shape, age) %>% 
    group_by(shape) %>% 
    mutate(total = sum(n)) %>% 
    arrange(desc(total)) %>% 
    pivot_wider(names_from = age, values_from = n)

##zad140
ufo %>% 
    mutate(year = year(datetime)) %>%
    filter(year %in% c(1980:2015)) %>%
    group_by(year) %>%
    summarise(n = n()) %>% 
    plot(type = 'b', xlab = 'rok', ylab = 'liczba obserwacji ufo')



library(yarrr)
pir <- pirates
pir$sex <- factor(pir$sex)
pir$headband <- factor(pir$headband)
pir$college <- factor(pir$college)
pir$favorite.pirate <- factor(pir$favorite.pirate)
pir$sword.type <- factor(pir$sword.type)
pir$fav.pixar <- factor(pir$fav.pixar)

##zad141
pir %>% 
    group_by(sword.type, sex) %>% 
    summarise(mean.tchests = mean(tchests))

##zad142
pir %>% 
    group_by(sword.type, sex) %>% 
    summarise(mean.tchests = mean(tchests)) %>% 
    pivot_wider(names_from = sex, values_from = mean.tchests)

##zad143
pir %>%
    group_by(college, sex) %>% 
    summarise(mean.age = mean(age)) %>% 
    pivot_wider(names_from = sex, values_from = mean.age)

##zad144
pir %>%
    group_by(college, sex) %>% 
    summarise(n = n(),
              mean.age = mean(age), 
              mean.tchests = mean(tchests))

##zad145
pir %>%
    group_by(college, sex) %>% 
    summarise(n = n(),
              mean.age = mean(age), 
              mean.tchests = mean(tchests)) %>% 
    pivot_longer(cols = 3:5, names_to = 'name', values_to = 'value')

##zad146
pir %>% 
    group_by(favorite.pirate, sex) %>% 
    summarise(n = n()) %>% 
    pivot_wider(names_from = sex, values_from = n)

##zad147
pir %>% 
    group_by(sex) %>% 
    mutate(n = n()) %>% 
    group_by(favorite.pirate, sex) %>% 
    summarise(n2 = n() / mean(n) * 100) %>% 
    pivot_wider(names_from = sex, values_from = n2)

##zad148
?pivot_wider
pir %>% 
    group_by(fav.pixar, sex) %>% 
    count(sex) %>% 
    pivot_wider(names_from = sex, values_from = n, values_fill = 0)

##zad149
pir %>% 
    select(beard.length, grogg, parrots, tattoos) %>% 
    boxplot(xlab = 'zmienna', ylab = 'wartość', 
            main = 'Rozkład wybranych zmiennych')
