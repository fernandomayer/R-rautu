##======================================================================
## Curso R - UNIVALI
## 26-27, novembro, 2012
## Modelos não-lineares
##======================================================================

##----------------------------------------------------------------------
## Estimativas de parâmetros do modelo de von Bertalanffy
##----------------------------------------------------------------------

## Importação de dados de comprimento e idade
dados.comp <- read.csv2("dados_comprimento.csv")
str(dados.comp)
summary(dados.comp)

## Relação
with(dados.comp, plot(Idade, Comprimento))
hist(dados.comp$Comprimento, main = "",
     xlab = "Comprimento", ylab = "Frequência")

## Ajuste do modelo de von Bertalanffy
## L_t = L_\infty[1 - exp(-k(t-t0))]

## Como "chutar" valores de Linf, k e t0?
browseURL("http://fishbase.org/summary/Katsuwonus-pelamis.html")

## Ajuste do modelo por mínimos quadrados não-lineares
mod.comp <- nls(Comprimento ~ Linf * (1 - exp(-k*(Idade-t0))),
                data = dados.comp, trace = TRUE,
                start = list(Linf = 97.1, k = 0.22, t0 = -2.07))
# sumário do modelo
summary(mod.comp)

## Ajuste grafico
# extrai os parametros do modelo e salva em objetos separados
Linf <- coef(mod.comp)[1]
k <- coef(mod.comp)[2]
t0 <- coef(mod.comp)[3]

# cria uma sequencia de idades para usar na predicao
idade <- seq(min(dados.comp$Idade), max(dados.comp$Idade), 1)
# calcula os comprimentos teoricos, baseados no ajuste do modelo
# ("comprimento estimado")
comprimento <- Linf * (1 - exp(-k*(idade-t0)))
# plot dos dados observados
with(dados.comp, plot(Idade, Comprimento,
                 main = "Modelo de von Bertallanfy"))
# inclui a linha com os valores preditos pelo modelo
lines(idade, comprimento)
# adiciona a equacao de von Bertallanfy no grafico
text(x = 3.5, y = 50, cex = 1.5,
     labels = bquote(L[t] == .(Linf) (1 - e^{-.(k)(t - .(t0))})))
# pare ver mais opcoes de anotacao matematica em graficos veja
# demo(plotmath)
