window.get_page_name = ->
  page = location.href.split('/demo/').pop()
  name = page.split('.html')[0]

window.get_page_prefix_name = ->
  name = window.get_page_name()
  prefix_name = name.split('-')[0]

if typeof Array.isArray is not 'function'
  Array.isArray = (arr)->
    Object.prototype.toString.call(arr) is '[object Array]'

window.ClassName = class
  constructor: (@hash)->
  toString: ->
    arr = []
    for key, value of @hash
      arr.push key if value
    arr.join(' ')