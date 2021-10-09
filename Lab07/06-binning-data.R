estudiantes <- read.csv("Data/data-conversion.csv")
View(estudiantes)

niveles <- c(-Inf, 10000, 31000, Inf)
nom.nivel <- c("Bajo", "Medio", "Alto")

estudiantes$Income.cat <- cut(estudiantes$Income, breaks = niveles, labels = nom.nivel)
str(estudiantes)

estudiantes$Income.cat2 <- cut(estudiantes$Income, breaks = 4, labels = c("Nivel 1", "Nivel 2", "Nivel 3", "Nivel 4"))


#Variables Ficticias
estudiantes <- read.csv("Data/data-conversion.csv")

install.packages("dummies")
library(dummies)

estudiantes.dummy <- dummy.data.frame(estudiantes, sep = ".")
names(estudiantes.dummy)

estudiantes.dummy <- dummy.data.frame(estudiantes, names = c("State"), sep = ".")
estudiantes.dummy <- dummy.data.frame(estudiantes, names = c("State", "Gender"), sep = ".")
