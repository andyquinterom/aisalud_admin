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

shinyServer(function(input, output, session) {

  # Edición de notas técnicas y perfiles ---------------------------------------

  table_list <- dbListTables(conn)

  if ("perfiles_notas_tecnicas_v2" %in% table_list) {
    string_notas_tecnicas <- tbl(conn, "perfiles_notas_tecnicas_v2") %>%
      pull(notas_tecnicas)
  } else {
    string_notas_tecnica <- "{}"
  }

  if ("perfiles_usuario" %in% table_list) {
    string_perfiles <- tbl(conn, "perfiles_usuario") %>%
      pull(perfiles)
  } else {
    string_perfiles <- "{}"
  }

  json_notastecnicas <- jsoneditor_server(
    id = "notas_tecnicas",
    json = string_notas_tecnicas,
    schema = read_json("json_schemas/nota_tecnica.json")
  )

  json_perfiles <- jsoneditor_server(
    id = "perfiles",
    json = string_perfiles,
    schema = read_json("json_schemas/perfiles.json")
  )

  observe({
    dbExecute(
      conn = conn,
      sqlInterpolate(
        conn,
        sql = "UPDATE perfiles_notas_tecnicas_v2
              SET notas_tecnicas = ?json;",
        json = json_notastecnicas()
      )
    )
    showNotification("Notas técnicas actualizadas")
  }) %>%
    bindEvent(json_notastecnicas())

  observe({
    dbExecute(
      conn = conn,
      sqlInterpolate(
        conn,
        sql = "UPDATE perfiles_usuario
              SET perfiles = ?json;",
        json = json_perfiles()
      )
    )
    showNotification("Perfiles actualizados")
  }) %>%
    bindEvent(json_perfiles())

  # Fin edición de perfiles y notas técnicas -----------------------------------

})
