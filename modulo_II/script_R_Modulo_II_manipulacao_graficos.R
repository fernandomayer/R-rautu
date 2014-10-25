##======================================================================
##
## Manipulação de objetos, otimização e gráficos
##
## Congresso Brasileiro de Oceanografia - CBO 2014
## Itajaí, SC, Brasil
## 25 de outubro, 2014
##
##
##======================================================================

##----------------------------------------------------------------------
## Instalação de pacotes necessários
install.packages(c("ggplot2", "plyr"), dependencies = TRUE)
##----------------------------------------------------------------------

## Importa a base de dados
dados <- read.table("../dados/Brasil_LL_1998-2004.csv", header = TRUE,
                    sep = ";", dec = ",")
str(dados)

## Identificacao de trimestres
dados$TRIM <- 1
dados$TRIM[dados$MES == 4 | dados$MES == 5 | dados$MES == 6] <- 2
dados$TRIM[dados$MES == 7 | dados$MES == 8 | dados$MES == 9] <- 3
dados$TRIM[dados$MES == 10 | dados$MES == 11 | dados$MES == 12] <- 4

## Uma forma de conferir
dados[sample(row.names(dados), 30), c("MES", "TRIM")]

## Ou, usando uma função para otimizar esse processo:
trim <- function(mes){
# Função para converter meses em trimestres.
# Argumentos:
#   mes: vetor contendo os meses. Deve ser numérico.
    if(!is.numeric(mes)){
        stop("'mes' deve ser numérico")
    }
    trim <- numeric(0)
    for(i in 1:4){
        trim[mes == i*3-2 | mes == i*3-1 | mes == i*3] <- i
    }
    return(trim)
}

## Usando a função
dados$TRIM <- trim(dados$MES)

## Uma forma de conferir
dados[sample(row.names(dados), 30), c("MES", "TRIM")]

##======================================================================
## Analise da CPUE da albacora-lage
##======================================================================

## Calculo da CPUE (kg/1000 anzois)
dados$CPUE <- (dados$LAGE*1000)/dados$EFF

##----------------------------------------------------------------------
## Analise exploratoria de dados
##----------------------------------------------------------------------

## Verifica a distribuicao dos dados
par(mfrow=c(1,2))
hist(dados$CPUE)
hist(log(dados$CPUE))
par(mfrow=c(1,1))

## Verifica a quantidade de zeros
length(dados$CPUE)
nrow(dados)
length(dados$CPUE[dados$CPUE == 0])
length(dados$CPUE[dados$CPUE == 0])/nrow(dados)

## Como a quantidade de zeros e relativamente grande, e precisamos
## aplicar o log, vamos remover os zeros da analise - SOMENTE PARA FINS
## DE ILUSTRACAO - o problema de modelagem com zeros deve ser
## considerada atraves de abordagens mais coerentes
dados <- subset(dados, CPUE != 0)
## Confere a dimensão
dim(dados)

# Como podemos analisar a relacao da CPUE de albacora-lage com as outras
# especies, vamos retirar tambem os valores zero delas
dados <- subset(dados, BRANCA != 0)
dados <- subset(dados, BANDOLIM != 0)
## Confere a dimensão
dim(dados)

## Veja que
row.names(dados)
# não está em ordem. Para fins de indexação é importante manter os nomes
# das linhas corretas
row.names(dados) <- 1:nrow(dados)

## Cálculo da CPUE das outras especies
dados$CPUE.BRANCA <- (dados$BRANCA*1000)/dados$EFF
dados$CPUE.BANDOLIM <- (dados$BANDOLIM*1000)/dados$EFF

## Verifica novamente a distribuicao dos dados
par(mfrow=c(1,2))
hist(dados$CPUE)
hist(log(dados$CPUE))
par(mfrow=c(1,1))

## Como a distribuição é assimétrica, vamos trabalhar com o log. Para
## facilitar podemos criar novas colunas com o log das CPUEs
dados$LCPUE <- log(dados$CPUE)
dados$LCPUE.BRANCA <- log(dados$CPUE.BRANCA)
dados$LCPUE.BANDOLIM <- log(dados$CPUE.BANDOLIM)

##----------------------------------------------------------------------
## Funções para estatística descritiva
mean(dados$LCPUE)
sd(dados$LCPUE)
var(dados$LCPUE)

## Coeficiente de variação
help.search("coefficient of variation")
# podemos criar uma função para calcular o CV
cv <- function(x) {
    desv.pad <- sd(x)
    med <- mean(x)
    cv <- desv.pad/med
    return(cv)
}
# podemos também salvar essa função em um arquivo cv.R e carregar com
source("cv.R")
cv(dados$LCPUE)
quantile(dados$LCPUE)

## Resumindo tudo com summary()
summary(dados$LCPUE)
summary(dados)

