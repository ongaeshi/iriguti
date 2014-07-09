# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
    $('a.check').click (e) ->
        if $(this).attr('data-kind') != 'add'
            link = $(this).parent().prev().children().first()
            $.post('/archive', { item_id: $(this).data('item-id') })
            $(this).attr('data-kind', 'add')
            link.wrap('<del></del>')
        else
            link = $(this).parent().prev().children().children().first()
            $.post('/add', {url: link.attr('href')})
            $(this).removeAttr('data-kind')
            link.unwrap()
        false
