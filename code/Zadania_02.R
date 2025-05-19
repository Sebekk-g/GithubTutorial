###zadania_002 

##zad16
x <- c(6,4,2,7,1,9,0,6)
#a
x == 6
#b
x != 6
#c
x > 4
#d
x < 3 | x > 6

##zad17
#a
x[x<5]
#b
x[x<2 | x>7]
#c
x[x>4 & x<9]

##zad18
#a
rivers[rivers>1000]
#b
sum(rivers<300)
#c
sum(rivers>mean(rivers))
#d
sum(rivers<mean(rivers)) / length(rivers)
#e
sum(rivers <= quantile(rivers,0.25))

##zad19
set.seed(42)
x <- rnorm(100000, mean = 100, sd = 15)
#a
mean(x)
#b
sd(x)
#c
sum(x<mean(x))/length(x)*100
#d
sum(x<(mean(x)-sd(x)))/length(x)*100
#e
sum(x>(mean(x)-2*sd(x)) & x<(mean(x)+2*sd(x)))/length(x)*100


##zad20
data(mtcars)
head(mtcars)    
str(mtcars)

#a
max(mtcars$wt)
#b
mean(mtcars$wt)
#c
table(mtcars$am)
#d
table(mtcars$am)/length(mtcars$am)*100
#e
mean(mtcars$mpg[mtcars$gear == 4])
#f
mean(mtcars$qsec[mtcars$wt < 2])

##zad21
plot(mtcars$wt, mtcars$mpg)

##zad22
#a
mtcars[1:4,]
#b
mtcars[mtcars$carb == 1 , ]
#c
mtcars[mtcars$wt > 4 , ]
#d
mtcars[mtcars$hp >150 & mtcars$wt > 5 , ]

##zad23
#a
mtcars[mtcars$wt < 2.2 , c('wt','hp','cyl','disp') ]
#b
mtcars[mtcars$hp < 80 , c('hp','cyl','mpg') ]
#c
mtcars[mtcars$am == 1  & mtcars$qsec < 16, c('qsec','am')]

##zad24
mtcars_am0 <- mtcars[mtcars$am == 0 , ]
#a
dim(mtcars_am0)
#b
plot(mtcars_am0$wt, mtcars_am0$hp)

##zad25
hist(mtcars_am0$disp, main = 'Histogram zmiennej disp')

##zad26
boxplot(mtcars$hp~mtcars$am, col = 'lightsalmon' )

##zad27
#a
str(InsectSprays)
#b 
table(InsectSprays$spray)
#c
mean(InsectSprays$count[InsectSprays$spray == "A"])
#d
mean(InsectSprays$count[InsectSprays$spray == "C"])

sum(InsectSprays$count)

InsectSprays$count[InsectSprays$spray == "A"]
InsectSprays$count
InsectSprays

#e
boxplot(InsectSprays$count ~ InsectSprays$spray, 
        xlab = "preparat", ylab = 'liczba insektów' )

##zad28
arr <- USArrests
# nowa kolumna
arr$State <- rownames(USArrests) # funkcja rownames() zwraca nazwy wierszy
arr

#a
arr$State[arr$UrbanPop < 50 ]
#b
arr$State[arr$Rape == max(arr$Rape)]
#c
arr$State[arr$Murder == min(arr$Murder)]
#d
sum(arr$Assault > 200)
#e
?boxplot
boxplot(arr$Assault, horizontal = TRUE)

##zad29
v <- c(5, NA, 2, NA, 7)
is.na(v)
!is.na(v)

set.seed(10) # ziarno generatora liczb losowych
grades <- sample(c(5, 4.5, 4, 3.5, 3, NA), 58, replace = TRUE) # symulacja 58 ocen

#a
is.na(grades)
#b
sum(!is.na(grades) == TRUE)
#c
grades[is.na(grades) == FALSE]
#d
?sum
sum(grades == 5.0, na.rm = TRUE)
#e
?mean
mean(grades, na.rm = TRUE)

##zad30
order(arr$UrbanPop, decreasing = TRUE)
arr_1 <- arr[order(arr$UrbanPop, decreasing = TRUE),]
arr_top12 <- arr_1[1:12,]
plot(arr_top12$Assault, arr_top12$Murder,
     xlab = "Assulat", ylab = "Murder",
     pch = 21, col = "black", bg = "black", cex = 0.5)

text(arr_top12$Assault, arr_top12$Murder, labels = arr_top12$State, 
     pos = 3, cex = 0.5,adj = 0.5)

?text
?plot
?pch
