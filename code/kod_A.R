# kolokwium A

# imie i nazwisko: Sebastian Giełżecki

# grupa.sekcja: 4




# 1
# a
x <- seq(-3, 3, 0.2)
#b
y <- (x - 1) ^2 - 5
#c
sum( y > quantile(y, 0.25))
#d
plot(x, y, type = "l", col = 'red')
abline(h = 0, type = "l",  lty = 2)

#2
vgs <- read.csv2(file = './data/vgs.csv')
#a
str(vgs) #?
#b
colnames(vgs)
#c
summary(vgs$global_sales)
#d
max(vgs$global_sales) - min(vgs$global_sales)
#e
sum(vgs[ ,c("global_sales")] < mean(vgs$global_sales)) / 
    length(vgs$global_sales) * 100

#3
#a
sum(complete.cases(vgs) == FALSE)
#b
table(vgs$genre)
#c
vgs1 <- vgs[vgs$platform == c('PC', 'PS3'), ]

table(vgs1$genre, vgs1$platform)
prop.table(table(vgs1$genre, vgs1$platform), margin = 2) *100

# najwięcej gier na PC jest gier Strategy 
# i stanowią one 20.0863931% wszystkich gier na PC

# najwięcej gier na PS3 jest gier Action 
# i stanowią one 28.3559578% wszystkich gier na PC

#4
#a
sum(vgs$jp_sales > vgs$na_sales)
#b
head(order(vgs$jp_sales, decreasing = TRUE), n = 5)
vgs[head(order(vgs$jp_sales, decreasing = TRUE), n = 5), 
    c("name", "platform", "genre", "na_sales", "jp_sales")]
#c
sum(grepl("[5-9]$", vgs$name, useBytes = TRUE))

#5
#a
vgs2 <- vgs[vgs$year == 2015 & vgs$genre == 'Action' & 
                vgs$platform %in% c('PS3', 'PS4', 'X360', 'XOne'), ]

#b
sum(grepl('a', vgs2$name, ignore.case = TRUE )) / 
    length(vgs2$name) * 100
#c
vgs2$platform <- gsub('PS3', 'Playstation', vgs2$platform)
vgs2$platform <- gsub('PS4', 'Playstation', vgs2$platform)
vgs2$platform <- gsub('X360', 'XBox', vgs2$platform) 
vgs2$platform <- gsub('XOne', 'XBox', vgs2$platform)

vgs2$platform <- factor(vgs2$platform)

plot(vgs2$na_sales, vgs2$eu_sales, pch = 21, 
     bg = c('red', 'green')[vgs2$platform], 
     xlab = 'Sprzedarz w Ameryce', ylab = 'Sprzedarz w Europie')
legend('topleft', legend = levels(vgs2$platform), 
       fill = c('red', 'green'))
#d
boxplot(vgs2$eu_sales ~ vgs2$platform)
boxplot(vgs2$na_sales ~ vgs2$platform)

# rozkłady te są bardziej zbliżone w europie 

