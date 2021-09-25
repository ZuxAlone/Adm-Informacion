install.packages("scales")
library(scales)

estudiantes <- read.csv("Data/data-conversion.csv")
View(estudiantes)

#Reescala entre valores 0-1
estudiantes$Income.rescaled <- rescale(estudiantes$Income)
View(estudiantes)

#Reescala entre valores 0-100
rescale(estudiantes$Income, to = c(0, 100))

#Función para reescalar una variable x dentro de un dataframe
rescalar.cols <- function(df, cols) {
  nombres <- names(df)
  for(col in cols) {
    nombre <- paste(nombres[col], "rescaled", sep = ".")
    df[nombre] <- rescale(df[,col])
  }
  cat(paste("Hemos reescalado ", length(cols), "variable(s)"))
  df
}

estudiantes <- rescalar.cols(estudiantes, c(1, 4))
