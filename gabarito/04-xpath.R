library(xml2)

# Ler o HTML
html <- read_html("scripts/html_exemplo.html")

# Coletar todos os nodes com a tag <p>
xml_find_all(html, "/html/body/p")
xml_find_all(html, "//p")

nodes <- xml_find_all(html, "//p")

primeiro <- xml_find_first(html, "//p")


# Extrair o texto contido em cada um dos nodes
text <- xml_text(nodes)
text

# Extrai o atributo style contido em cada note
xml_attr(nodes, "style")
