# Descrição do Script R para Análise de Estiolação

Este script em R foi desenvolvido para analisar dados de um experimento de ecofisiologia vegetal sobre estiolação. O objetivo é comparar o desenvolvimento de plantas de feijão e lentilha crescidas sob duas condições distintas: luz e sombra. O código realiza a importação e tratamento dos dados, gera gráficos comparativos e executa análises estatísticas (ANOVA) para verificar os efeitos dos tratamentos.

**Autores:** Felipe Cordeiro, Felipe Fernandes, Ivone Nascimento, Jaderson Coriolano, Joyce Micaely, Juliana Fonseca, Letícia Gonçalves.
**Versão:** 4

## Estrutura do Código

O script é organizado em três seções principais: preparação dos dados, visualização (gráficos) e análise estatística.

### 1. Início e Configuração

Nesta primeira parte, o ambiente de análise é preparado.

- **Bibliotecas:** Carrega duas bibliotecas essenciais do R:
  - `ggplot2`: Para a criação de gráficos elegantes e complexos.
  - `dplyr`: Para a manipulação e transformação de dados de forma intuitiva.

- **Importação e Tratamento dos Dados:**
  - `read.csv()`: Importa os dados de um arquivo chamado `dados.csv`.
  - `mutate()`: Realiza modificações no conjunto de dados:
    - As colunas `Bloco` e `Tratamento` são convertidas para o tipo `factor`, que é ideal para variáveis categóricas em análises estatísticas.
    - `across()`: Uma função é aplicada a todas as colunas numéricas para substituir valores ausentes (`NA`) por `0`.
  - `str(dados)`: Exibe a estrutura do data frame para conferência dos tipos de dados.

- **Separação dos Dados:**
  - `filter()`: O conjunto de dados principal é dividido em dois subconjuntos para facilitar a criação dos gráficos: `luz` (contendo apenas os dados do tratamento 'Luz') e `sombra` (com os dados do tratamento 'Sombra').

### 2. Geração de Gráficos

Esta seção é dedicada à visualização dos resultados.

- **Função `gráfico()`:** Uma função personalizada foi criada para automatizar a geração de gráficos. Esta função:
  - Recebe como entrada as colunas dos tratamentos luz e sombra, além de textos para título, subtítulo e eixo Y.
  - Calcula a **média** e o **erro padrão (ep)** para cada tratamento.
  - Utiliza o `ggplot` para criar um gráfico de colunas (`geom_col`) com barras de erro (`geom_errorbar`), permitindo uma visualização clara da variação dos dados.
  - Salva automaticamente cada gráfico gerado como um arquivo **PNG** na pasta `./gráficos/`, com o nome definido pelo título e subtítulo.

- **Execução:** A função `gráfico()` é chamada seis vezes para gerar gráficos comparativos para:
  - Comprimento do **Hipocótilo** (Feijão e Lentilha).
  - Comprimento da **Raiz** (Feijão e Lentilha).
  - **Área Foliar** (Feijão e Lentilha).

### 3. Análises Estatísticas

A última seção do script foca na análise estatística dos dados usando a **Análise de Variância (ANOVA)**, com a função `aov()`.

- **Modelos Testados:** Três tipos de modelos de ANOVA são aplicados para cada variável (hipocótilo, raiz e área foliar):
  1.  **Efeito do Tratamento:** Testa se há diferença significativa entre os tratamentos 'Luz' e 'Sombra' (`variavel ~ Tratamento`).
  2.  **Efeito do Bloco:** Testa se o bloco experimental teve alguma influência nos resultados (`variavel ~ Bloco`).
  3.  **Efeito Combinado:** Analisa a influência conjunta do tratamento e do bloco (`variavel ~ Tratamento + Bloco`).

- **Resultados:** Ao final de cada bloco de análise, a função `summary()` é chamada para exibir os resultados detalhados de cada modelo de ANOVA (como o valor-p, estatística F, etc.), que permitem concluir se os efeitos testados são estatisticamente significativos.

## Como Utilizar o Script

1.  **Pré-requisitos:** É necessário ter o R e o RStudio (ou outro editor de R) instalados, além das bibliotecas `ggplot2` e `dplyr`.
2.  **Arquivo de Dados:** Um arquivo chamado `dados.csv` deve estar localizado no mesmo diretório do script.
3.  **Diretório de Gráficos:** É preciso criar uma pasta chamada `gráficos` no mesmo diretório para que os gráficos possam ser salvos.
4.  **Execução:** Basta executar o script por completo em um ambiente R. Os resultados das análises estatísticas serão exibidos no console e os gráficos serão salvos na pasta correspondente.

Texto gerado por inteligência artificial
