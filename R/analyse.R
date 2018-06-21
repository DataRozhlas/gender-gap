library(readxl)
library(dplyr)
library(stringr)
library(tidyr)

d <- read_excel("../data/osoby-clean-funkce.xlsx")

d$male <- !str_detect(d$lastName, "(á|Á|Vároši|Boschat|Adam|JIRKŮ|Gruber)$")

d[d$lastName=="Tabery" & d$firstName=="Petra",20] <- FALSE

muzi <- d[d$male,]

zeny <- d[!d$male,]

ministerstva <- d %>% count(organizace2, male)
ministerstva <- spread(ministerstva, male, n)
names(ministerstva) <- c("organizace", "ženy", "muži")
ministerstva$celkem <- ministerstva$ženy + ministerstva$muži
ministerstva$ženy_pct <- ministerstva$ženy/ministerstva$celkem*100

pozice <- d %>% count(pozice2, male)
pozice <- spread(pozice, male, n)
names(pozice) <- c("pozice", "ženy", "muži")
pozice$celkem <- pozice$ženy + pozice$muži
pozice$ženy_pct <- pozice$ženy/pozice$celkem*100

write.csv(pozice, "pozice.csv")
