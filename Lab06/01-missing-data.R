data <- read.csv("Data/missing-data.csv", na.strings = "")

#Data limpia
data.limpia <- na.omit(data)
View(data.limpia)

#Consulta de valores NA
is.na(data[4, 2])
is.na(data[4, 1])
is.na(data$Income)


#Limpieza de valores NA de una variable
data.income.limpio <- data[!is.na(data$Income),]

#Limpieza de valores NA de todo el dataframe
complete.cases(data)
data.limpia2 <- data[complete.cases(data),]

#Limpieza de valores 0 de una variable
data$Income[data$Income == 0]
data$Income[data$Income == 0] <- NA
data$Income[data$Income == 0]

#Aplicar operaciones matemáticas donde existen valores NA
mean(data$Income)
mean(data$Income, na.rm = TRUE)
sd(data$Income)
sd(data$Income, na.rm = TRUE)
sum(data$Income)
sum(data$Income, na.rm = TRUE)

#Reemplazar datos NA con media de la población
data$Income[data$Income == 0] <- NA
data$Income.mean <- ifelse(is.na(data$Income), mean(data$Income, na.rm = TRUE), data$Income)
