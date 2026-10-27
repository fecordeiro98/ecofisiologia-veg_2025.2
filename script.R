# Script para a pratica de estiolacao
# Ecofisiologia vegetal
# Felipe Cordeiro, Felipe Fernandes, Ivone Nascimento, Jaderson Coriolano, Joyce Micaely, Juliana Fonseca, Letícia Gonçalves
# Script 4
# R 4.5.1

# Inicio ------------------------------------------------------------------

## Bibliotecas ----
library(ggplot2)
library(dplyr)

## Importacao dos dados ----
dados <- read.csv('dados.csv', header = T, sep = ',', dec = '.')

### Configuracao dos dados ----
dados <- dados |> mutate(
  Bloco = factor(Bloco),
  Tratamento = factor(Tratamento)
)

#### Conferencia ----
str(dados)

## Separacao ----
luz <- dados |> filter(Tratamento == 'Luz')
sombra <- dados |> filter(Tratamento == 'Sombra')

# Graficos ----------------------------------------------------------------

grafico <- function(coluna_l, coluna_s, titulo, subtitulo, eixo_y) {
  temp <- data.frame(
    tratamento = c('Luz', 'Sombra'),
    media = c(
      mean({{coluna_l}}),
      mean({{coluna_s}})
    ),
    ep = c(
      sd({{coluna_l}}) / sqrt(length({{coluna_l}})),
      sd({{coluna_s}}) / sqrt(length({{coluna_s}}))
    )
  )
  grafico <- ggplot(temp, aes(tratamento, media)) +
    geom_col(fill = c('white', 'black'), colour = 'black') +
    geom_errorbar(aes(
      ymin = media - ep,
      ymax = media + ep
    ), width = 0.2, colour = 'red') +
    labs(
      title = titulo,
      subtitle = subtitulo,
      x = 'Tratamento',
      y = eixo_y
    ) +
    theme_bw()
  ggsave(
    paste0('./gráficos/', titulo, ' - ', subtitulo, '.png'),
    plot = grafico,
    height = 3,
    width = 4,
    dpi = 300,
    scale = 1.25
  )
}

## Hipocotilos ----
grafico(luz$Hipocótilo_F, sombra$Hipocótilo_F, 'Hipocótilo', 'Feijão', 'Centímetros')
grafico(luz$Hipocótilo_L, sombra$Hipocótilo_L, 'Hipocótilo', 'Lentilha', 'Centímetros')

## Raizes ----
grafico(luz$Raiz_F, sombra$Raiz_F, 'Raiz', 'Feijão', 'Centímetros')
grafico(luz$Raiz_L, sombra$Raiz_L, 'Raiz', 'Lentilha', 'Centímetros')

## Areas foliares ----
grafico(luz$ÁreaFol_F, sombra$ÁreaFol_F, 'Área foliar', 'Feijão', 'cm2')
grafico(luz$ÁreaFol_L, sombra$ÁreaFol_L, 'Área foliar', 'Lentilha', 'cm2')

# Analises ----------------------------------------------------------------

## Tratamento ----

### Hipocotilos ----
hipo_f_t <- aov(Hipocótilo_F ~ Tratamento, dados)
hipo_l_t <- aov(Hipocótilo_L ~ Tratamento, dados)

### Raizes ----
raiz_f_t <- aov(Raiz_F ~ Tratamento, dados)
raiz_l_t <- aov(Raiz_L ~ Tratamento, dados)

### Areas foliares ----
afol_f_t <- aov(ÁreaFol_F ~ Tratamento, dados)
afol_l_t <- aov(ÁreaFol_L ~ Tratamento, dados)

### Resultados ----
summary(hipo_f_t)
summary(hipo_l_t)
summary(raiz_f_t)
summary(raiz_l_t)
summary(afol_f_t)
summary(afol_l_t)

## Bloco ----

### Hipocotilos ----
hipo_f_b <- aov(Hipocótilo_F ~ Bloco, dados)
hipo_l_b <- aov(Hipocótilo_L ~ Bloco, dados)

### Raizes ----
raiz_f_b <- aov(Raiz_F ~ Bloco, dados)
raiz_l_b <- aov(Raiz_L ~ Bloco, dados)

### Areas foliares ----
afol_f_b <- aov(ÁreaFol_F ~ Bloco, dados)
afol_l_b <- aov(ÁreaFol_L ~ Bloco, dados)

### Resultados ----
summary(hipo_f_b)
summary(hipo_l_b)
summary(raiz_f_b)
summary(raiz_l_b)
summary(afol_f_b)
summary(afol_l_b)

## Tratamento + Bloco ----

### Hipocotilos ----
hipo_f_tb <- aov(Hipocótilo_F ~ Tratamento + Bloco, dados)
hipo_l_tb <- aov(Hipocótilo_L ~ Tratamento + Bloco, dados)

### Raizes ----
raiz_f_tb <- aov(Raiz_F ~ Tratamento + Bloco, dados)
raiz_l_tb <- aov(Raiz_L ~ Tratamento + Bloco, dados)

### Areas foliares ----
afol_f_tb <- aov(ÁreaFol_F ~ Tratamento + Bloco, dados)
afol_l_tb <- aov(ÁreaFol_L ~ Tratamento + Bloco, dados)

### Resultados ----
summary(hipo_f_tb)
summary(hipo_l_tb)
summary(raiz_f_tb)
summary(raiz_l_tb)
summary(afol_f_tb)
summary(afol_l_tb)
