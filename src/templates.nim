import httpcore
import htmlgen

type
  Page* = object
    content*: string
    statusCode*: HttpCode
    isStatic*: bool

proc newPage*(content: string; statusCode: HttpCode = Http200; isStatic: bool = false): Page =
  Page(content : content, statusCode : statusCode, isStatic : isStatic)

proc pageNotFound*(): Page =
  newPage("Page not found", Http404)

proc render*(page: Page): string =
  if page.isStatic:
    return page.content

  "<!doctype html>" & html(
    lang = "en",

    # start head section
    head(
      title("Barely Laughing"),
      meta(
        `http-equiv` = "content-type",
        content = "text/html",
        charset = "UTF-8",
      ),
      meta(
        name = "viewport",
        content = "width=device-width, initial-scale=1",
      ),
      link(
        href = "/css/style.css",
        rel = "stylesheet",
        `type` = "text/css",
      ),
      link(
        rel = "icon",
        `type` = "image/png",
        href = "/images/favicon.png",
      ),
    ),
    # end head section

    # start body section
    body(
      header(
        h1("b5.re"),
      ),
      p(page.content),
    ),
    # end body section
  )
