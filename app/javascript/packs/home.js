import niceDatePicker from './nice-date-picker';
import eventJst from './event.jst';

$(document).ready(function () {
    let d = new Date();
    let strDate = d.getFullYear() + "/" + (d.getMonth() + 1) + "/" + d.getDate();
    let activeDate = strDate;
    getEventsByDate(strDate);
    new niceDatePicker({
        dom: document.getElementById('calendar1-wrapper1'),
        onClickDate: function (date) {
            getEventsByDate(date);
            changeDateInForm(date);
            activeDate = date;
        },
        mode: 'en'
    });

    $("#new_event")
        .on("ajax:success", addEvent)
        .on("ajax:error", showError);

    $(document)
        .on("ajax:complete", "a[data-event-id]", deleteEvent);

    function deleteEvent() {
        $("tr[data-event-id='" + $(this).data("event-id") + "']").fadeOut()
    }

    function addEvent(data) {
        let event = data["detail"][0];
        console.log(event);
        let date1 = new Date(activeDate).toDateString();
        let date2 = new Date(event["date_event"]).toDateString();
        if (date1 === date2) {
            printEvent(event)
        }
    }

    function showError(error) {
        console.log(error);
    }

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
        let event_html = jst('event', event);
        if ($('.selected-day-events .events').not(':has(.event)')) {
            $(" .selected-day-events .events").append(event_html);
        } else {
            $(" .selected-day-events .events .event:last-child").after(event_html);
        }
    }

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
        addSearchBlock();
        if (events.length === 0) {
            $(".events-search").append(jst('no-results'))
        }
        $(events).each(function (index, event) {
            printSearchEvent(event);
        })
    }

    function printSearchEvent(event) {
        let event_html = jst('search-event', event);
        if ($('.events-search .events').not(':has(.event)')) {
            $(".events-search .events").append(event_html);
        } else {
            $(".events-search .events .event:last-child").after(event_html);
        }
    }

    $(".search-bar button").click(function () {
        event.preventDefault();
        getEventsByQuery($(".search-bar input").val())
    });

    function addSearchBlock() {
        $(".god-thanks").remove();
        if ($(".events-search").length === 0) {
            $('.add-event').after(jst('search-block'))
        } else {
            $(".events-search .events").find(".event").remove();
        }
    }

    function changeDateInForm(date) {
        $("#event_date_event").val(formatDate(date))
    }

    function formatDate(date) {
        var d = new Date(date),
            month = '' + (d.getMonth() + 1),
            day = '' + d.getDate(),
            year = d.getFullYear();

        if (month.length < 2) month = '0' + month;
        if (day.length < 2) day = '0' + day;

        return [year, month, day].join('-');
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
});
