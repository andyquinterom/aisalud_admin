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

      args <- list(...)

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
        if (!is.null(input$save$raw)) {
          validado <- jsonlite::validate(
            as.character(input$save$raw)
          )
          if (!is.null(args[["schema"]])) {
            tryCatch(
              expr = {
                validado <- json_validate(
                  json = input$save$raw,
                  schema = toJSON(args[["schema"]])
                ) %>%
                  append(validado)
              },
              error = function(e) {
                return(FALSE)
              }
            )
          }
          if (all(validado)) return(input$save$raw)
          showNotification(
            "No se ha guardado, JSON invalido.",
            type = "error"
          )
        }
        return(NULL)
      })

      return(result)
    }
  )

}

