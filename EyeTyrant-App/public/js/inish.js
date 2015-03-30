$(function () {
    $("#SortInitiative").click(function(e) {
        e.preventDefault();
        var sorted_list = SortInitiative();
        var $init_div    = $("#InitiativeList");

        $init_div.empty();
        for (item = sorted_list.length -1; item >= 0; item--) {
        //for (item in sorted_list) {
        console.log(item);
            if (sorted_list[item]['name'] != "" || sorted_list[item]['inish'] != "") {
                NewInitshDiv(sorted_list[item]['inish'],sorted_list[item]['name'], "disabled");
            }
        }
    });

    $("#NewEntry").click(function(e) {
        NewInitshDiv("","","");
    });

    $("#InitiativeList").on( "click", '.remove', function(e) {
        e.preventDefault();
        $(this).parent().remove();
    });

    $("#InitiativeList").on( "click", '.update_damage', function(e) {
        e.preventDefault();
        var current_damage = $(this).parent().find('.damage').val();
        var new_damage = $(this).parent().find('.new_damage').val();
        updated_damage = UpdateDamage(current_damage, new_damage);
        $(this).parent().find('.damage').val(updated_damage);
        $(this).parent().find('.new_damage').val('');
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

function NewInitshDiv(new_inish, new_name, status) {
    $("#InitiativeList").append(
        "<div class='entry'>" +
        "<input class='inish' value='" + new_inish + "'>" +
        "<input class='name' value='" + new_name + "'" + status + ">" +
        "<input class='damage' value='0' tabindex='-1'>"+
        "<input class='new_damage' value='' tabindex='-1'>" +
        "<a href=''#'' class='update_damage'>Update<a>" +
        "<a href='#' class='remove'>X</a>" +
        "</div>");
}

function UpdateDamage(current_damage, new_damage) {
    if (new_damage != '') {
        return parseInt(current_damage) + parseInt(new_damage);
    } else {
        return current_damage;
    }
}
