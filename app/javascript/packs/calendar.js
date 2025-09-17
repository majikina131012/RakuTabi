import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';

document.addEventListener('turbolinks:load', function() {
  var calendarEl = document.getElementById('calendar');

  if (calendarEl) {
    var groupId = calendarEl.dataset.groupId;

    var calendar = new Calendar(calendarEl, {
      plugins: [dayGridPlugin],
      initialView: 'dayGridMonth',
      events: `/groups/${groupId}/events.json`
    });

    calendar.render();
  }
});