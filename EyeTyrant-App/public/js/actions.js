$(function() {
    $('.entry').first().addClass('active');

    $('body').on('click', '#next', function(e){
        var $current = $('.entry').first();
        $current.slideUp().removeClass('active');
        setTimeout(function(){
            $current.appendTo('#InitiativeList');
        },250);
        setTimeout(function(){
            $current.slideDown();
            $('.entry').first().addClass('active');
        },500);
    });

    $('body').on('submit', 'form', function(e){
        e.preventDefault();
        var id_to_find = $(this).parent().data('id');
        var $participant_to_remove = $('div[data-id="' + id_to_find + '"]');
        $.post( $(this).attr('action'), $(this).serialize() )
        .done(function(data){
            var updated_item = $(data).find('div[data-id="' + id_to_find + '"]');
            $participant_to_remove.after(updated_item);
            $participant_to_remove.remove();
        });
    });
});
