import templates
export Page, pageNotFound, render, newPage

proc home*(): Page =
  "Hello, from views!".newPage

proc login*(): Page =
  "A theoretical login page?!".newPage
