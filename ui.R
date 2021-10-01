#
# Analítica Integrada Salud
#
# Derechos de autor 2021 por MD&CO Consulting Group (NIT 901.119.781-5)
# Copyright (C) 2021 by MD&CO Consulting Group
#
# Este programa es software libre: puede redistribuirlo o modificarlo bajo
# los términos de la licencia Affero General Public License tal cual
# publicada por la Free Software Foundation, sea la versión 3 de la licencia
# o cualquier versión posterior. Este programa se distribuye SIN GARANTÍA
# EXPERSA O IMPLÍCITA, INCLUIDAS LAS DE NO INFRACCIÓN, COMERCIABILIDAD O
# APTITUD PARA UN PROPÓSITO PARTICULAR. Referir a la
# AGPL (http://www.gnu.org/licenses/agpl-3.0.txt) para más detalles.
#


shinyUI(
  function(request) {
  tagList(
    tags$head(
      tags$script(type = "text/javascript", src = "code.js"),
      tags$link(rel = "stylesheet", type = "text/css", href = "style.css"),
      tags$link(
        rel = "stylesheet",
        type = "text/css",
        href = "github-markdown.css")
      ),
    shinydashboardPlus::dashboardPage(
      options = list(sidebarExpandOnHover = TRUE),
      skin = "blue-light",
      shinydashboardPlus::dashboardHeader(
        fixed = TRUE,
        title = tagList(
          span(class = "logo-lg", "Analítica Integrada Salud"),
          img(src = "logo.svg")),
        dropdownMenu(
          icon = icon("info-circle"),
          type = "notifications",
          badgeStatus = "info"
        ),
        controlbarIcon = icon("cogs")),
      sidebar = shinydashboardPlus::dashboardSidebar(
        collapsed = TRUE,
        sidebarMenu(
          menuItem(
            text = "Notas técnicas",
            icon = icon("book-open", lib = "font-awesome"),
            tabName = "notas_tecnicas")
        )
    ),
      controlbar = dashboardControlbar(
        width = 700,
        controlbarMenu(
        )
      ),
      dashboardBody(
  # Modulos -------------------------------------------------------------------
        tabItems(
          tabItem(
            tabName = "notas_tecnicas",
            box(
              width = 6,
              tags$h3("Notas técnicas"),
              jsoneditor_ui("notas_tecnicas")
            ),
            box(
              width = 6,
              tags$h3("Perfiles"),
              jsoneditor_ui("perfiles")
            )
          )
        )
      )
     )
    )
  }
)
