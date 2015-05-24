$(function() {
    $( ".autocomplete" ).autocomplete({
        source: "/autocomplete-monster/",
        minLength: 3,
        select: function (event, ui) {
            var monster_id = ui.item.value;
            $("#FoundResult").empty();
            $.get("/get-monster/?id=" + monster_id, function (data) {
               var monster = $(data).find("#Result");
               $("#FoundResult").append(monster);
            });
        }
    });
    $( ".autocomplete-spell" ).autocomplete({
        source: "/autocomplete-spell/",
        minLength: 3,
        select: function (event, ui) {
            var spell_id = ui.item.value;
            $("#FoundResult").empty();
            $.get("/get-spell/?id=" + spell_id, function (data) {
               var spell = $(data).find("#Result");
               $("#FoundResult").append(spell);
            });
        }
    });
});
