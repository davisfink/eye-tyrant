$(document).ready(function() {
    $('.monster-search').select2({
        ajax: {
            url: '/monster-search/',
            dataType: 'json'
        },
        minimumInputLength: 2
    });

    $('.spell-search').select2({
        ajax: {
            url: '/spell-search/',
            dataType: 'json'
        },
        minimumInputLength: 2
    });

    $('body').on('change', '.spell-list', function() {
        spell_id = $(this).val();
        $.get( "/spells/?spell_id=" + spell_id, function( data ) {
            $( ".spell-container" ).html( $(data).find('#SpellDetail') );
        });
    });

    $('body').on('change', 'select.condition-list', function() {
        if ($(this).val() != '') {
            $(this).closest('form').submit();
        }
    });

    $('body').on('click', '.condition', function(e) {
        e.preventDefault();
        href = $(this).attr('href');
        data = $(this).data('condition');
        $form = $("<form></form>");
        $form.attr("action", href);
        $form.attr('method', 'POST');
        $form.append("<input type='hidden' value='" + data  + "' name='condition'></input>");
        $('body').append($form);
        $form.submit();
        console.log($form);
    });
});
