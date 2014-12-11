
## ----setup, include=FALSE, cache=FALSE-----------------------------------
# smaller font size for chunks
opts_chunk$set(size = "small",
               prompt = FALSE,
               comment = NA,
               tidy = FALSE,
               cache = TRUE,
               fig.align = "center",
               fig.width = 5,
               fig.height = 5)
## thm <- knit_theme$get("beamer3")
## knit_theme$set(thm)
options(width = 65, digits = 7, scipen = 0) # continue = "  ")
## Use pdfcrop=TRUE nos chunks para reduzir a area do PDF
knit_hooks$set(pdfcrop = hook_pdfcrop)


## ------------------------------------------------------------------------
# valores críticos de z com alfa = 0,05 (bilateral)
qnorm(0.025)
qnorm(0.975)
# valores críticos de t com diferentes G.L.
qt(0.025, df = 9)
qt(0.025,df = 900)


## ------------------------------------------------------------------------
## Dados
xbarra <- 83
desvio <- 12
n <- 5
## Erro padrão
erro <- desvio/sqrt(n)
## Média - erro
xbarra + erro * qt(0.025, df = n)
## Média + erro
xbarra + erro * qt(0.975, df = n)


## ------------------------------------------------------------------------
dbinom(x = 0:1, size = 1, prob = .2)
dbinom(x = 0:1, size = 1, prob = .5)
dbinom(x = 0:1, size = 1, prob = .7)
dbinom(x = 0:1, size = 1, prob = .9)


## ----eval=FALSE, pdfcrop=TRUE--------------------------------------------
## par(mfrow=c(2,2))
## plot(0:1, dbinom(x = 0:1, size = 1, prob = .2), type = "h",
##      xlab = "X", ylab = "P[X = x]", main = "p = 0.2",
##      ylim = c(0,1))
## plot(0:1, dbinom(x = 0:1, size = 1, prob = .5), type = "h",
##      xlab = "X", ylab = "P[X = x]", main = "p = 0.5",
##      ylim = c(0,1))
## plot(0:1, dbinom(x = 0:1, size = 1, prob = .7), type = "h",
##      xlab = "X", ylab = "P[X = x]", main = "p = 0.7",
##      ylim = c(0,1))
## plot(0:1, dbinom(x = 0:1, size = 1, prob = .9), type = "h",
##      xlab = "X", ylab = "P[X = x]", main = "p = 0.9",
##      ylim = c(0,1))


## ----echo=FALSE, pdfcrop=TRUE, fig.width=8, fig.height=6-----------------
par(mfrow=c(2,2))
plot(0:1, dbinom(x = 0:1, size = 1, prob = .2), type = "h",
     xlab = "X", ylab = "P[X = x]", main = "p = 0.2",
     ylim = c(0,1))
plot(0:1, dbinom(x = 0:1, size = 1, prob = .5), type = "h",
     xlab = "X", ylab = "P[X = x]", main = "p = 0.5",
     ylim = c(0,1))
plot(0:1, dbinom(x = 0:1, size = 1, prob = .7), type = "h",
     xlab = "X", ylab = "P[X = x]", main = "p = 0.7",
     ylim = c(0,1))
plot(0:1, dbinom(x = 0:1, size = 1, prob = .9), type = "h",
     xlab = "X", ylab = "P[X = x]", main = "p = 0.9",
     ylim = c(0,1))


## ------------------------------------------------------------------------
dbinom(x = 0:5, size = 5, prob = .2)
dbinom(x = 0:5, size = 5, prob = .5)
dbinom(x = 0:5, size = 5, prob = .7)
dbinom(x = 0:5, size = 5, prob = .9)


## ----eval=FALSE, pdfcrop=TRUE--------------------------------------------
## par(mfrow=c(2,2))
## plot(0:10, dbinom(x = 0:10, size = 10, prob = .2), type = "h",
##      xlab = "X", ylab = "P[X = x]", main = "n = 10, p = 0.2",
##      ylim = c(0,.5))
## plot(0:10, dbinom(x = 0:10, size = 10, prob = .5), type = "h",
##      xlab = "X", ylab = "P[X = x]", main = "n = 10, p = 0.5",
##      ylim = c(0,.5))
## plot(0:10, dbinom(x = 0:10, size = 10, prob = .7), type = "h",
##      xlab = "X", ylab = "P[X = x]", main = "n = 10, p = 0.7",
##      ylim = c(0,.5))
## plot(0:10, dbinom(x = 0:10, size = 10, prob = .9), type = "h",
##      xlab = "X", ylab = "P[X = x]", main = "n = 10, p = 0.9",
##      ylim = c(0,.5))


