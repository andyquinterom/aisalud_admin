
# Test para módulo de edicion de JSON
testServer(jsoneditor_server, args = list(json = "{}"), {

  output$jsoneditor

  expect_equal(result(), NULL)

  session$setInputs(save = list(raw = "{}"))
  expect_equal(result(), "{}")
  expect_equal(session$returned(), "{}")

})

