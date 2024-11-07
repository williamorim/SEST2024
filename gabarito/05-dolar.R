library(xml2)

url <- "https://ptax.bcb.gov.br/ptax_internet/consultaBoletim.do"

params <- list(
  method = "consultarBoletim",
  RadOpcao = "1",
  DATAINI = "20/09/2024",
  DATAFIM = "19/10/2024",
  ChkMoeda = "61"
)

res <- httr::POST(
  url,
  body = params,
  encode = "form"
)

html <- read_html(res)

xml_find_all(html, "//table") |>
  rvest::html_table() |> 
  purrr::pluck(1) |> 
  janitor::clean_names() |> 
  dplyr::select(
    data,
    tipo,
    cotacao_compra = cotacoes_em_real1,
    cotacao_venda = cotacoes_em_real1_2
  ) |> 
  dplyr::slice(-1) |> 
  dplyr::mutate(
    data = lubridate::dmy(data)
  ) |> 
  tidyr::drop_na(data)