## ----echo=FALSE, pdfcrop=TRUE, fig.width=8, fig.height=6-----------------
par(mfrow=c(2,2))
plot(0:10, dbinom(x = 0:10, size = 10, prob = .2), type = "h",
     xlab = "X", ylab = "P[X = x]", main = "n = 10, p = 0.2",
     ylim = c(0,.5))
plot(0:10, dbinom(x = 0:10, size = 10, prob = .5), type = "h",
     xlab = "X", ylab = "P[X = x]", main = "n = 10, p = 0.5",
     ylim = c(0,.5))
plot(0:10, dbinom(x = 0:10, size = 10, prob = .7), type = "h",
     xlab = "X", ylab = "P[X = x]", main = "n = 10, p = 0.7",
     ylim = c(0,.5))
plot(0:10, dbinom(x = 0:10, size = 10, prob = .9), type = "h",
     xlab = "X", ylab = "P[X = x]", main = "n = 10, p = 0.9",
     ylim = c(0,.5))


## ------------------------------------------------------------------------
dpois(x = 0:10, lambda = 1)
dpois(x = 0:10, lambda = 5)
dpois(x = 0:10, lambda = 10)
dpois(x = 0:10, lambda = 15)


## ----eval=FALSE, pdfcrop=TRUE--------------------------------------------
## par(mfrow=c(2,2))
## plot(0:30, dpois(x = 0:30, lambda = 1), type = "h",
##      xlab = "X", ylab = "P[X = x]", main = expression(mu == 1),
##      ylim = c(0,.4))
## plot(0:30, dpois(x = 0:30, lambda = 5), type = "h",
##      xlab = "X", ylab = "P[X = x]", main = expression(mu == 5),
##      ylim = c(0,.4))
## plot(0:30, dpois(x = 0:30, lambda = 10), type = "h",
##      xlab = "X", ylab = "P[X = x]", main = expression(mu == 10),
##      ylim = c(0,.4))
## plot(0:30, dpois(x = 0:30, lambda = 15), type = "h",
##      xlab = "X", ylab = "P[X = x]", main = expression(mu == 15),
##      ylim = c(0,.4))


## ----echo=FALSE, pdfcrop=TRUE, fig.width=8, fig.height=6-----------------
par(mfrow=c(2,2))
plot(0:30, dpois(x = 0:30, lambda = 1), type = "h",
     xlab = "X", ylab = "P[X = x]", main = expression(mu == 1),
     ylim = c(0,.4))
plot(0:30, dpois(x = 0:30, lambda = 5), type = "h",
     xlab = "X", ylab = "P[X = x]", main = expression(mu == 5),
     ylim = c(0,.4))
plot(0:30, dpois(x = 0:30, lambda = 10), type = "h",
     xlab = "X", ylab = "P[X = x]", main = expression(mu == 10),
     ylim = c(0,.4))
plot(0:30, dpois(x = 0:30, lambda = 15), type = "h",
     xlab = "X", ylab = "P[X = x]", main = expression(mu == 15),
     ylim = c(0,.4))


## ----size="footnotesize"-------------------------------------------------
dnorm(x = 40:60, mean = 50, sd = 5)
dnorm(x = 40:60, mean = 50, sd = 10)
dnorm(x = 90:110, mean = 100, sd = 5)
dnorm(x = 190:210, mean = 200, sd = 5)


## ----eval=FALSE, pdfcrop=TRUE, size="footnotesize"-----------------------
## par(mfrow=c(2,2))
## plot(seq(10, 90, length=100), type = "l", xlab = "X", ylab = "f(x)",
##      y = dnorm(x = seq(10, 90, length=100), mean = 50, sd = 5),
##      main = expression(list(mu == 50, sigma^2 == 25)))
## plot(seq(10, 90, length=100), type = "l", xlab = "X", ylab = "f(x)",
##      y = dnorm(x = seq(10, 90, length=100), mean = 50, sd = 10),
##      main = expression(list(mu == 50, sigma^2 == 100)))
## plot(seq(70, 130, length=100), type = "l", xlab = "X", ylab = "f(x)",
##      y = dnorm(x = seq(70, 130, length=100), mean = 100, sd = 5),
##      main = expression(list(mu == 100, sigma^2 == 25)))
## plot(seq(170, 230, length=100), type = "l", xlab = "X", ylab = "f(x)",
##      y = dnorm(x = seq(170, 230, length=100), mean = 200, sd = 5),
##      main = expression(list(mu == 200, sigma^2 == 25)))
## par(mfrow=c(1,1))


## ----echo=FALSE, pdfcrop=TRUE, fig.width=8, fig.height=6-----------------
par(mfrow=c(2,2))
plot(seq(10, 90, length=100), type = "l", xlab = "X", ylab = "f(x)",
     y = dnorm(x = seq(10, 90, length=100), mean = 50, sd = 5),
     main = expression(list(mu == 50, sigma^2 == 25)))
