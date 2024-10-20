library(xml2)

url <- "https://pt.wikipedia.org/wiki/Jogos_Ol%C3%ADmpicos_de_Ver%C3%A3o_de_2024"

html <- read_html(url)

nodes <- xml_find_all(html, "//table[@class='wikitable']")

tab_2024 <- nodes |>
  rvest::html_table() |>
  purrr::keep(\(x) "Ordem" %in% names(x)) |>
  purrr::pluck(1) |>
  janitor::clean_names() |>
  dplyr::rename(
    pais = pais_vde,
    qtd_ouro = x,
    qtd_prata = x_2,
    qtd_bronze = x_3,
    qtd_total = x_4,
    ordem_por_total = ordempor_total
  ) |>
  dplyr::filter(as.numeric(ordem) <= 10)


# Iterar

anos <- seq(2008, 2024, 4)

pegar_tab_medalhas <- function(ano) {
  url <- glue::glue("https://pt.wikipedia.org/wiki/Jogos_Ol%C3%ADmpicos_de_Ver%C3%A3o_de_{ano}")

  html <- read_html(url)

  nodes <- xml_find_all(html, "//table[@class='wikitable']")

  nodes |>
    rvest::html_table() |>
    purrr::keep(\(x) "Ordem" %in% names(x)) |>
    purrr::pluck(1) |>
    janitor::clean_names() |>
    dplyr::select(
      ordem,
      pais = dplyr::contains("pais"),
      qtd_ouro = x,
      qtd_prata = x_2,
      qtd_bronze = x_3,
      qtd_total = x_4
    ) |>
    dplyr::filter(as.numeric(ordem) <= 10 | pais == "BRA Brasil") |> 
    dplyr::mutate(
      ano = ano,
      dplyr::across(
        dplyr::starts_with("qtd"),
        as.numeric
      )
    )
}

tab <- purrr::map(anos, pegar_tab_medalhas) |> 
  purrr::list_rbind()

tab |> 
  dplyr::filter(pais == "BRA Brasil") |> 
  ggplot2::ggplot(ggplot2::aes(x = ano, y = qtd_total)) +
  ggplot2::geom_col(fill = "gold", color = "black") +
  ggplot2::theme_minimal()

