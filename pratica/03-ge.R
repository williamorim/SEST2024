library(httr)
library(jsonlite)

# install.packages("glue")
# install.packages("dplyr")

rodada <- 1
url <- glue::glue(
  "https://api.globoesporte.globo.com/tabela/d1a37fa4-e948-43a6-ba53-ab24ab3a45b1/fase/fase-unica-campeonato-brasileiro-2024/rodada/{rodada}/jogos/"
)

res <- GET(url)
res

res |> 
  content(as = "text") |> 
  fromJSON() |> 
  tibble::as_tibble() |> 
  dplyr::mutate(
    time_mandante = equipes$mandante$nome_popular,
    time_visitante = equipes$visitante$nome_popular
  ) |> 
  dplyr::select(
    data_realizacao,
    hora_realizacao,
    time_mandante,
    gols_mandante = placar_oficial_mandante,
    time_visitante,
    gols_visitante = placar_oficial_visitante,
  ) 




