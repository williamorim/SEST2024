library(xml2)

# URL + parâmetros

url <- "https://ptax.bcb.gov.br/ptax_internet/consultaBoletim.do"
params <- list(
  method = "consultarBoletim",
  RadOpcao = 1,
  DATAINI = "08/10/2024",
  DATAFIM = "07/11/2024",
  ChkMoeda = 61
)

# Requisição
res <- httr::POST(
  url,
  body = params,
  encode = "form"
)
res

# Resposta
html <- read_html(res)

# install.packages("rvest")


html |> 
  xml_find_all("//table") |> 
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
