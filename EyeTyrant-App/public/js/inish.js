$(function () {
    $("#SortInitiative").click(function(e) {
        e.preventDefault();
        var sorted_list = SortInitiative();
        var $init_div    = $("#InitiativeList");

        $init_div.empty();
        for (item in sorted_list) {
            if (sorted_list[item]['name'] != "" && sorted_list[item]['inish'] != "") {
                NewInitshDiv(sorted_list[item]['inish'],sorted_list[item]['name']);
            }
        }
    });
    $("#NewEntry").click(function(e) {
        NewInitshDiv("","");
    });
});

function SortInitiative() {
    var inish_list = [];
    $(".entry").each(function(e, el) {
        var combatant = {
            name: $(el).find(".name").val(),
            inish: $(el).find(".inish").val()
        }
        inish_list.push(combatant);
    });
    return SortOnInish(inish_list);
}

function SortOnInish(unsorted) {
    var sorted = unsorted.slice(0).sort(function(a, b) {
        return a.inish - b.inish;
    });

    var keys = [];
    for (var i = 0, len = sorted.length; i < len; ++i) {
        keys[i] = sorted[i];
    }

    return keys;
}
function sortNumber(a,b) {
    return a > b ? 1 : a < b ? -1 : 0;
}

function NewInitshDiv(new_inish, new_name) {
    $("#InitiativeList").append(
        "<div class='entry'>" +
        "<input class='inish' value=" + new_inish + ">" +
        "<input class='name' value=" + new_name + ">" +
        "</div>");
}
