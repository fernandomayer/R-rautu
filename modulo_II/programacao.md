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
## Analisa a estrutura
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

```r

## Cria uma nova coluna para armazenar os resultados das médias
notas$media <- 0
## Estrutura de repetição
for (i in 1:30) {
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
##      nome prova1 prova2 prova3 media mediap
## 1 Aluno_1      8      4      1 4.333    4.7
## 2 Aluno_2      2      7      6 5.000    4.7
## 3 Aluno_3      9      2      4 5.000    5.4
## 4 Aluno_4      1     10      9 6.667    6.1
## 5 Aluno_5      7      6      8 7.000    7.0
## 6 Aluno_6     10      0      3 4.333    4.9
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

