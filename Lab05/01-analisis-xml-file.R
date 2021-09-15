install.packages("XML")
library(XML)

cd.file <- "Data/cd_catalog.xml"
cd.doc <- xmlParse(cd.file)
cd.root <- xmlRoot(cd.doc)

cd.root[1]

cd.data <- xmlSApply(cd.root, function(x) xmlSApply(x, xmlValue))
cd.datos <- data.frame(t(cd.data), row.names = NULL)
