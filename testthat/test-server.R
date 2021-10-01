# Test para módulo de edicion de JSON
testServer(
  jsoneditor_server,
  args = list(json = "{}", schema = read_json("../json_schemas/example.json")),
  expr = {

    output$jsoneditor

    # Valida que el valor inicial sea NULL
    expect_equal(result(), NULL)

    # Valida un JSON vacio
    session$setInputs(save = list(raw = "{}"))
    expect_equal(result(), "{}")

    # Valida que devuelva NULL un json invalido
    session$setInputs(save = list(raw = "INVALID JSON"))
    expect_equal(session$returned(), NULL)

    # Valida con schema
    valid_json <- read_file("../json_schemas/example_valid.json")
    session$setInputs(
      save = list(raw = valid_json)
    )
    expect_equal(session$returned(), valid_json)

    # Valida errores con schema
    session$setInputs(
      save = list(raw = read_file("../json_schemas/example_invalid.json"))
    )
    expect_equal(session$returned(), NULL)

})

