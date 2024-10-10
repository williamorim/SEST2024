library(httr)
library(jsonlite)

url_base <- "https://brasilapi.com.br/api"
endpoint_cep <- "/cep/v2/"

cep <- "01525001"

url_cep <- paste0(url_base, endpoint_cep, cep)

r_cep <- GET(url_cep)

# obter os resultados a partir da chamada

content(r_cep, as = "text") |> 
  fromJSON() |> 
  purrr::discard_at("location") |> 
  tibble::as_tibble()


# Lição de casa

- Pesquisar preço de carros na tabela FIPE via Brasil API.