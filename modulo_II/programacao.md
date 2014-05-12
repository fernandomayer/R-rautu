# Programação com R

## Programação

- Por quê programar?

	-   Evitar repetições desnecessárias de análises ou cálculos que são
        repetidos com frequência.

    -   Fica documentado as etapas que você realizou para chegar a um
        resultado.

    -   Fácil recuperação e modificação de programas.

-   Como programar?

    -   Criando programas! (Scripts, rotinas, **algoritmos**).

    -   Crie uma sequência lógica de comandos que devem ser executados
        em ordem.

    -   Utilize as ferramentas básicas da programação: **estruturas de
        repetição** (`for()`) e **estruturas de seleção** (`if()`).

## Estrutura de repetição `for()`

-   Serve para repetir um ou mais comandos diversas vezes.

-   Exemplo: cálculo de notas de uma disciplina.


```python

## Importa os dados
notas <- read.table("../dados/notas.csv", header = TRUE, sep = ";", dec = ",")
## Analisa a estrutura dos dados
str(notas)
```

```
## 'data.frame':	30 obs. of  4 variables:
##  $ nome  : Factor w/ 30 levels "Aluno_1","Aluno_10",..: 1 12 23 25 26 27 28 29 30 2 ...
##  $ prova1: int  8 2 9 1 7 10 1 5 5 10 ...
##  $ prova2: int  4 7 2 10 6 0 8 9 6 2 ...
##  $ prova3: int  1 6 4 9 8 3 0 7 1 3 ...
```

```python
head(notas)
```

```
##      nome prova1 prova2 prova3
## 1 Aluno_1      8      4      1
## 2 Aluno_2      2      7      6
## 3 Aluno_3      9      2      4
## 4 Aluno_4      1     10      9
## 5 Aluno_5      7      6      8
## 6 Aluno_6     10      0      3
```

```python
summary(notas)
```

```
##        nome        prova1          prova2          prova3   
##  Aluno_1 : 1   Min.   : 0.00   Min.   : 0.00   Min.   :0.0  
##  Aluno_10: 1   1st Qu.: 2.00   1st Qu.: 3.00   1st Qu.:3.0  
##  Aluno_11: 1   Median : 4.00   Median : 6.00   Median :6.5  
##  Aluno_12: 1   Mean   : 4.43   Mean   : 5.43   Mean   :5.4  
##  Aluno_13: 1   3rd Qu.: 6.75   3rd Qu.: 8.00   3rd Qu.:8.0  
##  Aluno_14: 1   Max.   :10.00   Max.   :10.00   Max.   :9.0  
##  (Other) :24
```


Antes de seguir adiante, veja o resultado de

```python
for (i in 1:30) {
    print(notas[i, c("prova1", "prova2", "prova3")])
}
```



```python
## Para calcular as médias das 3 provas, precisamos inicialmente de um vetor
## para armazenar os resultados. Esse vetor pode ser um novo objeto ou uma
## nova coluna no dataframe

## Aqui vamos criar uma nova coluna no dataframe, contendo apenas o valor 0
notas$media <- 0  # note que aqui será usada a regra da reciclagem, ou
# seja, o valor zero será repetido até completar todas as linhas do
# dataframe Estrutura de repetição para calcular a média
for (i in 1:30) {
    ## Aqui, cada linha i da coluna media sera substituida pelo respectivo valor
    ## da media caculada
    notas$media[i] <- sum(notas[i, c("prova1", "prova2", "prova3")])/3
}

## Confere os resultados
head(notas)
```

```
##      nome prova1 prova2 prova3 media
## 1 Aluno_1      8      4      1 4.333
## 2 Aluno_2      2      7      6 5.000
## 3 Aluno_3      9      2      4 5.000
## 4 Aluno_4      1     10      9 6.667
## 5 Aluno_5      7      6      8 7.000
## 6 Aluno_6     10      0      3 4.333
```


Agora podemos melhorar o código, tornando-o mais **genérico**. Dessa
forma fica mais fácil fazer alterações e procurar erros. Uma forma de
melhorar o código acima é generalizando alguns passos.


```python
## Armazenamos o número de linhas no dataframe
nlinhas <- nrow(notas)
## Identificamos as colunas de interesse no cálculo da média, e armazenamos
## em um objeto separado
provas <- c("prova1", "prova2", "prova3")
## Sabendo o número de provas, fica mais fácil dividir pelo total no cálculo
## da média
nprovas <- length(provas)
## Cria uma nova coluna apenas para comparar o cálculo com o anterior
notas$media2 <- 0
## A estrutura de repetição fica
for (i in 1:nlinhas) {
    notas$media2[i] <- sum(notas[i, provas])/nprovas
}

## Confere
head(notas)
```

