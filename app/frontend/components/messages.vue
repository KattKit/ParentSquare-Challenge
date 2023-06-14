<template>
  <div class="container">
    <div class="header">
      <h2>Messages</h2>
      <!-- <input class="form-control" /> -->
      <button class="btn btn-secondary" @click="fetchMessages()">O</button>
      <!-- <button></button>
      <button class="btn btn-secondary">1</button>
      <button class="btn btn-secondary">5</button>
      <button class="btn btn-secondary">25</button> -->

    </div>
    <table class="content-table table">
      <thead>
        <th scope="col">
          Id
        </th >
        <th scope="col">
          To
        </th>
        <th scope="col">
          Status
        </th>
      </thead>
      <tbody>
        <tr v-for="message in filteredMessages" :key="message.id">
          <td>
            <v-modal :title="message.id">
              <template #button="modal">
                <a href="#" @click.prevent="modal.open()">{{ message.id }}</a>
              </template>
              {{ message }}

            </v-modal>
          </td>
          <td>{{ message.to }}</td>
          <td>{{ message.status }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import VModal from "./v-modal.vue"

export default {
  name: "Messages",
  inject: ["textService", "messageStore"],
  components: { VModal },
  computed: {
    filteredMessages() {
      return this.messageStore
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
    fetchMessages() {
      [this.loading, this.more, this.next] = this.textService.fetchMessages()
    }
  },
  created() {
    this.fetchMessages()
  }

}
</script>

<style lang="scss" scoped>

.header {
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  justify-content: space-between !important;
  width: 100%;
  * {
    margin-right: 2em;
  }
}

</style>