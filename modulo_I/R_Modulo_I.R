
## @knitr setup
# smaller font size for chunks
opts_chunk$set(size = "small",
               prompt = TRUE,
               comment = NA,
               tidy = FALSE,
               cache = TRUE)
thm <- knit_theme$get("beamer2")
knit_theme$set(thm)
options(width = 65, digits = 5, continue = "  ")


## @knitr unnamed-chunk-1
getwd()


## @knitr unnamed-chunk-2
2 + 2


## @knitr unnamed-chunk-3
2 *
2


## @knitr unnamed-chunk-4
2+         2


## @knitr unnamed-chunk-5
2 + 2     # esta linha será executada
# 2 + 2     esta linha não será executada


## @knitr unnamed-chunk-6
5 * 2 - 10 + 7
5 * 2 - (10 + 7)
5 * (2 - 10 + 7)
5 * (2 - (10 + 7))


## @knitr unnamed-chunk-7
nome(argumento1, argumento2, ...)


## @knitr unnamed-chunk-8
runif(n, min = 0, max = 1)


## @knitr unnamed-chunk-9
runif(10, 1, 100)


## @knitr unnamed-chunk-10
runif(10)


## @knitr unnamed-chunk-11
runif(min = 1, max = 100, n = 10)


## @knitr unnamed-chunk-12
runif(10, max = 100, min = 1)


## @knitr unnamed-chunk-13
sample(x, size, replace = FALSE, prob = NULL)


## @knitr unnamed-chunk-14
plot(x, y, ...)


## @knitr unnamed-chunk-15
?runif


## @knitr unnamed-chunk-16
help(runif)


## @knitr unnamed-chunk-17
help.search("palavra")


## @knitr unnamed-chunk-18
help.start()


## @knitr unnamed-chunk-19
RSiteSearch("palavra")


## @knitr unnamed-chunk-20
x <- 2


## @knitr unnamed-chunk-21
x


## @knitr unnamed-chunk-22
x <- 2


## @knitr unnamed-chunk-23
x <- 2
y <- 4


## @knitr unnamed-chunk-24
x <- 2; y <- 4


## @knitr unnamed-chunk-25
x + x


## @knitr unnamed-chunk-26
y <- runif(10)
y


## @knitr unnamed-chunk-27
ls()


## @knitr unnamed-chunk-28
rm(x)


## @knitr unnamed-chunk-29
rm(x, y)


## @knitr unnamed-chunk-30
rm(list = ls())


## @knitr unnamed-chunk-31
numerico <- c(10, 5, 2, 4, 8, 9)
numerico


## @knitr unnamed-chunk-32
seq(1, 10)


## @knitr unnamed-chunk-33
seq(from = 1, to = 10, by = 2)


## @knitr unnamed-chunk-34
seq(from = 1, to = 10, length.out = 15)


## @knitr unnamed-chunk-35
rep(1, 10)


## @knitr unnamed-chunk-36
rep(c(1, 2, 3), 5)


## @knitr unnamed-chunk-37
rep(c(1, 2, 3), each = 5)


## @knitr unnamed-chunk-38
numerico * 2


## @knitr unnamed-chunk-39
numerico * numerico
numerico + c(2, 4, 1)


## @knitr unnamed-chunk-40
numerico + c(2, 4, 1, 3)


## @knitr unnamed-chunk-41
class(numerico)


## @knitr unnamed-chunk-42
length(numerico)


## @knitr unnamed-chunk-43
caracter <- c("brava", "joaquina", "armação")
caracter


## @knitr unnamed-chunk-44
logico <- caracter == "armação"
logico


## @knitr unnamed-chunk-45
logico <- numerico > 4
logico


## @knitr unnamed-chunk-46
fator <- factor(c("alta","baixa","baixa","media",
                  "alta","media","baixa","media","media"))
fator
class(fator)


## @knitr unnamed-chunk-47
fator <- factor(c("alta","baixa","baixa","media",
                  "alta","media","baixa","media","media"),
                levels=c("alta","media","baixa"))
fator


## @knitr unnamed-chunk-48
num.fac <- as.factor(numerico)
num.fac


## @knitr unnamed-chunk-49
num.num <- as.numeric(as.character(num.fac))
num.num


## @knitr unnamed-chunk-50
carac.fac <- as.factor(caracter)
carac.fac


## @knitr unnamed-chunk-51
matriz <- matrix(1:12, nrow=3, ncol=4)
matriz
class(matriz)


## @knitr unnamed-chunk-52
matriz <- matrix(1:12, nrow=3, ncol=4, byrow=T)
matriz


## @knitr unnamed-chunk-53
dim(matriz)


## @knitr unnamed-chunk-54
cbind(matriz, rep(99, 3))


