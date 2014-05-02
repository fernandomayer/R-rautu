
## @knitr setup
# smaller font size for chunks
opts_chunk$set(size = "small",
               prompt = TRUE,
               comment = NA,
               tidy = FALSE,
               cache = TRUE,
               fig.align = "center",
               fig.width = 5,
               fig.height = 5)
thm <- knit_theme$get("beamer2")
knit_theme$set(thm)
options(width = 65, digits = 5, continue = "  ")


## @knitr unnamed-chunk-1
dados <- read.table("crabs.csv", header = T, sep = ";",
                    dec = ",")


## @knitr unnamed-chunk-2
str(dados)


## @knitr unnamed-chunk-3
head(dados, 10) # ou: dados[1:10,]


## @knitr unnamed-chunk-4
mean(dados$CL) # ou sum(dados$CL)/length(dados$CL)


## @knitr unnamed-chunk-5
mean(dados$BD)


## @knitr unnamed-chunk-6
mean(dados$BD, na.rm=T)


## @knitr unnamed-chunk-7
sd(dados$CL)


## @knitr unnamed-chunk-8
var(dados$CL) # sd(dados$CL)^2


## @knitr unnamed-chunk-9
sd(dados$CL)/mean(dados$CL)


## @knitr unnamed-chunk-10
quantile(dados$CL)


## @knitr unnamed-chunk-11
quantile(dados$CL, probs = seq(0, 1, 0.1))


## @knitr unnamed-chunk-12
summary(dados$CL)


## @knitr unnamed-chunk-13
summary(dados$BD)


## @knitr unnamed-chunk-14
summary(dados)


## @knitr unnamed-chunk-15
table(dados$especie)


## @knitr unnamed-chunk-16
table(dados$especie, dados$sexo)


## @knitr unnamed-chunk-17
lapply(dados[, 3:7], mean) # na.rm = T para lidar com NAs


## @knitr unnamed-chunk-18
sapply(dados[, 3:7], mean, na.rm = T)


## @knitr unnamed-chunk-19
sapply(dados[, 3:7], mean, na.rm = T)


## @knitr unnamed-chunk-20
apply(dados[, 3:7], 2, mean, na.rm=T)


## @knitr unnamed-chunk-21
tapply(dados$CL, list(dados$especie, dados$sexo), mean)


## @knitr unnamed-chunk-22
aggregate(cbind(FL, RW, CL, CW, BD) ~ especie + sexo,
          data = dados, median, na.rm=T)


## @knitr unnamed-chunk-23
plot(x, y, ...)


## @knitr unnamed-chunk-24
plot(y ~ x, data, ...)


## @knitr unnamed-chunk-25
plot(dados)


## @knitr unnamed-chunk-26
plot(dados$CL)     # uma variável


## @knitr unnamed-chunk-27
plot(dados$CL, dados$CW)    # duas variáveis, ou:
plot(CW ~ CL, data = dados) # mesmo resultado


## @knitr unnamed-chunk-28
plot(dados$especie, dados$CL)  # fator, numérico


## @knitr unnamed-chunk-29
boxplot(dados[, 3:7])


## @knitr unnamed-chunk-30
boxplot(CL ~ especie, data = dados)        # um fator
boxplot(CL ~ especie + sexo, data = dados) # dois fatores


## @knitr unnamed-chunk-31
hist(dados$CL)


## @knitr unnamed-chunk-32
hist(dados$CL, breaks = seq(10, 50, 1)) # ou
hist(dados$CL, nclass = 40)             # aproximado


## @knitr unnamed-chunk-33
h <- hist(dados$CL)
h


## @knitr unnamed-chunk-34
hist(dados$CL)           # contagem
hist(dados$CL, freq = F) # densidade


## @knitr unnamed-chunk-35
table(dados$especie)
barplot(table(dados$especie))


## @knitr unnamed-chunk-36
table(dados$especie, dados$sexo)
barplot(table(dados$especie, dados$sexo))
barplot(table(dados$especie, dados$sexo), beside = T)


## @knitr unnamed-chunk-37
plot(dados$CL, dados$CW,
     xlab = "Comprimento da carapaça (cm)",
     ylab = "Largura da carapaça (cm)",
     main = "Relação entre CL e CW")


## @knitr unnamed-chunk-38
hist(dados$CL, main = "", xlim = c(0, 60),
     xlab = "Comprimento da carapaça (cm)",
     ylab = "Frequência")


