$(document).ready(function() {
    $('.monster-search').select2({
        ajax: {
            url: '/monster-search/',
            dataType: 'json'
        },
        minimumInputLength: 2,
        allowDuplicates: true
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

    $('body').on('click', 'a.condition-icon', function(e) {
        e.preventDefault();
        href = $(this).attr('href');
        data = $(this).data('condition');
        $form = $("<form></form>");
        $form.attr("action", href);
        $form.attr('method', 'POST');
        $form.append("<input type='hidden' value='" + data  + "' name='condition'></input>");
        $('body').append($form);
        $form.submit();
    });

    $('.condition-icon').hover(
        function() {
        condition = $(this)
        id = $(this).data('condition');
        descriptor = $("#Conditions").find('[data-id=' + id + ']');
        descriptor.show();
        descriptor.offset(
            {top:condition.offset().top + 35, left:condition.offset().left + 5}
        );
        descriptor.css({opacity: 1, 'z-index': 9999})
    }, function() {
        id = $(this).data('condition');
        descriptor = $("#Conditions").find('[data-id=' + id + ']');
        descriptor.css({opacity: 0})
        descriptor.hide(150);
    });

    $('body').on('click', 'a.remove-character', function(e) {
        e.preventDefault();
        href = $(this).attr('href');
        data = $(this).data('participant_id');
        $form = $("<form></form>");
        $form.attr("action", href);
        $form.attr('method', 'POST');
        $form.append("<input type='hidden' value='" + data  + "' name='participant_id'></input>");
        $('body').append($form);
        $form.submit();
    });

});
