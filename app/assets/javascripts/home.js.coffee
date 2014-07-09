# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
    $('a.check').click (e) ->
        self = $(this)
        # console.log { item: $(this).attr('itemid') }
        $.post(
            '/archive'
            { item_id: $(this).attr('itemid') }
            (data, textStatus, jqXHR) ->
                self.parent().prev().children().wrap('<del></del>')
        );
        # $(this).parent().prev().children().wrap('<del></del>')
        false
