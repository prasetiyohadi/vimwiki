-- links-to-html.lua
function Link(el)
  el.target = el.target .. ".html"
  return el
end
