$(function() {
    $( "#autocomplete" ).autocomplete({
        source: function (request, response) {
            $.get("/get-monster/", {
                search: request.term
            }, function (data) {
                // assuming data is a JavaScript array such as
                // ["one@abc.de", "onf@abc.de","ong@abc.de"]
                // and not a string
                response(data);
            });
        },
        minLength: 3
    });
});
