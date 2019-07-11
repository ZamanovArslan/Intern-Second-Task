$(document).ready(function () {
    let d = new Date();
    let strDate = d.getFullYear() + "/" + (d.getMonth() + 1) + "/" + d.getDate();
    getEventsByDate(strDate);
    new niceDatePicker({
        dom: document.getElementById('calendar1-wrapper1'),
        onClickDate: function (date) {
            getEventsByDate(date);
        },
        mode: 'en'
    });

    function getEventsByDate(date) {
        $(".selected-day-events .title").text(date);
        $.ajax({
            statusCode: {
                401: function () {
                    alert("Войдите или зарегистрируйтесь");
                }
            },
            method: "GET",
            dataType: "json",
            url: "/events",
            data: {date_event: date},
            beforeSend: function () {
                $(".selected-day-events .events .event").remove();
            },
        })
            .done(function (events) {
                console.log(events);
                printEvents(events)
            })
    }

    function printEvents(events) {
        $(".selected-day-events .events .event").remove();
        $(events).each(function (index, event) {
            printEvent(event);
        })
    }

    function printEvent(event) {
        let event_html = "<tr class='event'>";
        event_html += "<td class='name-of-event'> <a href='events/" + event["id"] + "'>" + event["name_of_event"] + "</a></td>";
        event_html += "<td class='time'>" + getTime(event["start_of_event"]) + " - " + getTime(event["end_of_event"]) + "</td>";
        /*
                event_html += "<td class='time'>До " +  + "</td>";
        */
        event_html += "<td class='time'><a href='/events/" + event["id"] + "/edit' class='btn btn-outline-warning'>Изменить</a></td>";
        event_html += "<td class='time'><a href='/events/" + event["id"] + "' data-method=\"delete\" data-confirm=\"Are you sure?\" class='btn btn-outline-danger'>Удалить</a></td>";
        event_html += "</tr>";
        if ($('.selected-day-events .events').not(':has(.event)')) {
            $(" .selected-day-events .events").append(event_html);
        } else {
            $(" .selected-day-events .events .event:last-child").after(event_html);
        }
    }

    function getTime(times) {
        if (times == null) return "";
        var time = new Date(times);
        var todisplay = '';

        if (time.getHours() < 10) todisplay += '0' + time.getHours();
        else todisplay += time.getHours();

        if (time.getMinutes() < 10) todisplay += ':0' + time.getMinutes();
        else todisplay += ':' + time.getMinutes();

        return todisplay;
    }

    $(".search-bar button").click(function () {
        event.preventDefault();
        getEventsByQuery($(".search-bar input").val())
    });

    function getEventsByQuery(query) {
        $.ajax({
            statusCode: {
                401: function () {
                    alert("Войдите или зарегистрируйтесь");
                }
            },
            method: "GET",
            dataType: "json",
            url: "/events",
            data: {q: query},
            beforeSend: function () {
                $(".events-search").find(".event").remove();
            },
        })
            .done(function (events) {
                $('#loader').hide();
                console.log(events);
                printSearchEvents(events)
            })
    }

    function printSearchEvents(events) {
        $(".god-thanks").remove();
        if ($(".events-search").length === 0) {
            $('.add-event').after("<div class = 'block events-search'><div class='table-scroll-wrapper'><table class = 'table events'></table></div></div>")
        } else {
            $(".events-search .events").find(".event").remove();
        }
        if (events.length === 0) {
            $(".events-search").append("<p class='text-center font-weight-light font-italic god-thanks pt-2'>Тут ничего.</p>")
        }
        $(events).each(function (index, event) {
            printSearchEvent(event);
        })
    }

    function printSearchEvent(event) {
        let event_html = "<tr class='event'>";
        event_html += "<td class='name-of-event'>" + event["name_of_event"] + "</td>";
        event_html += "<td class='time'>" + event["date_event"] + "</td>";
        event_html += "<td class='time'>" + getTime(event["start_of_event"]) + " - " + getTime(event["end_of_event"]) + "</td>";
        event_html += "</tr>";
        if ($('.events-search .events').not(':has(.event)')) {
            $(".events-search .events").append(event_html);
        } else {
            $(".events-search .events .event:last-child").after(event_html);
        }
    }
});
