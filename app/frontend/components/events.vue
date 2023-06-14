<template>
  <div class="container">
    <h2>Events</h2>
    <table class="content-table table">
      <thead>
        <th scope="col">
          Id
        </th >
        <th scope="col">
          Tags
        </th>
        <th>
          Created At
        </th>

      </thead>
      <tbody>
        <tr v-for="event in filteredEvents" :key="event.id">
          <td>
            <v-modal :title="event.id">
              <template #button="modal">
                <a href="#" @click.prevent="modal.open()">{{ event.id }}</a>
              </template>
              {{ event.data }}
              {{ event.tags }}
            </v-modal>
          </td>
          <td>{{ event.tags }}</td>
          <td><span :title="Date.parse(event.created_at)">{{ timeFromNow(event.created_at) }}</span></td>
        </tr>
      </tbody>
    </table>
  </div>
</template>
<script>
import VModal from "./v-modal.vue"

export default {
  name: "Events",
  inject: ["textService", "eventStore"],
  components: { VModal },
  computed: {
    filteredEvents() {
      return this.eventStore
    }
  },
  data() {
    return {
      loading: false,
      more: false,
      filter: "",
      next: ""
    }
  },
  methods: {
    fetchEvents() {
      [this.loading, this.more, this.next] = this.textService.fetchEvents()
    },
    timeFromNow(time) {
      let sec = (Date.now() - Date.parse(time)) / 1000
      if (sec < 60)
        return `${sec} seconds ago`
      else if (sec < 60*60) {
        let minutes = Math.floor(sec / 60)
        sec = Math.floor(sec % 60)
        return `${minutes}:${sec} ago`
      } else {
        return this.formatTime(time)
      }
    },
    formatTime(time) {
      return Date.parse(time)
    }
  },
  created() {
    this.fetchEvents()
  }

}
</script>