## Usando a familia de funções *apply()
# apply: aplica uma função por linha (1) ou coluna (2)
apply(dados[, c("LCPUE", "LCPUE.BRANCA", "LCPUE.BANDOLIM")], 2, mean)
# lapply: retorna uma lista com o resultado de uma função
lapply(dados[, c("LCPUE", "LCPUE.BRANCA", "LCPUE.BANDOLIM")], mean)
# sapply: simplifica o resultado do lapply para um vetor
sapply(dados[, c("LCPUE", "LCPUE.BRANCA", "LCPUE.BANDOLIM")], mean)
# tapply: aplica uma função a um vetor, separado para cada combinação de
# níveis dos fatores especificados em list()
with(dados, tapply(LCPUE, FROTA, summary))
with(dados, tapply(LCPUE, FROTA, mean))
with(dados, tapply(LCPUE, FROTA, var))
with(dados, tapply(LCPUE, list(FROTA, TRIM), mean))
with(dados, tapply(LCPUE, list(FROTA, TRIM, ANO), mean))

## A função aggregate() agrega valores utilizando uma função, de
## acordo com uma lista de fatores especificados
aggregate(cbind(LCPUE, LCPUE.BRANCA, LCPUE.BANDOLIM) ~ FROTA,
          data = dados, cv)
aggregate(cbind(LCPUE, LCPUE.BRANCA, LCPUE.BANDOLIM) ~ FROTA + ANO,
          data = dados, cv)
aggregate(cbind(LCPUE, LCPUE.BRANCA, LCPUE.BANDOLIM) ~ FROTA + ANO + TRIM,
          data = dados, cv)
##----------------------------------------------------------------------

##----------------------------------------------------------------------
## Tamanho amostral: quantidade de informacao por cruzamento de fatores
table(dados$FROTA)
table(dados$ANO)
table(dados$TRIM)
with(dados, table(ANO, TRIM))
with(dados, mosaicplot(table(ANO, TRIM)))
with(dados, table(ANO, TRIM, FROTA))
with(dados, mosaicplot(table(ANO, TRIM, FROTA)))
##----------------------------------------------------------------------

##----------------------------------------------------------------------
## GRAFICOS
##----------------------------------------------------------------------

## Barplot
barplot(table(dados$FROTA))
barplot(table(dados$ANO))
with(dados, barplot(table(TRIM, ANO)))
with(dados, barplot(table(TRIM, ANO), beside = TRUE))

## Boxplots
boxplot(LCPUE ~ FROTA, data = dados, xlab = "Frota", ylab = "log(CPUE)")
boxplot(LCPUE ~ ANO, data = dados, xlab = "Ano", ylab = "log(CPUE)")
boxplot(LCPUE ~ TRIM, data = dados, xlab = "Trimestre", ylab = "log(CPUE)")
boxplot(LCPUE ~ ANO + TRIM, data = dados,
        xlab = "Ano.Trimestre", ylab = "log(CPUE)")

##----------------------------------------------------------------------
## Uma forma mais eficiente: usando o pacote lattice
require(lattice)
## Boxplots
bwplot(~LCPUE | FROTA, data = dados, as.table = TRUE,
       layout = c(1,2))
bwplot(~LCPUE | factor(ANO) + factor(TRIM), data = dados,
       as.table = TRUE)
bwplot(~LCPUE | factor(TRIM) + factor(ANO), data = dados,
       as.table = TRUE)
bwplot(~LCPUE | factor(ANO) + FROTA, data = dados,
       as.table = TRUE)
bwplot(~LCPUE | factor(TRIM) + FROTA, data = dados,
       as.table = TRUE)
bwplot(~LCPUE | factor(TRIM) + factor(ANO) + FROTA,
       data = dados, as.table = TRUE)
## Histogramas
histogram(~LCPUE | FROTA, data = dados, as.table = TRUE,
          layout = c(1,2))
histogram(~LCPUE | factor(ANO) + FROTA, data = dados,
          as.table = TRUE)
histogram(~LCPUE | factor(TRIM) + FROTA, data = dados,
          as.table = TRUE)

## Relação entre variáveis (gráficos XY)
plot(dados$LCPUE, dados$LCPUE.BRANCA) # OU
plot(LCPUE.BRANCA ~ LCPUE, data = dados) # melhor

## TAREFA: faça o gráfico da relação de LCPUE com LCPUE.BRANCA e
## LCPUE.BANDOLIM, coloque os dois gráficos na mesma janela, e insira os
## títulos dos eixos e o título principal nos dois gráficos

## XY-plot usando o lattice
xyplot(LCPUE ~ LCPUE.BRANCA, data = dados)
xyplot(LCPUE ~ LCPUE.BANDOLIM, data = dados)
xyplot(LCPUE ~ LCPUE.BRANCA | factor(ANO), data = dados,
       as.table = TRUE)
xyplot(LCPUE ~ LCPUE.BRANCA | factor(TRIM) + factor(ANO),
       data = dados, as.table = TRUE)
xyplot(LCPUE ~ LCPUE.BRANCA | factor(ANO) + FROTA,
       data = dados, as.table = TRUE)

##----------------------------------------------------------------------
## Verificando a relação entre média e variância da LCPUE
## Usando o pacote plyr
require(plyr)
med.var <- ddply(dados, .(ANO, TRIM), summarize,
                 LCPUE.med = mean(LCPUE),
                 LCPUE.var = var(LCPUE))