```
##      nome prova1 prova2 prova3 media media2
## 1 Aluno_1      8      4      1 4.333  4.333
## 2 Aluno_2      2      7      6 5.000  5.000
## 3 Aluno_3      9      2      4 5.000  5.000
## 4 Aluno_4      1     10      9 6.667  6.667
## 5 Aluno_5      7      6      8 7.000  7.000
## 6 Aluno_6     10      0      3 4.333  4.333
```


Ainda podemos melhorar (leia-se: **otimizar**) o código, se utilizarmos
funções prontas do R. No caso da média isso é possível pois a função
`mean()` já existe. Em seguida veremos como fazer quando o cálculo que
estamos utilizando não está implementado em nenhuma função pronta do R.


```python
## Cria uma nova coluna apenas para comparação
notas$media3 <- 0
## A estrutura de repetição fica
for (i in 1:nlinhas) {
    notas$media3[i] <- mean(as.numeric(notas[i, provas]))
}

## Confere
head(notas)
```

```
##      nome prova1 prova2 prova3 media media2 media3
## 1 Aluno_1      8      4      1 4.333  4.333  4.333
## 2 Aluno_2      2      7      6 5.000  5.000  5.000
## 3 Aluno_3      9      2      4 5.000  5.000  5.000
## 4 Aluno_4      1     10      9 6.667  6.667  6.667
## 5 Aluno_5      7      6      8 7.000  7.000  7.000
## 6 Aluno_6     10      0      3 4.333  4.333  4.333
```

```python

## A única diferença é que aqui precisamos transformar cada linha em um vetor
## de números com as.numeric(), pois
notas[1, provas]
```

```
##   prova1 prova2 prova3
## 1      8      4      1
```

```python
## é um data.frame:
class(notas[1, provas])
```

```
## [1] "data.frame"
```


Np caso acima vimos que não era necessário calcularmos a média através
de `soma/total` porque existe uma função pronta no R para fazer esse
cálculo. Mas, e se quisessemos, por exemplo, calcular a Coeficiente de
Variação (CV) entre as notas das três provas de cada aluno? Uma busca
por

```python
help.search("coefficient of variation")
```

não retorna nenhuma função (dos pacotes básicos) para fazer esse
cálculo. O motivo é simples: como é uma conta simples de fazer não há
necessidade de se criar uma função extra dentro dos pacotes. No entanto,
nós podemos criar uma função que calcule o CV, e usá-la para o nosso
propósito


```python
cv <- function(x) {
    desv.pad <- sd(x)
    med <- mean(x)
    cv <- desv.pad/med
    return(cv)
}
```


> NOTA: na função criada acima o único argumento que usamos foi `x`, que
> neste caso deve ser um vetor de números para o cálculo do CV. Os
> argumentos colocados dentro de `function()` devem ser apropriados para
> o propósito de cada função.

Antes de aplicar a função dentro de um `for()` devemos testá-la para ver
se ela está funcioanando de maneira correta. Por exemplo, o CV para as
notas do primeiro aluno pode ser calculado "manualmente" por

```python
sd(as.numeric(notas[1, provas]))/mean(as.numeric(notas[1, provas]))
```

```
## [1] 0.8104
```

E através da função, o resultado é

```python
cv(as.numeric(notas[1, provas]))
```

```
## [1] 0.8104
```

o que mostra que a função está funcionando corretamente, e podemos
aplicá-la em todas as linhas usando a repetição

```python
## Cria uma nova coluna para o CV
notas$CV <- 0
## A estrutura de repetição fica
for (i in 1:nlinhas) {
    notas$CV[i] <- cv(as.numeric(notas[i, provas]))
}

## Confere
head(notas)
```

```
##      nome prova1 prova2 prova3 media media2 media3     CV
## 1 Aluno_1      8      4      1 4.333  4.333  4.333 0.8104
## 2 Aluno_2      2      7      6 5.000  5.000  5.000 0.5292
## 3 Aluno_3      9      2      4 5.000  5.000  5.000 0.7211
## 4 Aluno_4      1     10      9 6.667  6.667  6.667 0.7399
## 5 Aluno_5      7      6      8 7.000  7.000  7.000 0.1429
## 6 Aluno_6     10      0      3 4.333  4.333  4.333 1.1842
```


Podemos agora querer calcular as médias ponderadas para as provas. Por
exemplo:

- Prova 1: peso 3
- Prova 2: peso 3
- Prova 2: peso 4

Como já vimos que criar uma função é uma forma mais prática (e elegante)
de executar determinada tarefa, vamos criar uma função que calcule as
médias ponderadas.

```python
med.pond <- function(notas, pesos) {
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
```

Antes de aplicar a função para o caso geral, sempre é importante testar
e conferir o resultado em um caso menor. Podemos verificar o resultado
da média ponderada para o primeiro aluno

```python
sum(notas[1, provas] * c(3, 3, 4))/10
```

```
## [1] 4
```

e testar a função para o mesmo caso

```python
med.pond(notas = notas[1, provas], pesos = c(3, 3, 4))
```

