round <- stringr::str_pad(20, 2, "left", "0")

url <- glue::glue(
  "https://api.globoesporte.globo.com/tabela/d1a37fa4-e948-43a6-ba53-ab24ab3a45b1/fase/fase-unica-campeonato-brasileiro-2024/rodada/{round}/jogos/"
)

res <- httr::GET(url)

res |>
  httr::content(type = "text/json", encoding = "latin1") |>
  jsonlite::fromJSON() |>
  janitor::clean_names() |>
  tibble::as_tibble() |>
    dplyr::mutate(
      dplyr::across(
        dplyr::starts_with("placar_oficial"),
        ~ .x |> as.character() |> tidyr::replace_na("")
      ),
      season = 2024,
      date = as.Date(data_realizacao),
      home = equipes$mandante$nome_popular,
      score = paste(
        placar_oficial_mandante,
        placar_oficial_visitante,
        sep = "x"
      ),
      away = equipes$visitante$nome_popular,
    ) |>
    dplyr::select(
      season,
      date,
      home,
      score,
      away
    )
