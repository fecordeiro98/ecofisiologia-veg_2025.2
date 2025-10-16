#' Script para a prática de estiolação
#' Ecofisiologia vegetal
#' Felipe Cordeiro, Felipe Fernandes, Ivone Nascimento, Jaderson Coriolano, Joyce Micaely, Juliana Fonseca, Letícia Gonçalves
#' Versão 4

# Início ------------------------------------------------------------------

## Bibliotecas ####
library(ggplot2)
library(dplyr)

## Importação dos dados ####
dados <- read.csv('./dados.csv', T, ',', dec = '.')

### Configuração dos dados ####
dados <- dados |> mutate(
  Bloco = factor(Bloco),
  Tratamento = factor(Tratamento),
  across(
    .cols = where(is.numeric),
    .fns = ~ ifelse(is.na(.), 0, .)
  )
)

#### Conferência ####
str(dados)

## Separação ####
luz <- dados |> 
  filter(Tratamento == 'Luz')
sombra <- dados |> 
  filter(Tratamento == 'Sombra')

# Gráficos ----------------------------------------------------------------

gráfico <- function(colunaL, colunaS, título, subtítulo, eixoY) {
  temp <- data.frame(
    tratamento = c('Luz', 'Sombra'),
    média = c(
      mean({{colunaL}}),
      mean({{colunaS}})
    ),
    ep = c(
      sd({{colunaL}}) / sqrt(length({{colunaL}})),
      sd({{colunaS}}) / sqrt(length({{colunaS}}))
    )
  )
  grafico <- ggplot(temp, aes(tratamento, média)) +
    geom_col(fill = c('white', 'black'), colour = 'black') +
    geom_errorbar(aes(
      ymin = média - ep,
      ymax = média + ep
    ), width = 0.2, colour = 'red') +
    labs(
      title = título,
      subtitle = subtítulo,
      x = 'Tratamento',
      y = eixoY
    ) +
    theme_bw()
  ggsave(
    paste0('./gráficos/', título, ' - ', subtítulo, '.png'),
    plot = grafico,
    height = 3,
    width = 4,
    dpi = 300,
    scale = 1.25
  )
}

## Hipocótilos ####
gráfico(luz$Hipocótilo_F, sombra$Hipocótilo_F, 'Hipocótilo', 'Feijão', 'Centímetros')
gráfico(luz$Hipocótilo_L, sombra$Hipocótilo_L, 'Hipocótilo', 'Lentilha', 'Centímetros')

## Raízes ####
gráfico(luz$Raiz_F, sombra$Raiz_F, 'Raiz', 'Feijão', 'Centímetros')
gráfico(luz$Raiz_L, sombra$Raiz_L, 'Raiz', 'Lentilha', 'Centímetros')

## Áreas foliares ####
gráfico(luz$ÁreaFol_F, sombra$ÁreaFol_F, 'Área foliar', 'Feijão', 'cm2')
gráfico(luz$ÁreaFol_L, sombra$ÁreaFol_L, 'Área foliar', 'Lentilha', 'cm2')

# Análises ----------------------------------------------------------------

## Tratamento ####

### Hipocótilos ####
hipoFT <- aov(Hipocótilo_F ~ Tratamento, dados)
hipoLT <- aov(Hipocótilo_L ~ Tratamento, dados)

### Raízes ####
raizFT <- aov(Raiz_F ~ Tratamento, dados)
raizLT <- aov(Raiz_L ~ Tratamento, dados)

### Áreas foliares ####
afolFT <- aov(ÁreaFol_F ~ Tratamento, dados)
afolLT <- aov(ÁreaFol_L ~ Tratamento, dados)

### Resultados ####
summary(hipoFT)
summary(hipoLT)
summary(raizFT)
summary(raizLT)
summary(afolFT)
summary(afolLT)

## Bloco ####

### Hipocótilos ####
hipoFB <- aov(Hipocótilo_F ~ Bloco, dados)
hipoLB <- aov(Hipocótilo_L ~ Bloco, dados)

### Raízes ####
raizFB <- aov(Raiz_F ~ Bloco, dados)
raizLB <- aov(Raiz_L ~ Bloco, dados)

### Áreas foliares ####
afolFB <- aov(ÁreaFol_F ~ Bloco, dados)
afolLB <- aov(ÁreaFol_L ~ Bloco, dados)

### Resultados ####
summary(hipoFB)
summary(hipoLB)
summary(raizFB)
summary(raizLB)
summary(afolFB)
summary(afolLB)

## Tratamento + Bloco ####

### Hipocótilos ####
hTB_f <- aov(Hipocótilo_F ~ Tratamento + Bloco, dados)
hTB_l <- aov(Hipocótilo_L ~ Tratamento + Bloco, dados)

### Raízes ####
rTB_f <- aov(Raiz_F ~ Tratamento + Bloco, dados)
rTB_l <- aov(Raiz_L ~ Tratamento + Bloco, dados)

### Áreas foliares ####
aTB_f <- aov(ÁreaFol_F ~ Tratamento + Bloco, dados)
aTB_l <- aov(ÁreaFol_L ~ Tratamento + Bloco, dados)

### Resultados ####
summary(hTB_f)
summary(hTB_l)
summary(rTB_f)
summary(rTB_l)
summary(aTB_f)
summary(aTB_l)
