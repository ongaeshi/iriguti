# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
    $('a.check').click (e) ->
        link = $(this).parent().prev().children()
        if !link.is("del")
            $.post('/archive', { item_id: $(this).data('item-id') })
            link.wrap('<del></del>')
        else
            $.post('/add', {url: link.children().attr('href')})
            link.children().unwrap()
        false
