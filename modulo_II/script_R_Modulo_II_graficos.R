##======================================================================
## Gráficos avançados
##======================================================================

## Instalação do pacote ggplot2
install.packages("ggplot2", dependencies = TRUE)

## Importa a base de dados
dados <- read.table("../dados/Dados_ICCAT.csv", header = TRUE,
                     sep = ";", dec = ",")
str(dados)
summary(dados)

## Identificacao de trimestres
dados$Trimestre <- 1
dados$Trimestre[dados$MES == 4 | dados$MES == 5 | dados$MES == 6] <- 2
dados$Trimestre[dados$MES == 7 | dados$MES == 8 | dados$MES == 9] <- 3
dados$Trimestre[dados$MES == 10 | dados$MES == 11 | dados$MES == 12] <- 4

## Calculo da CPUE (kg/1000 anzois)
dados$Cpue.LAGE <- (dados$LAGE*1000)/dados$EFF
dados$Cpue.BRANCA <- (dados$BRANCA*1000)/dados$EFF
dados$Cpue.BANDOLIM <- (dados$BANDOLIM*1000)/dados$EFF

## CPUE da albacora-lage
par(mfrow = c(1,2))
hist(dados$Cpue.LAGE)
hist(log(dados$Cpue.LAGE))
par(mfrow = c(1,1))

## Tamanho amostral - quantidade de informacao por cruzamento de fatores
table(dados$FROTA)
table(dados$ANO)
table(dados$Trimestre)
table(dados$Trimestre, dados$ANO)
barplot(table(dados$Trimestre, dados$ANO), beside = T)
mosaicplot(table(dados$Trimestre, dados$ANO))
table(dados$ANO, dados$Trimestre, dados$FROTA)
mosaicplot(table(dados$ANO, dados$Trimestre, dados$FROTA))

## Algumas relacoes que podem ser exploradas graficamente
boxplot(log(Cpue.LAGE) ~ FROTA, data = dados)
boxplot(log(Cpue.LAGE) ~ ANO, data = dados)
boxplot(log(Cpue.LAGE) ~ Trimestre, data = dados)
boxplot(log(Cpue.LAGE) ~ ANO + Trimestre, data = dados)

## Uma forma mais eficiente - usando lattice
require(lattice) # para carregar o pacote
bwplot(~log(Cpue.LAGE) | FROTA, data = dados, as.table = TRUE,
       layout = c(1,2))
bwplot(~log(Cpue.LAGE) | factor(ANO) + factor(Trimestre), data = dados,
       as.table = TRUE)
bwplot(~log(Cpue.LAGE) | factor(Trimestre) + factor(ANO), data = dados,
       as.table = TRUE)
bwplot(~log(Cpue.LAGE) | factor(ANO) + FROTA, data = dados,
       as.table = TRUE)
bwplot(~log(Cpue.LAGE) | factor(Trimestre) + FROTA, data = dados,
       as.table = TRUE)
bwplot(~log(Cpue.LAGE) | factor(Trimestre) + factor(ANO) + FROTA,
       data = dados, as.table = TRUE)

## Histogramas
histogram(~log(Cpue.LAGE) | FROTA, data = dados, as.table = TRUE,
          layout = c(1,2))
histogram(~log(Cpue.LAGE) | factor(ANO) + FROTA, data = dados,
          as.table = TRUE)
histogram(~log(Cpue.LAGE) | factor(Trimestre) + FROTA, data = dados,
          as.table = TRUE)

## X-Y plot
xyplot(log(Cpue.LAGE) ~ log(Cpue.BRANCA), data = dados)
xyplot(log(Cpue.LAGE) ~ log(Cpue.BRANCA) | factor(ANO), data = dados,
       as.table = TRUE)
xyplot(log(Cpue.LAGE) ~ log(Cpue.BRANCA) | factor(Trimestre) +
       factor(ANO), data = dados, as.table = TRUE)
