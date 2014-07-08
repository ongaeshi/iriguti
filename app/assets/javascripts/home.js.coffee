# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
    $('a.check').click (e) ->
        console.log $(this).attr("itemid")
        $(this).parent().prev().children().wrap('<del></del>')
        false
