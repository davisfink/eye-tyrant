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
    $('body').on('click', '.spell-list', function() {
        spell_id = $(this).val();
        $.get( "/spells/?spell_id=" + spell_id, function( data ) {
            $( ".spell-container" ).html( $(data).find('#SpellDetail') );
        });
    });
});
