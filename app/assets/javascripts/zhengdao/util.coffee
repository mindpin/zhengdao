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