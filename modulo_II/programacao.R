##======================================================================
##
## Software Carpentry
## FURG - Brasil
## 12 e 13 de maio, 2014
##
##
##======================================================================

## ------------------------------------------------------------------------

## Importa os dados
notas <- read.table("../dados/notas.csv", header = TRUE,
                    sep=";", dec=",")
## Analisa a estrutura dos dados
str(notas)
head(notas)
summary(notas)


## ----eval=FALSE----------------------------------------------------------
## for(i in 1:30){
##     print(notas[i, c("prova1", "prova2", "prova3")])
## }


## ------------------------------------------------------------------------
## Para calcular as médias das 3 provas, precisamos inicialmente de um
## vetor para armazenar os resultados. Esse vetor pode ser um novo
## objeto ou uma nova coluna no dataframe

## Aqui vamos criar uma nova coluna no dataframe, contendo apenas o
## valor 0
notas$media <- 0 # note que aqui será usada a regra da reciclagem, ou
                 # seja, o valor zero será repetido até completar todas
                 # as linhas do dataframe
# Estrutura de repetição para calcular a média
for(i in 1:30){
    ## Aqui, cada linha i da coluna media sera substituida pelo
    ## respectivo valor da media caculada
    notas$media[i] <- sum(notas[i, c("prova1", "prova2", "prova3")])/3
}

## Confere os resultados
head(notas)


## ------------------------------------------------------------------------
## Armazenamos o número de linhas no dataframe
nlinhas <- nrow(notas)
## Identificamos as colunas de interesse no cálculo da média, e
## armazenamos em um objeto separado
provas <- c("prova1", "prova2", "prova3")
## Sabendo o número de provas, fica mais fácil dividir pelo total no
## cálculo da média
nprovas <- length(provas)
## Cria uma nova coluna apenas para comparar o cálculo com o anterior
notas$media2 <- 0
## A estrutura de repetição fica
for(i in 1:nlinhas){
    notas$media2[i] <- sum(notas[i, provas])/nprovas
}

## Confere
head(notas)


## ------------------------------------------------------------------------
## Cria uma nova coluna apenas para comparação
notas$media3 <- 0
## A estrutura de repetição fica
for(i in 1:nlinhas){
    notas$media3[i] <- mean(as.numeric(notas[i, provas]))
}

## Confere
head(notas)

## A única diferença é que aqui precisamos transformar cada linha em um
## vetor de números com as.numeric(), pois
notas[1, provas]
## é um data.frame:
class(notas[1, provas])


## ----eval=FALSE----------------------------------------------------------
## help.search("coefficient of variation")


## ------------------------------------------------------------------------
cv <- function(x){
    desv.pad <- sd(x)
    med <- mean(x)
    cv <- desv.pad/med
    return(cv)
}


## ------------------------------------------------------------------------
sd(as.numeric(notas[1, provas]))/mean(as.numeric(notas[1, provas]))


## ------------------------------------------------------------------------
cv(as.numeric(notas[1, provas]))


## ------------------------------------------------------------------------
## Cria uma nova coluna para o CV
notas$CV <- 0
## A estrutura de repetição fica
for(i in 1:nlinhas){
    notas$CV[i] <- cv(as.numeric(notas[i, provas]))
}

## Confere
head(notas)


## ------------------------------------------------------------------------
med.pond <- function(notas, pesos){
    ## Multiplica o valor de cada prova pelo seu peso
    pond <- notas * pesos
    ## Calcula o valor total dos pesos
    peso.total <- sum(pesos)
    ## Calcula a soma da ponderação
    sum.pond <- sum(pond)
    ## Finalmente calcula a média ponderada
    saida <- sum.pond/peso.total
    return(saida)
}


## ------------------------------------------------------------------------
sum(notas[1, provas] * c(3,3,4))/10


## ------------------------------------------------------------------------
med.pond(notas = notas[1, provas], pesos = c(3,3,4))


## ------------------------------------------------------------------------
## Cria uma nova coluna para a média ponderada
notas$MP <- 0
## A estrutura de repetição fica
for(i in 1:nlinhas){
    notas$MP[i] <- med.pond(notas = notas[i, provas], pesos = c(3,3,4))
}

## Confere
head(notas)


## ------------------------------------------------------------------------
## Atribuindo pesos iguais para as provas como padrão
med.pond <- function(notas, pesos = rep(1, length(notas))){
    ## Multiplica o valor de cada prova pelo seu peso
    pond <- notas * pesos
    ## Calcula o valor total dos pesos
    peso.total <- sum(pesos)
    ## Calcula a soma da ponderação
    sum.pond <- sum(pond)
    ## Finalmente calcula a média ponderada
    saida <- sum.pond/peso.total
    return(saida)
}


## ------------------------------------------------------------------------
## Cria uma nova coluna para a média ponderada para comparação
notas$MP2 <- 0
## A estrutura de repetição fica
for(i in 1:nlinhas){
    notas$MP2[i] <- med.pond(notas = notas[i, provas])
}

## Confere
head(notas)


## ------------------------------------------------------------------------
## Nova coluna para armazenar a situacao
notas$situacao <- NA # aqui usamos NA porque o resultado será um
                     # caracter
## Estrutura de repetição
for(i in 1:nlinhas){
    ## Estrutura de seleção (usando a média ponderada)
    if(notas$MP[i] >= 7){
        notas$situacao[i] <- "aprovado"
    } else{
        notas$situacao[i] <- "reprovado"
    }
}

## Confere
head(notas)


## ------------------------------------------------------------------------
notas$media.apply <- apply(X = notas[, provas], MARGIN = 1, FUN = mean)
head(notas)


## ------------------------------------------------------------------------
notas$MP.apply <- apply(X = notas[, provas], MARGIN = 1, FUN = med.pond)
head(notas)


## ------------------------------------------------------------------------
notas$MP.apply <- apply(X = notas[, provas], MARGIN = 1,
                        FUN = med.pond, pesos = c(3,3,4))
head(notas)


## ------------------------------------------------------------------------
notas$MP2.apply <- apply(X = notas[, provas], MARGIN = 1,
                         FUN = weighted.mean, w = c(3,3,4))
head(notas)


## ------------------------------------------------------------------------
notas$CV.apply <- apply(X = notas[, provas], MARGIN = 1, FUN = cv)
head(notas)


