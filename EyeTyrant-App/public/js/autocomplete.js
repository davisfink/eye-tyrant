$(function() {
    $( "#autocomplete" ).autocomplete({
        source: function (request, response) {
            $.get("/autocomplete-monster/", {
                search: request.term
            }, function (data) {
                response(data);
            });
        },
        minLength: 3
    });
});
