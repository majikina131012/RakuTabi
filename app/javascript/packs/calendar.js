import { Calendar } from '@fullcalendar/core'
import dayGridPlugin from '@fullcalendar/daygrid'

document.addEventListener('DOMContentLoaded', function() {
  const calendarEl = document.getElementById('calendar')

  const calendar = new Calendar(calendarEl, {
    plugins: [ dayGridPlugin ],
    initialView: 'dayGridMonth',
    events: `/events/${calendarEl.dataset.eventId}/votes.json`,

    dateClick: function(info) {
      const name = prompt("あなたの名前を入力してください")
      if (!name) return

      const choice = prompt("投票: ◯=ok, △=maybe, ✕=no を入力してください")
      let status
      if (choice === "◯") status = "ok"
      else if (choice === "△") status = "maybe"
      else status = "no"

      fetch(`/events/${calendarEl.dataset.eventId}/votes`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
        },
        body: JSON.stringify({
          vote: {
            date: info.dateStr,
            name: name,
            status: status
          }
        })
      }).then(res => {
        if (res.ok) {
          calendar.refetchEvents()
        }
      })
    }
  })

  calendar.render()
})
