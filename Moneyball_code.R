batting <- read.csv("C:/Users/Manasi Haldankar/Downloads/R-Course-HTML-Notes/R-Course-HTML-Notes/R-for-Data-Science-and-Machine-Learning/Training Exercises/Capstone and Data Viz Projects/Capstone Project/Batting.csv")
head(batting)
str(batting)
head(batting$AB)
head(batting$X2B)

batting$BA <- batting$H / batting$AB
batting$OBP <- (batting$H + batting$BB + batting$HBP)/ (batting$AB + batting$BB + batting$HBP + batting$SF)
batting$X1B <- batting$H - batting$X2B - batting$X3B - batting$HR
batting$SP <- (batting$X1B + (2*batting$X2B) + (3*batting$X3B) + (4*batting$HR))/ batting$AB
tail(batting$BA,5)

sal <- read.csv("C:/Users/Manasi Haldankar/Downloads/R-Course-HTML-Notes/R-Course-HTML-Notes/R-for-Data-Science-and-Machine-Learning/Training Exercises/Capstone and Data Viz Projects/Capstone Project/Salaries.csv")
summary(batting)
batting <- subset(batting, yearID >= 1985)
#batting1 <- subset(batting, yearID == 2001)
#head(batting1)

combo <- merge(batting, sal, by = c("playerID","yearID"))
summary(combo)
head(combo)

lost_players <- subset(combo, playerID %in% c('damonjo01', 'giambja01', 'saenzol01'))
head(lost_players)
lost_players <- subset(lost_players, yearID == 2001)
lost_players <- select(lost_players, 'playerID', 'H', 'X2B', 'X3B', 'HR', 'OBP', 'SP', 'BA', 'AB')

combo <- subset(combo, yearID == 2001)
str(combo)

library(dplyr)
library(ggplot2)

pl <- ggplot(combo,aes(x=OBP, y=salary)) + geom_point(size=2)
combo <- subset(combo, salary < 8000000 & OBP > 0)
print(pl)

combo <- subset(combo,AB >= 450)

options <- head(arrange(combo, desc(OBP)),10)
options[,c('playerID','AB','salary','OBP')]