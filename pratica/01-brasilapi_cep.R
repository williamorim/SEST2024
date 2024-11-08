library(httr)
library(jsonlite)

# install.packages(c("httr", "jsonlite"))

url_base <- "https://brasilapi.com.br/api"
endpoint_cep <- "/cep/v2/"

cep <- "01310000"

url <- paste0(url_base, endpoint_cep, cep)

# Fazer requisição

resposta_cep <- GET(url)
resposta_cep

# Formatar o conteúdo da resposta

content(resposta_cep, as = "text")

# install.package("purrr")

resposta_cep |> 
  content(as = "text") |> 
  fromJSON() |> 
  # purrr::discard_at("location") |> 
  as.data.frame()

pegar_cep <- function(cep) {
  Sys.sleep(1)
  url_base <- "https://brasilapi.com.br/api"
  endpoint_cep <- "/cep/v2/"
  url <- paste0(url_base, endpoint_cep, cep)

  resposta_cep <- GET(url)

  resposta_cep |> 
    content(as = "text") |> 
    fromJSON() |> 
    as.data.frame() |> 
    tibble::as_tibble()
}

pegar_cep("01310000")

lista_ceps <- c(
  "01310000",
  "01310000",
  "01310000",
  "01310000",
  '01310000'
)

lista_tabelas <- purrr::map(
  lista_ceps,
  pegar_cep
)

lista_tabelas |> dplyr::bind_rows()

# Lição de casa

# - Pesquisar preço de carros na tabela FIPE via Brasil API.