plot(seq(10, 90, length=100), type = "l", xlab = "X", ylab = "f(x)",
     y = dnorm(x = seq(10, 90, length=100), mean = 50, sd = 10),
     main = expression(list(mu == 50, sigma^2 == 100)))
plot(seq(70, 130, length=100), type = "l", xlab = "X", ylab = "f(x)",
     y = dnorm(x = seq(70, 130, length=100), mean = 100, sd = 5),
     main = expression(list(mu == 100, sigma^2 == 25)))
plot(seq(170, 230, length=100), type = "l", xlab = "X", ylab = "f(x)",
     y = dnorm(x = seq(170, 230, length=100), mean = 200, sd = 5),
     main = expression(list(mu == 200, sigma^2 == 25)))
par(mfrow=c(1,1))


## ------------------------------------------------------------------------
dados <- read.table("../dados/crabs.csv", header = T,
                    sep = ";", dec = ",")
str(dados)


## ----out.width=".6\\textwidth"-------------------------------------------
hist(dados$CL, main = "", ylab = "Frequência absoluta",
     xlab = "Comprimento da carapaça (mm)", col = "grey")


## ------------------------------------------------------------------------
t.test(dados$CL, mu = 30, alternative = "two.sided",
       conf.level = 0.95)


## ------------------------------------------------------------------------
## Dados
xbarra <- mean(dados$CL)
mu0 <- 30
dp <- sd(dados$CL)
n <- nrow(dados)
# t calculado
(tcalc <- (xbarra - mu0)/(dp/sqrt(n)))
# t critico (não é apresentado no resultado)
qt(0.025, df = n - 1, lower.tail = FALSE)
# valor p (multiplicado por 2 pois o teste é bilateral)
pt(tcalc, df = n - 1, lower.tail = FALSE) * 2


## ------------------------------------------------------------------------
teste <- t.test(dados$CL, mu = 30, alternative = "two.sided",
                conf.level = 0.95)
names(teste)
teste$statistic
teste$p.value


## ------------------------------------------------------------------------
t.test(dados$CL, mu = 30, alternative = "greater",
       conf.level = 0.95)


## ------------------------------------------------------------------------
t.test(dados$CL, mu = 30, alternative = "less",
       conf.level = 0.95)


## ----eval=FALSE, echo=FALSE, out.width=".6\\textwidth"-------------------
## par(mfrow = c(1,2))
## hist(dados$CL[dados$especie == "azul"], main = "Azul",
##      xlab = "CL (mm)", ylab = "Frequência", xlim = c(10, 50))
## hist(dados$CL[dados$especie == "laranja"], main = "Laranja",
##      xlab = "CL (mm)", ylab = "Frequência", xlim = c(10, 50))
## par(mfrow = c(1,1))


## ----out.width=".6\\textwidth", fig.width=6, fig.height=5, fig.show="hold"----
par(mfrow = c(1,2))
hist(dados$CL[dados$especie == "azul"], main = "Azul",
     xlab = "CL (mm)", ylab = "Frequência", xlim = c(10, 50))
hist(dados$CL[dados$especie == "laranja"], main = "Laranja",
     xlab = "CL (mm)", ylab = "Frequência", xlim = c(10, 50))
par(mfrow = c(1,1))


## ----out.width=".6\\textwidth"-------------------------------------------
require(lattice) # pacote para gráficos avançados
histogram(~CL | especie, data = dados)


## ------------------------------------------------------------------------
with(dados, tapply(CL, especie, summary))


## ------------------------------------------------------------------------
t.test(CL ~ especie, data = dados, mu = 0,
       alternative = "two.sided", conf.level = 0.95)


## ------------------------------------------------------------------------
t.test(CL ~ especie, data = dados, mu = 0,
       alternative = "greater", conf.level = 0.95)


## ----out.width=".6\\textwidth"-------------------------------------------
plot(CW ~ CL, data = dados)


## ------------------------------------------------------------------------
mod <- lm(CW ~ CL, data = dados)
mod


## ----size="footnotesize"-------------------------------------------------
summary(mod)


## ------------------------------------------------------------------------
anova(mod)


## ----out.width=".49\\textwidth", fig.show="hold"-------------------------
plot(CW ~ CL, data = dados)
abline(mod)
plot(CW ~ CL, data = dados, xlim = c(0,50), ylim = c(0,55))
abline(mod)


## ----out.width=".6\\textwidth", fig.show="hold", fig.width=7, fig.height=7----
par(mfrow = c(2,2))
plot(mod)
par(mfrow = c(1,1))


## ------------------------------------------------------------------------
names(mod)
names(summary(mod))
names(anova(mod))


