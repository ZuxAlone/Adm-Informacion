install.packages("jsonlite")
library(jsonlite)

students.file <- "Data/students.json"
students.json <- fromJSON(students.file)

stu.cour.file <- "Data/student-courses.json"
stu.cour.json <- fromJSON(stu.cour.file)
