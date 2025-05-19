
## [] służy do wybierania określonych danych z wektora, ramki, tbaeli 

## faktory traktowane są jak zmienne kategoryczne, 
##nie da się na nich wykonywać działań, działają jak etykiety

## funkcja taplly działa jeśli nie ma w rekordach wartości NA, 
##inaczej wyskakuje nam błąd 


###zadania_03

##zad31
tt <- read.csv(file = "./data/titanic.csv")
tt$Survived <- factor(tt$Survived, levels = c(0, 1),
                      labels = c("not survived", "survived"))
tt$Pclass <- factor(tt$Pclass)
tt$Sex <- factor(tt$Sex)
tt$Embarked <- factor(tt$Embarked)

#a
nrow(tt)
#b
table(tt$Sex)
#c
mean(tt$Fare)
#d
mean(tt$Fare[tt$Sex == 'female'])
#e
sum(tt$Fare>100)

##zad32
#a
table(tt$Pclass)
#b
mean(tt$Fare[tt$Pclass == 1])
#c
tapply(tt$Fare, tt$Pclass, mean)
#d
sum(tt$Fare < 20 & tt$Pclass == 2)

##zad33
#a
mean(tt$Age, na.rm = TRUE)
#b
summary(tt$Age)
#c
mean(tt$Age [tt$Sex == 'male'], na.rm = TRUE)
#d
tapply(tt$Age, tt$Sex, function(x) mean(x, na.rm = TRUE)  )

##zad34
#a
tapply(tt$Age, tt$Sex, function(x) sum(is.na(x) == TRUE))
#b
tt[tt$Age >=70 & is.na(tt$Age) == FALSE, c("Name", "Sex", "Pclass", "Age")]
#c 
tapply(tt$Age, tt$Pclass, max, na.rm = TRUE)

##zad35
#a
table(tt$Embarked)
#b
tt[tt$Embarked != "S" & tt$Embarked != "Q" & tt$Embarked != "C",
   c("Name", "Sex", "Age", "Pclass", "Embarked", "Cabin")]

##zad36
#a
table(tt$Survived)
#b
table(tt$Survived) / length(tt$Survived) * 100
#c
table(tt$Survived, tt$Pclass)
#d
prop.table(table(tt$Survived, tt$Pclass)) * 100

##zad37
#a
prop.table(table(tt$Survived, tt$Pclass), margin = 1) * 100
#b
prop.table(table(tt$Survived, tt$Pclass), margin = 2) * 100

##zad38
?complete.cases
prop.table(table(tt$Survived, complete.cases(tt)), margin = 2) * 100

##zda39
tt$Relatives <- tt$SibSp + tt$Parch

#a
sum(tt$Relatives == 0)
#b
tt_39b <- prop.table(table(tt$Relatives)) * 100
round(tt_39b, 2)

##zad40
boxplot(tt$Age ~ tt$Sex, col = "lemonchiffon")

##zad41
#a
boxplot(tt$Fare ~ tt$Survived, col = "lightslateblue", horizontal = TRUE)
?boxplot
#b
boxplot(tt$Fare ~ tt$Survived, col = "lightslateblue", outline = FALSE )

##zad42
#a
?head
head(tt$Age[order(tt$Age, decreasing = TRUE)], n = 20)
#b
head(tt[order(tt$Age), c("Name", "Age", 'Sex', 'Survived')], n = 10)

##zad43
#a
sum(grepl('Ann', tt$Name))
#b
tt$Name[grep('Ann', tt$Name)]

##zad44
#a
mean(tt$Age[grep('Master', tt$Name)], na.rm = TRUE)
#b
mean(tt$Age[grep('Mr.', tt$Name, fixed = TRUE)], na.rm = TRUE)
#c
tt[grep('Rev.', tt$Name, fixed = TRUE), c('Name', 'Age', 'Pclass', 'Survived')]

##zad45
mov <- read.csv2(file = './data/movies.csv')
mov$genre <- factor(mov$genre)

#a
str(mov)
#b
summary(mov)

##zad46
#a
table(mov$year)
#b
tapply(mov$gross, mov$year, mean)

##zad47
plot(tapply(mov$gross, mov$year, mean), type = 'b', yaxt = 'n', xaxt = 'n',
     xlab = 'rok', ylab = 'przychód (w milionach)')
axis(1, at = c(5, 10, 15), labels = c(2005, 2010, 2015))
axis(2, at = seq(50000000, 90000000, 10000000), labels = c(50, 60, 70, 80, 90))

##zad48
pokemon1_4 <- read.csv("./data/pokemon1_4.csv", skip = 3)
pokemon5_6 <- read.csv("./data/pokemon5_6.csv")

#a
?read.csv
#dla pominięcia pierwszych 3 linijek z pliku które były do pominięcia 
#b
?rbind
pokemon <- rbind(pokemon1_4, pokemon5_6)
#c
pokemon <- pokemon[ ,2:13]
str(pokemon)
#d
names(pokemon)[2] <- 'Type1'
names(pokemon)[3] <- 'Type2'
names(pokemon)[8] <- 'SpAtk'
names(pokemon)[9] <- 'SpDef'
#e
pokemon$Legendary <- factor(pokemon$Legendary, 
                            levels = c("False","True"), 
                            labels = c('no', 'yes'))
str(pokemon)

##zad49
#a
boxplot(pokemon$Attack ~ pokemon$Legendary, 
        xlab = 'Legendary', ylab = 'Attack')
#b
plot(pokemon$Attack, pokemon$Defense, 
     pch = 19, col = c('lightblue', 'gold')[pokemon$Legendary])

##zad50
read.table('./data/scores.txt', header = FALSE, sep = "", 
           stringsAsFactors = FALSE, fill = TRUE, strip.white = TRUE, 
           colClasses = c )


?read.table

read.fwf('./data/scores.txt', widths = c(3,2,1,1,1,1,1,1,1,1,1),
         header = FALSE, sep = "",stringsAsFactors = FALSE, strip.white = TRUE )
