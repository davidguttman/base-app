router       = require 'directify'
routingTable = require './router'

$(document).ready ->
  router routingTable, $('#container')
  if window.location.hash is ''
    window.location.hash = '/'