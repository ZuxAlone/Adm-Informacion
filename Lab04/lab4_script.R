#Instalación de paquetes
install.packages("rvest")
install.packages("xml2")
install.packages("XML")

#Acceso a las librerías
library(rvest)
library(xml2)
library(XML)


#Caso 1: Acceso a la página de Ciencias de la Computación de la UPC
#URL
upc_url <- 'https://pregrado.upc.edu.pe/facultad-de-ingenieria/ciencias-de-la-computacion/'
#Lectura de las líneas de la página
upc_read <- readLines(upc_url, encoding = "UTF-8", warn = FALSE)
#Análisis del contenido de la página
parsed_upc <- htmlParse(upc_read, encoding = "UTF-8")
#Identificación de los 'párrafos' de la página
upc_enter_text <- parsed_upc["//p"]
#Revisamos cuántos párafos existen en la página
length(upc_enter_text)
#Revisamos el contenido de algún párrafo
upc_enter_text[[10]]
#Averiguamos cuántos enlaces tiene la página
length(getHTMLLinks(upc_read))
#Averiguamos cuántas tablas tiene la página
length(readHTMLTable(upc_read))



#Caso 2: Acceso a Wikipedia para obtener algua tabla
wiki_url <- 'https://es.wikipedia.org/wiki/Ayuda:Tablas'
wiki_read <- readLines(wiki_url, encoding = "UTF-8", warn = FALSE)
parsed_wiki <- htmlParse(wiki_read, encoding = "UTF-8")
wiki_intro_text <- parsed_wiki["//p"]
#Revisión de la cantidad de párrafos, links y tablas
length(wiki_intro_text)
length(getHTMLLinks(wiki_read))
length(readHTMLTable(wiki_read))

#Revisión de tablas
names(readHTMLTable(wiki_read)) #Muchas tablas NULL
readHTMLTable(wiki_read)$"Una tabla ejemplo\n"



#Caso 3: Acceso a la página de IMDb
library(xml2)
library(rvest)
#Lectura del HTML
pelis <- read_html("https://www.imdb.com/search/title/?count=100&release_date=2020,2020&title_type=feature")

#Obtenemos el ranking de las películas
rank_data_html <- html_nodes(pelis, '.text-primary')    #Ubicamos el selector CSS que queremos recuperar
rank_data <- html_text(rank_data_html)                  #Convertimos a texto los datos
head(rank_data)
rank_data <- as.numeric(rank_data)                      #Pre-procesamos los datos convirtiéndolos a numéricos
head(rank_data)

#Obtenemos los títulos de las películas
tit_data_html <- html_nodes(pelis, '.lister-item-header a')
tit_data <- html_text(tit_data_html)
head(tit_data)

#Obtenemos la descripción de las películas
desc_data_html <- html_nodes(pelis, '.ratings-bar + .text-muted')
desc_data <- html_text(desc_data_html)
head(desc_data)
desc_data <- gsub("\n", "", desc_data)                  #Pre-procesamos y eliminamos el "\n" de cada párrafo
head(desc_data)

#Obtenemos la duración de las películas
runtime_data_html <- html_nodes(pelis, '.text-muted .runtime')
runtime_data <- html_text(runtime_data_html)
head(runtime_data)
runtime_data <- gsub(" min", "", runtime_data)          #Eliminamos " min" en cada elemento
runtime_data <- as.numeric(runtime_data)                #Convertimos a valores numéricos
head(runtime_data)

#Obtenemos el género de las películas
genre_data_html <- html_nodes(pelis, '.genre')
genre_data <- html_text(genre_data_html)
head(genre_data)
genre_data <- gsub("\n", "", genre_data)                #Eliminamos "\n" de cada elemento
head(genre_data)
genre_data <- gsub(" ", "", genre_data)                 #Eliminamos los espacios sobrantes
head(genre_data)
genre_data <- gsub(",.*", "", genre_data)               #Tomamos solo el primer género de cada película
head(genre_data)
genre_data <- as.factor(genre_data)                     #Convertimos cada texto de género a factor
head(genre_data)

#Obtenemos la clasificación de las películas
rating_data_html <- html_nodes(pelis, '.ratings-imdb-rating strong')
rating_data <- html_text(rating_data_html)
head(rating_data)
rating_data <- as.numeric(rating_data)                  #Convertimos los valores a numéricos
head(rating_data)

#Obtenemos el metascore de las películas
metascore_data_html <- html_nodes(pelis, '.metascore')
metascore_data <- html_text(metascore_data_html)
head(metascore_data)
metascore_data <- gsub(" ", "", metascore_data)         #Eliminamos los espacios en blanco
head(metascore_data)
length(metascore_data)
metascore_data <- as.numeric(metascore_data)            #Convertimos los valores a numéricos
head(metascore_data)

#Obtenemos los votos obtenidos por película
votos_data_html <- html_nodes(pelis, '.sort-num_votes-visible span:nth-child(2)')
votos_data <- html_text(votos_data_html)
head(votos_data)
votos_data <- gsub(",", "", votos_data)                 #Eliminamos las ","
head(votos_data)
votos_data <- as.numeric(votos_data)                    #Convertimos los valores a numéricos

#Obtenemos el Gross_Earning_in_Mil de las películas
gross_data_html <- html_nodes(pelis, '.ghost~ .text-muted + span')
gross_data <- html_text(gross_data_html)
head(gross_data)
gross_data <- gsub("M", "", gross_data)                 #Eliminamos la M
gross_data <- substring(gross_data, 2, 6)               #Eliminamos el símbolo "$"
head(gross_data)
length(gross_data)
gross_data <- as.numeric(gross_data)                    #Convertimos los valores a numéricos
head(gross_data)

#Obtenemos el director de las películas
director_data_html <- html_nodes(pelis, '.text-muted + p a:nth-child(1)')
director_data <- html_text(director_data_html)
head(director_data)
director_data <- as.factor(director_data)               #Convertimos cada director a factor
head(director_data)

#Obtenemos el actor de cada película
actor_data_html <- html_nodes(pelis, '.lister-item-content .ghost + a')
actor_data <- html_text(actor_data_html)
head(actor_data)
actor_data <- as.factor(actor_data)                     #Convertimos cada actor a factor
head(actor_data)

#Para corregir los errores al crear el DataFrame
actor_data[100] <- as.factor("Vanessa Kirby")
runtime_data[100] <- 120

#Almacenamiento del dataset obtenido: guardar datos en DataFrame
pelis_df <- data.frame(Rank = rank_data, Titulo = tit_data, Runtime = runtime_data, Genero = genre_data, 
                       Director = director_data, Actor = actor_data)
str(pelis_df)

#Guardamos el conjunto de datos en un archivo .csv
write.csv(pelis_df, "pelis_df.csv", row.names = TRUE)

#Visualización de datos
library('ggplot2')

#Duración vs Género
qplot(data = pelis_df, Runtime, fill = Genero, bins = 30, main = "Película: Duración vs Género")

#Distribución de películas según género
tot_pelis <- table(pelis_df$Genero)
tot_pelis
barplot(tot_pelis, main = "Distribución de películas según género", xlab = "Género", ylab = "Total Películas")
