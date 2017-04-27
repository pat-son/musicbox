# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  if namespace.controller is "users" and namespace.action in ["new", "create"]
    console.log "test"
    $('[data-toggle="tooltip"]').tooltip();