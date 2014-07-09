# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
    $('a.check').click (e) ->
        if $(this).attr('data-kind') == 'add'
            $.post(
                '/add'
                { url: $(this).parent().prev().children().children().first().attr('href') }
            );
            $(this).removeAttr('data-kind')
            $(this).parent().prev().children().children().unwrap()
        else
            $.post(
                '/archive'
                { item_id: $(this).data('item-id') }
                (data, textStatus, jqXHR) =>
            );
            $(this).attr('data-kind', 'add')
            $(this).parent().prev().children().wrap('<del></del>')
        false
