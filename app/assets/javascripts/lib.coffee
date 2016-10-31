#= require jquery
#= require jquery_ujs
#= require turbolinks

#= require react_ujs

window.React = require 'react'
window.ReactDOM = require 'react-dom'

window.ReactRailsUJS.unmountComponents = (searchSelector)->
  nodes = window.ReactRailsUJS.findDOMNodes(searchSelector)
  for node in nodes
    key = Object.keys(node.firstChild)[0]
    if key
      ReactDOM.unmountComponentAtNode(node)