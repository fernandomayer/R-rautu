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


```r

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

```r
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

```r
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

```r
for (i in 1:30) {
    print(notas[i, c("prova1", "prova2", "prova3")])
}
```



```r
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


```r
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


```r
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

```r

## A única diferença é que aqui precisamos transformar cada linha em um vetor
## de números com as.numeric(), pois
notas[1, provas]
```

```
##   prova1 prova2 prova3
## 1      8      4      1
```

```r
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

```r
help.search("coefficient of variation")
```

não retorna nenhuma função (dos pacotes básicos) para fazer esse
cálculo. O motivo é simples: como é uma conta simples de fazer não há
necessidade de se criar uma função extra dentro dos pacotes. No entanto,
nós podemos criar uma função que calcule o CV, e usá-la para o nosso
propósito


```r
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

Podemos agora inserir pesos para as provas: prova 1 = 4, prova 2 = 3,
prova 3 = 3.


```r
## Cria uma nova coluna para armazenar os resultados das médias ponderadas
notas$mediap <- 0
## Estrutura de repetição
for (i in 1:30) {
    pesos <- notas[i, c("prova1", "prova2", "prova3")] * c(4, 3, 3)
    notas$mediap[i] <- sum(pesos)/10
}
## Confere os resultados
head(notas)
```

```
##      nome prova1 prova2 prova3 media media2 media3 mediap
## 1 Aluno_1      8      4      1 4.333  4.333  4.333    4.7
## 2 Aluno_2      2      7      6 5.000  5.000  5.000    4.7
## 3 Aluno_3      9      2      4 5.000  5.000  5.000    5.4
## 4 Aluno_4      1     10      9 6.667  6.667  6.667    6.1
## 5 Aluno_5      7      6      8 7.000  7.000  7.000    7.0
## 6 Aluno_6     10      0      3 4.333  4.333  4.333    4.9
```


## Estrutura de seleção `if()`

-   Adicionando a condição do aluno de acordo com a nota.


```r
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


```r
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

```r

## Podemos conferir o nosso cálculo através da função mean() do R
apply(notas[, c("prova1", "prova2", "prova3")], 1, mean)
```

```
##  [1] 4.333 5.000 5.000 6.667 7.000 4.333 3.000 7.000 4.000 5.000 2.667
## [12] 4.000 6.000 5.667 6.000 4.333 4.667 6.333 5.000 4.333 6.333 4.667
## [23] 3.667 3.333 2.667 7.000 5.667 8.000 3.667 7.333
```

