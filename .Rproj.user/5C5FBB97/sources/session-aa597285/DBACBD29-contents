###zadania_001 

##zad1
#a
c(5,6,2)
#b
1:20
#c
20:1
#d
c(1:20,19:1)

##zad2 
#a
seq(10,100,10)
#b
seq(1,5,0.5)
#c
seq(-3,3,0.3)
#d
seq(10,0,-2)

##zad3 
x <- c(1:10)
#a
x^2
#b
1/x
#c
1/x^2

##zad4
#a
mean(x)
#b
sum(x)
#c
x-mean(x)
#d
(x-mean(x))^2
#e
sum(x-mean(x))
#f
sum((x-mean(x))^2)

##zad5
#a
sum(abs(x-mean(x)))
#b
sqrt(sum((x-mean(x))^2))

##zad6
y <- 1:10 %% 3+1
# wynikiem bedzie wektor (2, 3, 1, 2, 3, 1, 2, 3, 1, 2), czyli reszta z dzielenia liczb 1:10 przez 3 powiększona o 1
#a
x+y
#b
x*y
#c
sum(x/y)

##zad7
a <- c(2,1)
b <- c(6,4)

sqrt(sum((b-a)^2))

##zad8
set.seed(42)
v <- sample.int(365,80,replace = TRUE)

length(unique(v))

##zad9
#a
plot(x,y)
#b
plot(x,y,type = "l")
#c
plot(x,y, type = "l", lty = 2, col = "red")

##zad10
#a do poprawy 
x <- seq(-10,20,1)
x <- c(-10:20)
y <- x^2 - 5*x - 5
plot(x,y, type = 'l', col = 'red')
abline(h=0,v=0)

#b do poprawy 
x <- c(-15:10)
y <- x^3 + 10*x^2 - 10*x - 50
plot(x,y, type = 'l', col = 'red')
abline(h=0,v=0)

#c
x <- seq(0,10,0.1)
y <- sqrt(x)
plot(x,y, type = 'l', col = 'red')
abline(h=0,v=0)

#d
x <- seq(-4,4,0.1)
y <- 1/x
plot(x,y, type = 'l', col = 'red')
abline(h=0,v=0)

#e
x <- seq(-4,4,0.1)
y <- 1/(x-1) - 1
plot(x,y, type = 'l', col = 'red')
abline(h=0,v=0)


##zad11
?rivers
#a
mean(rivers)
#b
mean(rivers * 1.609344)

##zad12
plot(lynx, type = 'b', col = 'red', 
     main = 'Liczba upolowanych rysiów w Kanadzie w latach 1821-1934',
     xlab = 'rok', ylab = 'liczba')

##zad13 
rep(c(1,2), times = c(2,3))
rep(c(1,2), times = 2, each = 4)
#a
rep(6, times = 80)
#b
rep('kajak', times = 20)
#c
rep(c(5,6,2), times = 25)
#d
rep(c(5,6,2), times = c(10,15,7))
#e
rep(c('a','b'), times = c(5,7))

##zad14
?quantile
quantile(rivers)
#a
quantile(rivers, probs = seq(0.25, 0.75, 0.25))
#b
quantile(rivers, probs = seq(0.10, 0.90, 0.10))
#c
quantile(rivers, probs = c(0.05,0.95))

##zad15
?plot
e <- exp(1)
?exp

x <- seq(-10,10,0.25)
y <- 1/(1 + e^(-x))

plot(x,y, type = 'l', lty = 2, col = 'red',
     main = 'Funkcja logistyczna', xlab = 'x', 
     ylab = '1/1+e^-x')
abline(h=0,v=0)
??lty
