<template>
  <v-modal button="Send Message">
    <div>
      <label class="sr-only" for="phone_number">
        Phone Number
      </label>
      <input id="phone_number" type="text" class="form-control" placeholder="Phone Number" v-model="phoneNumber"/>
    </div>
    <div>
      <label class="sr-only" for="message_body">
        Message
      </label>
      <textarea id="message_body" type="text" class="form-control" placeholder="Message" v-model="message" >
      </textarea>
    </div>

    <template #footer="modal">
      <button type="button" class="btn btn-primary" @click="send_message(); modal.close(); clear()">Send Message</button>
      <button type="button" class="btn btn-secondary" @click="modal.close(); clear()">Clear &amp; Close</button>
    </template>
  </v-modal>
</template>

<script>
import VModal from './v-modal.vue'
export default {
  name: "CreateMessage",
  inject: ["textService"],
  components: { VModal },
  data() {
    return {
      phoneNumber: "",
      message: "",
      show: false,
      loading: false
    }
  },
  methods: {
    clear() {
      this.phoneNumber = ""
      this.message = ""
    },
    send_message() {
      this.textService.createMessage(this.phoneNumber, this.message)
    }
  }

}
</script>

<style>
.modal {
  display: block;
}

.modal-backdrop {
  opacity: 0.15;
}


.fade-in-enter-active {
  animation: fade-in 0.5s;
}

.fade-in-leave-active {
  animation: fade-in 0.5s reverse;
}

@keyframes fade-in {
  from {
    opacity: 0;
  }

  to {
    opacity: .15;
  }
}

</style>