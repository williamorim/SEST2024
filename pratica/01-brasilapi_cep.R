library(httr)
library(jsonlite)

url_base <- ""
endpoint_cep <- ""

cep <- "01310000"

# Fazer requisição

r_cep <- GET()

# Formatar o conteúdo da resposta

content(r_cep, as = "text")

# Lição de casa

- Pesquisar preço de carros na tabela FIPE via Brasil API.