## @knitr unnamed-chunk-55
rbind(matriz, rep(99, 4))


## @knitr unnamed-chunk-56
matriz * 2


## @knitr unnamed-chunk-57
matriz2 <- matrix(1, nrow=4, ncol=3)
matriz %*% matriz2


## @knitr unnamed-chunk-58
rownames(matriz) <- c("A","B","C")
colnames(matriz) <- c("T1","T2","T3","T4")
matriz


## @knitr unnamed-chunk-59
lista <- list(a = 1:10, b = c("T1","T2","T3","T4"))
lista
class(lista)


## @knitr unnamed-chunk-60
lista <- list(fator = fator, matriz = matriz)
lista
length(lista)


## @knitr unnamed-chunk-61
dataFrame <- data.frame(ano = 2000:2004,
                        captura = c(32, 54, 25, 48, 29))
dataFrame
class(dataFrame)


## @knitr unnamed-chunk-62
dataFrame <- data.frame(numerico = c(numerico, NA, NA, NA),
                        fator = fator)
dataFrame


## @knitr unnamed-chunk-63
perd <- c(3, 5, NA, 2)
perd
class(perd)


## @knitr unnamed-chunk-64
is.na(perd)


## @knitr unnamed-chunk-65
any(is.na(perd))


## @knitr unnamed-chunk-66
perd <- c(-1,0,1)/0
perd
is.na(perd)


## @knitr unnamed-chunk-67
is.infinite(perd)


## @knitr unnamed-chunk-68
cont <- c(8, 4, NA, 9, 6, 1, 7, 9)
cont


## @knitr unnamed-chunk-69
cont[4]


## @knitr unnamed-chunk-70
cont[c(1, 4, 8)]


## @knitr unnamed-chunk-71
ind <- c(1, 4, 8)
cont[ind]


## @knitr unnamed-chunk-72
cont[-c(1, 4, 8)]


## @knitr unnamed-chunk-73
cont[1:5]


## @knitr unnamed-chunk-74
cont[!is.na(cont)]


## @knitr unnamed-chunk-75
cont[is.na(cont)] <- 0
cont


## @knitr unnamed-chunk-76
mat <- matrix(1:9, nrow=3)
mat


## @knitr unnamed-chunk-77
mat[2,3]


## @knitr unnamed-chunk-78
mat[,1]


## @knitr unnamed-chunk-79
mat[1,]


## @knitr unnamed-chunk-80
mat[c(1,3), c(2,3)]


## @knitr unnamed-chunk-81
lis <- list(vetor1 = c(3, 8, 7, 4), vetor2 = 5:0)
lis


## @knitr unnamed-chunk-82
lis[[2]]


## @knitr unnamed-chunk-83
lis[[1]][3]


## @knitr unnamed-chunk-84
lis$vetor2


## @knitr unnamed-chunk-85
dframe <- data.frame(col1 = 4:1, col2 = c(2,NA,5,8))
dframe


## @knitr unnamed-chunk-86
dframe[2,1]


## @knitr unnamed-chunk-87
dframe[,2]


## @knitr unnamed-chunk-88
dframe[,"col2"]


## @knitr unnamed-chunk-89
dframe[1,]


## @knitr unnamed-chunk-90
dframe["1",]


## @knitr unnamed-chunk-91
dframe$col1


## @knitr unnamed-chunk-92
dframe$col2[3]


## @knitr unnamed-chunk-93
dframe$col2[c(2,4)]


## @knitr unnamed-chunk-94
with(dframe, col1)


## @knitr unnamed-chunk-95
dframe$col1


## @knitr unnamed-chunk-96
dados <- c(5, 15, 42, 28, 79, 4, 7, 14)


## @knitr unnamed-chunk-97
dados[dados > 15]


## @knitr unnamed-chunk-98
dados[dados > 15 & dados <= 35]


## @knitr unnamed-chunk-99
dados > 15 & dados <= 35


## @knitr unnamed-chunk-100
dados <- data.frame(ano=c(2001,2002,2003,2004,2005),
                    captura=c(26,18,28,26,NA),
                    porto=c("SP","RS","SC","SC","RN"))


## @knitr unnamed-chunk-101
dados[dados$ano == 2004,]


## @knitr unnamed-chunk-102
dados[dados$porto == "SC",]


## @knitr unnamed-chunk-103
dados[dados$captura > 20, "captura"]


## @knitr unnamed-chunk-104
dados[dados$captura > 20 & !is.na(dados$captura),]


## @knitr unnamed-chunk-105
dados[dados$captura > 25 & dados$porto == "SP",]


## @knitr unnamed-chunk-106
subset(dados, captura > 25 & porto == "SP")


## @knitr unnamed-chunk-107
save.image()


