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

  # Edición de notas técnicas y perfiles

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
    dbWriteTable(
      conn,
      "perfiles_notas_tecnicas",
      data.frame(notas_tecnicas = json_notastecnicas()),
      overwrite = TRUE
    )
    showNotification("Notas técnicas actualizadas")
  }) %>%
    bindEvent(json_notastecnicas())

  observe({
    dbWriteTable(
      conn,
      "perfiles_usuario",
      data.frame(perfiles = json_perfiles()),
      overwrite = TRUE
    )
    showNotification("Perfiles actualizados")
  }) %>%
    bindEvent(json_perfiles())

})
