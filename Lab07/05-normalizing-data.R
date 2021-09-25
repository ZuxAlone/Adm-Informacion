casas <- read.csv("Data/BostonHousing.csv")
View(casas)

#Normalización ajutando al promedio y desviación atípica
casas.z <- scale(casas)
View(casas.z)

#Normalización ajustando al promedio (center = TRUE, scale = FALSE)
casas.mean <- scale(casas, center = TRUE, scale = FALSE)
View(casas.mean)

#Normalización ajustando a la desviación típica o estándar (center = FALSE, scale = TRUE)
casas.sd <- scale(casas, center = FALSE, scale = TRUE)
View(casas.sd)

#Normalización de más de una variable conversando las variables originales
#Función normalizar.cols
normalizar.cols <- function(df, cols) {
  nombres <- names(df)
  for(col in cols) {
    nombre <- paste(nombres[col], "z", sep = ".")
    df[nombre] <- scale(df[, col])
  }
  cat(paste("Hemos normalizado ", length(cols), " variable(s)"))
  df
}

casas <- normalizar.cols(casas, c(1, 3, 5:8))
View(casas)
