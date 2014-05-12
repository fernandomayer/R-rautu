##======================================================================
##
## Software Carpentry
## FURG - Brasil
## 12 e 13 de maio, 2014
##
##
##======================================================================

## ------------------------------------------------------------------------
dados <- read.table("../dados/crabs.csv", header = T,
                    sep = ";", dec = ",")


## ------------------------------------------------------------------------
str(dados)


## ------------------------------------------------------------------------
head(dados, 10) # ou: dados[1:10,]


## ------------------------------------------------------------------------
mean(dados$CL) # ou sum(dados$CL)/length(dados$CL)


## ------------------------------------------------------------------------
mean(dados$BD)


## ------------------------------------------------------------------------
mean(dados$BD, na.rm=T)


## ------------------------------------------------------------------------
sd(dados$CL)


## ------------------------------------------------------------------------
var(dados$CL) # sd(dados$CL)^2


## ------------------------------------------------------------------------
sd(dados$CL)/mean(dados$CL)


## ------------------------------------------------------------------------
quantile(dados$CL)


## ------------------------------------------------------------------------
quantile(dados$CL, probs = seq(0, 1, 0.1))


## ------------------------------------------------------------------------
summary(dados$CL)


## ------------------------------------------------------------------------
summary(dados$BD)


## ------------------------------------------------------------------------
summary(dados)


## ------------------------------------------------------------------------
table(dados$especie)


## ------------------------------------------------------------------------
table(dados$especie, dados$sexo)


## ------------------------------------------------------------------------
lapply(dados[, 3:7], mean) # na.rm = T para lidar com NAs


## ------------------------------------------------------------------------
sapply(dados[, 3:7], mean, na.rm = T)


## ------------------------------------------------------------------------
apply(dados[, 3:7], 2, mean, na.rm=T)


## ------------------------------------------------------------------------
tapply(dados$CL, list(dados$especie, dados$sexo), mean)


## ------------------------------------------------------------------------
aggregate(cbind(FL, RW, CL, CW, BD) ~ especie + sexo,
          data = dados, median, na.rm=T)


## ----eval=FALSE----------------------------------------------------------
## plot(x, y, ...)


## ----eval=FALSE----------------------------------------------------------
## plot(y ~ x, data, ...)


## ----out.width=".7\\textwidth"-------------------------------------------
plot(dados)


## ----out.width=".7\\textwidth"-------------------------------------------
plot(dados$CL)     # uma variável


## ----out.width=".49\\textwidth", fig.show="hold"-------------------------
plot(dados$CL, dados$CW)    # duas variáveis, ou:
plot(CW ~ CL, data = dados) # mesmo resultado


## ----out.width=".7\\textwidth"-------------------------------------------
plot(dados$especie, dados$CL)  # fator, numérico


## ----out.width=".7\\textwidth"-------------------------------------------
boxplot(dados[, 3:7])


## ----out.width=".49\\textwidth", fig.show="hold"-------------------------
boxplot(CL ~ especie, data = dados)        # um fator
boxplot(CL ~ especie + sexo, data = dados) # dois fatores


## ----out.width=".7\\textwidth"-------------------------------------------
hist(dados$CL)


## ----out.width=".49\\textwidth", fig.show="hold"-------------------------
hist(dados$CL, breaks = seq(10, 50, 1)) # ou
hist(dados$CL, nclass = 40)             # aproximado


## ----out.width=".6\\textwidth", fig.keep="none"--------------------------
h <- hist(dados$CL)
h


## ----out.width=".49\\textwidth", fig.show="hold"-------------------------
hist(dados$CL)           # contagem
hist(dados$CL, freq = F) # densidade


## ----out.width=".45\\textwidth"------------------------------------------
table(dados$especie)
barplot(table(dados$especie))


## ----out.width=".4\\textwidth", fig.show="hold"--------------------------
table(dados$especie, dados$sexo)
barplot(table(dados$especie, dados$sexo))
barplot(table(dados$especie, dados$sexo), beside = T)


## ----out.width=".55\\textwidth"------------------------------------------
plot(dados$CL, dados$CW,
     xlab = "Comprimento da carapaça (cm)",
     ylab = "Largura da carapaça (cm)",
     main = "Relação entre CL e CW")


## ----out.width=".55\\textwidth"------------------------------------------
hist(dados$CL, main = "", xlim = c(0, 60),
     xlab = "Comprimento da carapaça (cm)",
     ylab = "Frequência")