## ------------------------------------------------------------------------
sqrt(anova(mod)$Sum[2]/anova(mod)$Df[2])


## ------------------------------------------------------------------------
anova(mod)$F[1]


## ------------------------------------------------------------------------
summary(mod)$coef[2,3]^2


## ----out.width=".33\\textwidth",fig.show="hold", echo=FALSE,fig.width=5,fig.height=5----
plot(1:10, 1:10, type = "l", xlab = "", ylab = "",  main = "r = 1")
plot(1:10, rep(5,10), type = "l", xlab = "", ylab = "", main = "r = 0")
plot(1:10, -1:-10, type = "l", xlab = "", ylab = "", main = "r = -1")


## ----echo=FALSE,pdfcrop=TRUE, fig.width=8, fig.height=6------------------
x <- (1:100)/10
n <- length(x)
set.seed(1000)
par(mfrow=c(2,2))

e <- rnorm(n, 0, 2)
y <- 20 + x + e
cor <- round(cor(x,y), 2)
r <- round(cor^2, 2)
lis <- list(bquote(r == .(cor)),
            bquote(r^2 == .(r)))
plot(y ~ x, xlim = c(0, 10), ylim = c(0, 45))
mtext(do.call(expression, lis), side = 3, line = 0:1)
mm <- lm(y ~ x)
abline(mm, lwd = 2)

e <- rnorm(n, 0, 4)
y <- 20 + x + e
cor <- round(cor(x,y), 2)
r <- round(cor^2, 2)
lis <- list(bquote(r == .(cor)),
            bquote(r^2 == .(r)))
plot(y ~ x, xlim = c(0, 10), ylim = c(0, 45))
mtext(do.call(expression, lis), side = 3, line = 0:1)
mm <- lm(y ~ x)
abline(mm, lwd = 2)

e <- rnorm(n, 0, 6)
y <- 20 + x + e
cor <- round(cor(x,y), 2)
r <- round(cor^2, 2)
lis <- list(bquote(r == .(cor)),
            bquote(r^2 == .(r)))
plot(y ~ x, xlim = c(0, 10), ylim = c(0, 45))
mtext(do.call(expression, lis), side = 3, line = 0:1)
mm <- lm(y ~ x)
abline(mm, lwd = 2)

e <- rnorm(n, 0, 8)
y <- 20 + x + e
cor <- round(cor(x,y), 2)
r <- round(cor^2, 2)
lis <- list(bquote(r == .(cor)),
            bquote(r^2 == .(r)))
plot(y ~ x, xlim = c(0, 10), ylim = c(0, 45))
mtext(do.call(expression, lis), side = 3, line = 0:1)
mm <- lm(y ~ x)
abline(mm, lwd = 2)

par(mfrow = c(1,1))


## ------------------------------------------------------------------------
with(dados, tapply(CL, especie, summary))


## ------------------------------------------------------------------------
mean(dados$CL)


## ----out.width=".6\\textwidth"-------------------------------------------
boxplot(CL ~ especie, data = dados)
abline(h = mean(dados$CL), lty = 2, col = "red", lwd = 2)


## ----out.width=".7\\textwidth", echo=FALSE-------------------------------
plot(CL ~ as.numeric(especie), data = dados, axes = FALSE,
     xlim = c(0,3), xlab = "Espécie", ylab = "CL")
axis(1, at = seq(0,3,1), labels = c("", "Azul", "Laranja", ""), tick = FALSE)
axis(2); box()
points(1, mean(dados$CL[dados$especie == "azul"]), pch = 15,
       cex = 2, col = "blue")
points(2, mean(dados$CL[dados$especie == "laranja"]), pch = 15,
       cex = 2, col = "orange")
abline(h = mean(dados$CL), lty = 2, col = "red", lwd = 2)


## ----size="footnotesize"-------------------------------------------------
mod <- lm(CL ~ especie, data = dados)
summary(mod)


## ----out.width=".7\\textwidth", echo=FALSE-------------------------------
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


## ----size="footnotesize"-------------------------------------------------
teste <- t.test(CL ~ especie, data = dados, mu = 0,
                alternative = "two.sided", conf.level = 0.95)
teste


## ----size="footnotesize", echo=-c(1,2,7)---------------------------------
sci <- getOption("scipen")
options(scipen = -1)
summary(mod)$coefficients
teste$p.value
teste$estimate
diff(teste$estimate)
options(scipen = sci)


## ------------------------------------------------------------------------
anova(mod)


## ------------------------------------------------------------------------
mod.anova <- aov(CL ~ especie, data = dados)
TukeyHSD(mod.anova)


## ----size="footnotesize"-------------------------------------------------
mod.glm <- glm(CL ~ especie, data = dados,
               family = gaussian(link = "identity"))
summary(mod.glm)


