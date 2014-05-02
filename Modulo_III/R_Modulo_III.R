
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
# valores críticos de z com alfa = 0,05 (bilateral)
qnorm(0.025)
qnorm(0.975)
# valores críticos de t com diferentes G.L.
qt(0.025, df = 9)
qt(0.025,df = 900)


## @knitr unnamed-chunk-2
dados <- read.table("crabs.csv", header = T, sep = ";",
                    dec = ",")
str(dados)


## @knitr unnamed-chunk-3
hist(dados$CL, main = "", ylab = "Frequência absoluta",
     xlab = "Comprimento da carapaça (mm)", col = "grey")


## @knitr unnamed-chunk-4
t.test(dados$CL, mu = 30, alternative = "two.sided",
       conf.level = 0.95)


## @knitr unnamed-chunk-5
teste <- t.test(dados$CL, mu = 30, alternative = "two.sided",
                conf.level = 0.95)
names(teste)
teste$statistic
teste$p.value


## @knitr unnamed-chunk-6
t.test(dados$CL, mu = 30, alternative = "greater",
       conf.level = 0.95)


## @knitr unnamed-chunk-7
t.test(dados$CL, mu = 30, alternative = "less",
       conf.level = 0.95)


## @knitr unnamed-chunk-8
require(lattice) # pacote para gráficos avançados
histogram(~CL | especie, data = dados)


## @knitr unnamed-chunk-9
with(dados, tapply(CL, especie, summary))


## @knitr unnamed-chunk-10
t.test(CL ~ especie, data = dados, mu = 0,
       alternative = "two.sided", conf.level = 0.95)


## @knitr unnamed-chunk-11
t.test(CL ~ especie, data = dados, mu = 0,
       alternative = "greater", conf.level = 0.95)


## @knitr unnamed-chunk-12
plot(CW ~ CL, data = dados)


## @knitr unnamed-chunk-13
plot(1:10, 1:10, type = "l", xlab = "", ylab = "",  main = "r = 1")
plot(1:10, rep(5,10), type = "l", xlab = "", ylab = "", main = "r = 0")
plot(1:10, -1:-10, type = "l", xlab = "", ylab = "", main = "r = -1")


## @knitr unnamed-chunk-14
cor(dados$CL, dados$CW)
cor.test(dados$CL, dados$CW)


## @knitr unnamed-chunk-15
mod <- lm(CW ~ CL, data = dados)
mod


## @knitr unnamed-chunk-16
summary(mod)


## @knitr unnamed-chunk-17
plot(CW ~ CL, data = dados)
abline(mod)
plot(CW ~ CL, data = dados, xlim = c(0,50), ylim = c(0,55))
abline(mod)


## @knitr unnamed-chunk-18
par(mfrow = c(2,2))
plot(mod)
par(mfrow = c(1,1))


## @knitr unnamed-chunk-19
names(mod)
names(summary(mod))


## @knitr unnamed-chunk-20
with(dados, tapply(CL, especie, summary))


## @knitr unnamed-chunk-21
mean(dados$CL)


## @knitr unnamed-chunk-22
boxplot(CL ~ especie, data = dados)
abline(h = mean(dados$CL), lty = 2, col = "red", lwd = 2)


## @knitr unnamed-chunk-23
plot(CL ~ as.numeric(especie), data = dados, axes = FALSE,
     xlim = c(0,3), xlab = "Espécie", ylab = "CL")
axis(1, at = seq(0,3,1), labels = c("", "Azul", "Laranja", ""), tick = FALSE)
axis(2); box()
points(1, mean(dados$CL[dados$especie == "azul"]), pch = 15,
       cex = 2, col = "blue")
points(2, mean(dados$CL[dados$especie == "laranja"]), pch = 15,
       cex = 2, col = "orange")
abline(h = mean(dados$CL), lty = 2, col = "red", lwd = 2)


## @knitr unnamed-chunk-24
mod <- lm(CL ~ especie, data = dados)
summary(mod)


## @knitr unnamed-chunk-25
plot(CL ~ as.numeric(especie), data = dados, axes = FALSE,
     xlim = c(0,3), xlab = "Espécie", ylab = "CL")
axis(1, at = seq(0,3,1), labels = c("", "Azul", "Laranja", ""), tick = FALSE)
axis(2); box()
points(1, mean(dados$CL[dados$especie == "azul"]), pch = 15,
       cex = 2, col = "blue")
points(2, mean(dados$CL[dados$especie == "laranja"]), pch = 15,
       cex = 2, col = "orange")
abline(h = mean(dados$CL), lty = 2, col = "red", lwd = 2)
segments(1, mean(dados$CL[dados$especie=="azul"]),
         2, mean(dados$CL[dados$especie=="laranja"]))
# abline(mod)


## @knitr unnamed-chunk-26
teste <- t.test(CL ~ especie, data = dados, mu = 0,
                alternative = "two.sided", conf.level = 0.95)
teste


## @knitr unnamed-chunk-27
sci <- getOption("scipen")
options(scipen = -1)
summary(mod)$coefficients
teste$p.value
teste$estimate
diff(teste$estimate)
options(scipen = sci)


## @knitr unnamed-chunk-28
anova(mod)


## @knitr unnamed-chunk-29
mod.anova <- aov(CL ~ especie, data = dados)
TukeyHSD(mod.anova)


## @knitr unnamed-chunk-30
mod.glm <- glm(CL ~ especie, data = dados,
               family = gaussian(link = "identity"))
summary(mod.glm)