xyplot(log(Cpue.LAGE) ~ log(Cpue.BRANCA) | factor(ANO) + FROTA,
       data = dados, as.table = TRUE)

## Equivalentes com ggplot
require(ggplot2)

## Boxplots

# CPUE ~ FROTA
(p <- ggplot(dados, aes(x = FROTA, y = log(Cpue.LAGE))) +
     geom_boxplot() + labs(x = "Frota", y = "CPUE"))

# CPUE ~ FROTA + ANO
(p <- ggplot(dados, aes(x = FROTA, y = log(Cpue.LAGE))) +
      geom_boxplot() + labs(x = "Frota", y = "CPUE") +
      facet_wrap( ~ ANO, scales = "free"))

# CPUE ~ FROTA + TRIMESTRE
(p <- ggplot(dados, aes(x = FROTA, y = log(Cpue.LAGE))) +
      geom_boxplot() + labs(x = "Frota", y = "CPUE") +
      facet_wrap( ~ Trimestre, scales = "free"))

# CPUE ~ FROTA + ANO + TRIMESTRE
(p <- ggplot(dados, aes(x = FROTA, y = log(Cpue.LAGE))) +
      geom_boxplot() + labs(x = "Frota", y = "CPUE") +
      facet_grid(ANO ~ Trimestre, scales = "free"))

## Histogramas

# CPUE
(p <- ggplot(dados, aes(x = log(Cpue.LAGE))) +
      geom_histogram(binwidth = 1, colour = "black", fill = "black",
                     alpha = 0.2) + labs(x = "log(CPUE)", y =
                         "Frequência"))

# CPUE + FROTA ~ ANO
(p <- ggplot(dados, aes(x = log(Cpue.LAGE), fill = FROTA)) +
      geom_histogram(binwidth = .5, alpha = 0.2, position = "dodge") +
      labs(x = "log(CPUE)", y = "Frequência") +
      facet_wrap( ~ ANO, scales = "free") +
      scale_fill_manual(values = c("green", "blue")))

# CPUE + FROTA ~ ANO + TRIMESTRE
(p <- ggplot(dados, aes(x = log(Cpue.LAGE), fill = FROTA)) +
      geom_histogram(binwidth = .5, alpha = 0.2, position = "identity") +
      labs(x = "log(CPUE)", y = "Frequência") +
      facet_grid(ANO ~ Trimestre, scales = "free") +
      scale_fill_manual(values = c("green", "blue")))

## Scatterplots

# CPUE.LAGE ~ CPUE.BRANCA
(p <- ggplot(dados, aes(x = log(Cpue.BRANCA), y = log(Cpue.LAGE))) +
      geom_point())

# CPUE.LAGE ~ CPUE.BRANCA | ANO
(p <- ggplot(dados, aes(x = log(Cpue.BRANCA), y = log(Cpue.LAGE))) +
      geom_point() + facet_wrap( ~ ANO, scales = "free"))

# CPUE.LAGE ~ CPUE.BRANCA | ANO + TRIMESTRE
(p <- ggplot(dados, aes(x = log(Cpue.BRANCA), y = log(Cpue.LAGE))) +
      geom_point() + facet_grid(ANO ~ Trimestre, scales = "free"))

# CPUE.LAGE ~ CPUE.BRANCA | ANO ~ FROTA
(p <- ggplot(dados, aes(x = log(Cpue.BRANCA), y = log(Cpue.LAGE),
                        colour = FROTA)) +
      geom_point() + facet_wrap( ~ ANO, scales = "free"))

# CPUE.LAGE ~ CPUE.BRANCA | ANO + TRIMESTRE ~ FROTA
(p <- ggplot(dados, aes(x = log(Cpue.BRANCA), y = log(Cpue.LAGE),
                        colour = FROTA)) +
      geom_point() + facet_grid(ANO ~ Trimestre, scales = "free"))