```
## [1] 4
```

Como o resultado é o mesmo podemos aplicar a função para todas as linhas
através do `for()`

```python
## Cria uma nova coluna para a média ponderada
notas$MP <- 0
## A estrutura de repetição fica
for (i in 1:nlinhas) {
    notas$MP[i] <- med.pond(notas = notas[i, provas], pesos = c(3, 3, 4))
}

## Confere
head(notas)
```

```
##      nome prova1 prova2 prova3 media media2 media3     CV  MP
## 1 Aluno_1      8      4      1 4.333  4.333  4.333 0.8104 4.0
## 2 Aluno_2      2      7      6 5.000  5.000  5.000 0.5292 5.1
## 3 Aluno_3      9      2      4 5.000  5.000  5.000 0.7211 4.9
## 4 Aluno_4      1     10      9 6.667  6.667  6.667 0.7399 6.9
## 5 Aluno_5      7      6      8 7.000  7.000  7.000 0.1429 7.1
## 6 Aluno_6     10      0      3 4.333  4.333  4.333 1.1842 4.2
```


> NOTA: uma função para calcular a média ponderada já existe
> implementada no R. Veja `?weighted.mean()` e confira os resultados
> obtidos aqui

Repare na construção da função acima: agora usamos dois argumentos,
`notas` e `pesos`, pois precisamos das duas coisas para calcular a média
ponderada. Repare também que ambos argumentos não possuem um valor
padrão. Poderíamos, por exemplo, assumir valores padrão para os pesos, e
deixar para que o usuário mude apenas se achar necessário.

```python
## Atribuindo pesos iguais para as provas como padrão
med.pond <- function(notas, pesos = rep(1, length(notas))) {
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
```


Repare que neste caso, como os pesos são iguais, a chamada da função sem
alterar o argumento `pesos` gera o mesmo resultado do cálculo da média
comum.

```python
## Cria uma nova coluna para a média ponderada para comparação
notas$MP2 <- 0
## A estrutura de repetição fica
for (i in 1:nlinhas) {
    notas$MP2[i] <- med.pond(notas = notas[i, provas])
}

## Confere
head(notas)
```

```
##      nome prova1 prova2 prova3 media media2 media3     CV  MP   MP2
## 1 Aluno_1      8      4      1 4.333  4.333  4.333 0.8104 4.0 4.333
## 2 Aluno_2      2      7      6 5.000  5.000  5.000 0.5292 5.1 5.000
## 3 Aluno_3      9      2      4 5.000  5.000  5.000 0.7211 4.9 5.000
## 4 Aluno_4      1     10      9 6.667  6.667  6.667 0.7399 6.9 6.667
## 5 Aluno_5      7      6      8 7.000  7.000  7.000 0.1429 7.1 7.000
## 6 Aluno_6     10      0      3 4.333  4.333  4.333 1.1842 4.2 4.333
```


## Estrutura de seleção `if()`

-   Adicionando a condição do aluno de acordo com a nota.


```python
## Nova coluna para armazenar os resultados
notas$situacao <- NA
## Estrutura de repetição
for (i in 1:30) {
    pesos <- notas[i, c("prova1", "prova2", "prova3")] * c(4, 3, 3)
    notas$mediap[i] <- sum(pesos)/10
    ## Estrutura de seleção
    if (notas$media[i] >= 7) {
        notas$situacao[i] <- "aprovado"
    } else {
        notas$situacao[i] <- "reprovado"
    }
}
```


## O modo do R: vetorização

Através do processo de vetorização do R, o mesmo algoritmo pode ser
simplificado em duas etapas.


```python
## Criando uma funcao para calcular a media ponderada
mediap <- function(notas, pesos) {
    saida <- numeric(nrow(notas))
    for (i in 1:nrow(notas)) {
        aux <- notas[i, ] * pesos
        saida[i] <- sum(aux)/10
    }
    return(saida)
}

## Confere o resultado
mediap(notas[, c("prova1", "prova2", "prova3")], c(4, 3, 3))
```

```
##  [1] 4.7 4.7 5.4 6.1 7.0 4.9 2.8 6.8 4.1 5.5 2.5 4.1 6.2 5.8 5.9 4.4 4.3
## [18] 5.9 5.5 3.9 6.1 4.5 3.5 3.3 2.7 6.6 5.2 7.8 3.5 7.0
```

```python

## Podemos conferir o nosso cálculo através da função mean() do R
apply(notas[, c("prova1", "prova2", "prova3")], 1, mean)
```

```
##  [1] 4.333 5.000 5.000 6.667 7.000 4.333 3.000 7.000 4.000 5.000 2.667
## [12] 4.000 6.000 5.667 6.000 4.333 4.667 6.333 5.000 4.333 6.333 4.667
## [23] 3.667 3.333 2.667 7.000 5.667 8.000 3.667 7.333
```

