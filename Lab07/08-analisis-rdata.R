#Caso 1: Crear y cargar ficheros Rdata y rds

clientes <- c("Arturo", "Bill", "Jack")
fechas <- c("2021-05-01", "2021-04-28", "2021-03-30")
pagos <- c(315.1, 205.4, 450.2)

fechas <- as.Date(fechas)

pedidos <- data.frame(clientes, fechas, pagos)
View(pedidos)

#Creación de ficheros Rdata
save(pedidos, file = "Data/pedidos.Rdata")
clientes.frec <- c("Arturo", "Jack")
save(pedidos, clientes.frec, file = "Data/pedidos.Rdata")

save.image(file = "Data/alldata.Rdata") #Todos los objetos de la sesión actual


#Creación de ficheros rds
saveRDS(pedidos, file = "Data/pedidos.rds")
remove(pedidos)


#Cargar archivos Rdata y rds
load("Data/pedidos.Rdata")
attach("Data/pedidos.Rdata")

orders <- readRDS("Data/pedidos.rds")


#Caso 2: Crear un fichero CSV a partir de un dataframe
write.csv(pedidos, "Data/pedidos.csv", na="NA", row.names = FALSE)
write.csv(pedidos, "Data/pedidos2.csv", na="NA")
