import asynchttpserver, asyncdispatch
import tables
import os

import views

const
  urls = toTable({
    "/": home,
    "/login": login,
  })

  staticExtensions = [
    ".css", ".png",
  ]

proc isStatic(path: string): bool =
  var (_, _, ext) = path.splitFile
  return ext in staticExtensions

proc routerInner(req: Request): Page =
  let path = req.url.path

  if path.isStatic:
    let filePath = "public" & path
    if existsFile(filePath):
      result = newPage(readFile(filePath), isStatic = true)
    else:
      result = pageNotFound()
  elif not urls.hasKey(path):
    result = pageNotFound()
  else:
    result = urls[req.url.path]()

proc router*(req: Request) {.async.} =
  var page: Page

  try:
    page = routerInner(req)
  except:
    page = Page(content : "Something went wrong!", statusCode : Http500)

  await req.respond(page.statusCode, page.render)
