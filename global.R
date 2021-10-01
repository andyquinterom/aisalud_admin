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

# Carga de paquetes y opciones -------------------------------------------------

library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(shinyCache)
library(digest)
library(DBI)
library(RPostgres)
library(dplyr)
library(tidyr)
library(purrr)
library(listviewer)
library(jsonvalidate)
library(lubridate)
library(jsonlite)

source_dir <- function(path) {
  purrr::map(file.path(path, list.files(path)), source)
}

source_dir("R")
source_dir("modules")
# Carga de datos ---------------------------------------------------------------

# Se establece conexión a una instancia de PostgrSQL

conn <- dbConnect(
  RPostgres::Postgres(),
  dbname = Sys.getenv("DATABASE_NAME"),
  user = Sys.getenv("DATABASE_USER"),
  password = Sys.getenv("DATABASE_PW"),
  host = Sys.getenv("DATABASE_HOST"),
  port = Sys.getenv("DATABASE_PORT"),
  bigint = "integer",
  sslmode = "allow")

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

# DT Spanish json
dt_spanish <- "//cdn.datatables.net/plug-ins/1.10.11/i18n/Spanish.json"
