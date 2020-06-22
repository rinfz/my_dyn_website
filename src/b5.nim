import asynchttpserver, asyncdispatch

import routes

let port = 8080

proc main =
  var server = newAsyncHttpServer()
  defer: server.close()

  waitFor server.serve(Port(port), router)

when isMainModule:
  echo "Listening on port ", port
  main()
