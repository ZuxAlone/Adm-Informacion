ozone.data <- read.csv("Data/ozone.csv", stringsAsFactors = FALSE)
View(ozone.data)

outliers.values <- boxplot(ozone.data$pressure_height)$out
outliers.values

summary(ozone.data$pressure_height)

boxplot(ozone.data$pressure_height, main = "Pressure Height", boxwex =  0.5)

boxplot(pressure_height ~ Month, data = ozone.data, main = "Pressure Height per Month")

boxplot(ozone_reading ~ Month, data = ozone.data, main = "Ozone reading per Month")

boxplot(ozone_reading ~ Month, data = ozone.data, main = "Ozone reading per Month")$out

#Caso 1: Cambio de outliers por el promerio y/o la mediana
fix_outliers <- function(x, removeNA = TRUE) {
  #Calculamos los quantiles por arriba del 5% y por debajo del 95%
  quantiles <- quantile(x, c(0.05, 0.95), na.rm = removeNA)
  x[x<quantiles[1]] <- mean(x, na.rm = removeNA)
  x[x>quantiles[2]] <- median(x, na.rm = removeNA)
  x
}

sin.outliers <- fix_outliers(ozone.data$pressure_height)

par(mfrow = c(1,2))
boxplot(ozone.data$pressure_height, main = "Presión sin Outliers")
boxplot(sin.outliers, main = "Presión sin Outliers")


#Caso 2: Cambio de outliers enmascarando sus valores (capping)
replace_outliers <- function(x, removeNA = TRUE){
  qrts <- quantile(x, probs = c(0.25, 0.75), na.rm = removeNA)
  # si el outlier esta por debajo del cuartil 0.5 o por arriba de 0.95
  caps <- quantile(x, probs = c(.05, .95), na.rm = removeNA)
  # Calculamos el rango intercuartilico
  iqr <- qrts[2]-qrts[1]
  # Calculamos el 1.5 veces el rango intercuartiligo (iqr)
  altura <- 1.5*iqr
  #reemplazamos del vector los outliers por debajo de 0.05 y 0.095
  x[x<qrts[1]-altura] <- caps[1]
  x[x>qrts[2]+altura] <- caps[2]
  x
}

par(mfrow = c(1,2))
boxplot(ozone.data$pressure_height, main = "Presión con Outliers")
boxplot(replace_outliers(ozone.data$pressure_height), main = "Presión sin Outliers")
