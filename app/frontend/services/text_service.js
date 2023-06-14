import Client from "parentsquare-interview-texting-api"
import currentUser from "../stores/current_user"
import { ref } from "vue"

class TextService {
  constructor({ basePath, messageStore, eventStore }) {
    this.client = new Client({ basePath })
    this.messageStore = messageStore
    this.eventStore = eventStore
  }

  login(username, api_key) {
    const loading = ref(true)
    const message = ref("")
    this.client.login(username, api_key).then((response) => {
      currentUser.username = response.username
      currentUser.isLoggedIn = true
    }).catch((error) => {
      console.log(error)
        message.value = this.client.renderError(error)
    }).finally(() => loading.value = false)
    return [loading, message]
  }

  fetchMessages() {
    const loading = ref(true)
    const more = ref(false)
    const next = ref("")
    this.client.fetchMessages().then((response) => {
      for(let i in response.messages) {
        this.messageStore.update(response.messages[i])
      }
      if (response.next && response.next !== "") {
        more.value = true
        next.value = response.next
      }
    }).finally(() => loading.value = false)
    return [loading, more, next]
  }

  fetchEvents() {
    const loading = ref(true)
    const more = ref(false)
    const next = ref("")
    this.client.fetchEvents().then((response) => {
      for(let i in response.events) {
        this.eventStore.update(response.events[i])
      }
      if (response.next && response.next !== "") {
        more.value = true
        next.value = response.next
      }
    }).finally(() => loading.value = false)
    return [loading, more, next]
  }

  fetchEvent(id) {
    const loading = ref(true)
    this.client.showEvent(id).then((response) => {
      for(let i in response.messages) {
        this.messageStore.update(response)
      }
    }).finally(() => loading.value = false)
    return loading
  }

  createMessage(to_number, message) {
    const loading = ref(true)
    this.client.createMessage({to_number, message}).then((response) => {
      this.messageStore.update(response)
    }).finally(() => loading.value = false)
    return loading
  }


}

export default TextService