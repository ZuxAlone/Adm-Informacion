install.packages("jsonlite")
library(jsonlite)

ine.url <- "https://servicios.ine.es/wstempus/js/ES/DATOS_TABLA/2852?nult=5&tip=AM"
pob.esp <- fromJSON(ine.url)

dai.url <- "https://www.floatrates.com/daily/usd.json"
dai.dat <- fromJSON(dai.url)
