$(function() {
    $( ".autocomplete" ).autocomplete({
        source: "/autocomplete-monster/",
        minLength: 3,
        select: function (event, ui) {
            var monster_id = ui.item.value;
            $("#FoundMonster").empty();
            $.get("/get-monster/?id=" + monster_id, function (data) {
               var monster = $(data).find("#Result");
               $("#FoundMonster").append(monster);
            });
        }
    });
});