str(med.var)
# Relação
plot(LCPUE.var ~ LCPUE.med, data = med.var)
with(med.var, range(c(LCPUE.var, LCPUE.med)))
plot(LCPUE.var ~ LCPUE.med, data = med.var,
     xlim = c(0, 6), ylim = c(0,6))
# adiciona a linha 1:1
abline(a = 0, b = 1, lty = 2, col = 2)
# Ajusta um modelo linear aos dados
mod <- lm(LCPUE.var ~ LCPUE.med, data = med.var)
summary(mod)
abline(mod)
## INSERINDO expressões matemáticas
?plotmath
demo(plotmath)
coef(mod)
beta0 <- round(coef(mod)[1], 3)
beta1 <- round(coef(mod)[2], 3)
text(x = 1, y = 5,
     labels = expression(y == beta[0] + beta[1] * x))
text(x = 1, y = 4.5,
     labels = expression(hat(beta)[0] == 2.029))
text(x = 1, y = 4,
     labels = expression(hat(beta)[1] == -0.072))
## Usando o bquote os valores dos coeficientes são mostrados
## automaticamente
text(x = 1, y = 3,
     labels = bquote(hat(y) == .(beta0) + .(beta1) * x))
##----------------------------------------------------------------------


##======================================================================
## Gráficos com ggplot2
##======================================================================
require(ggplot2)

##----------------------------------------------------------------------
## Boxplots
# CPUE ~ FROTA
(p <- ggplot(dados, aes(x = FROTA, y = LCPUE)) +
     geom_boxplot() + labs(x = "Frota", y = "CPUE"))

# CPUE ~ FROTA + ANO
(p <- ggplot(dados, aes(x = FROTA, y = LCPUE)) +
      geom_boxplot() + labs(x = "Frota", y = "CPUE") +
      facet_wrap( ~ ANO, scales = "free"))

# CPUE ~ FROTA + TRIMESTRE
(p <- ggplot(dados, aes(x = FROTA, y = LCPUE)) +
      geom_boxplot() + labs(x = "Frota", y = "CPUE") +
      facet_wrap( ~ TRIM, scales = "free"))

# CPUE ~ FROTA + ANO + TRIMESTRE
(p <- ggplot(dados, aes(x = FROTA, y = LCPUE)) +
      geom_boxplot() + labs(x = "Frota", y = "CPUE") +
      facet_grid(ANO ~ TRIM, scales = "free"))
##----------------------------------------------------------------------

##----------------------------------------------------------------------
## Histogramas
# CPUE
(p <- ggplot(dados, aes(x = LCPUE)) +
      geom_histogram(binwidth = 1, colour = "black", fill = "black",
                     alpha = 0.2) + labs(x = "log(CPUE)", y =
                         "Frequência"))

# CPUE + FROTA ~ ANO
(p <- ggplot(dados, aes(x = LCPUE, fill = FROTA)) +
      geom_histogram(binwidth = .5, alpha = 0.2, position = "dodge") +
      labs(x = "log(CPUE)", y = "Frequência") +
      facet_wrap( ~ ANO, scales = "free") +
      scale_fill_manual(values = c("green", "blue")))

# CPUE + FROTA ~ ANO + TRIMESTRE
(p <- ggplot(dados, aes(x = LCPUE, fill = FROTA)) +
      geom_histogram(binwidth = .5, alpha = 0.2, position = "identity") +
      labs(x = "log(CPUE)", y = "Frequência") +
      facet_grid(ANO ~ TRIM, scales = "free") +
      scale_fill_manual(values = c("green", "blue")))
##----------------------------------------------------------------------

##----------------------------------------------------------------------
## Scatterplots
# CPUE.LAGE ~ CPUE.BRANCA
(p <- ggplot(dados, aes(x = log(CPUE.BRANCA), y = LCPUE)) +
      geom_point())

# CPUE.LAGE ~ CPUE.BRANCA | ANO
(p <- ggplot(dados, aes(x = log(CPUE.BRANCA), y = LCPUE)) +
      geom_point() + facet_wrap( ~ ANO, scales = "free"))

# CPUE.LAGE ~ CPUE.BRANCA | ANO + TRIMESTRE
(p <- ggplot(dados, aes(x = log(CPUE.BRANCA), y = LCPUE)) +
      geom_point() + facet_grid(ANO ~ TRIM, scales = "free"))

# CPUE.LAGE ~ CPUE.BRANCA | ANO ~ FROTA
(p <- ggplot(dados, aes(x = log(CPUE.BRANCA), y = LCPUE,
                        colour = FROTA)) +
      geom_point() + facet_wrap( ~ ANO, scales = "free"))

# CPUE.LAGE ~ CPUE.BRANCA | ANO + TRIMESTRE ~ FROTA
(p <- ggplot(dados, aes(x = log(CPUE.BRANCA), y = LCPUE,
                        colour = FROTA)) +
      geom_point() + facet_grid(ANO ~ TRIM, scales = "free"))
##----------------------------------------------------------------------


