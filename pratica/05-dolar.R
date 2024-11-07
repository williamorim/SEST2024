library(xml2)

# URL + parâmetros

url <- ""
params <- list()

# Requisição
res <- httr::POST(
  url,
  body = params,
  encode = "form"
)

# Resposta
html <- read_html(res)

