$(document).ready(function() {
    $('.monster-search').select2({
        ajax: {
            url: '/monster-search/',
            dataType: 'json'
        }
    });
});
