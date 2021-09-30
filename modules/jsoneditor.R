jsoneditor_ui <- function(id) {
  ns <- NS(id)

  jsoneditOutput(
    outputId = ns("jsoneditor"),
    height = "630px",
    width = "100%"
  )

}

jsoneditor_server <- function(id, json, ...) {

  ns <- NS(id)

  moduleServer(
    id = id,
    module = function(input, output, session) {

      output$jsoneditor <- renderJsonedit({
        jsonedit(
          json,
          language = "es",
          languages = "es",
          enableTransform = FALSE,
          guardar = ns("save"),
          ...
        )
      })

      result <- reactive({
        input$save$raw
      })

      return(result)
    }
  )

}

