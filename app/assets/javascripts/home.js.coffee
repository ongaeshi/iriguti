# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
    $('a.check').click (e) ->
        $.post(
            '/archive'
            { item_id: $(this).data('item-id') }
        );
        $(this).parent().prev().children().wrap('<del></del>')
        false
