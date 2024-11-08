library(xml2)

# install.packages("xml2")

# Ler o HTML
html <- read_html("pratica/html_exemplo.html")

# Coletar todos os nodes com a tag <p>
# com xml_find_all()

nodes <- xml_find_all(html, xpath = "/html/body/p")
xml_find_all(html, "//p")

# Apenas o primeiro com xml_find_first()
xml_find_first(html, xpath = "/html/body/p")

# Extrair o texto contido em cada um dos nodes
# com xml_text()

textos <- xml_text(nodes)

# Extrai o atributo style contido em cada note
# com xml_attr
atributos <- xml_attr(nodes, attr = "style")

textos[atributos == "color: blue;"]

