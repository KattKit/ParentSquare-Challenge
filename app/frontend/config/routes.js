import Messages from "../components/messages.vue"
import PhoneNumbers from "../components/phone_numbers.vue"
import Login from "../components/login.vue"
import Events from "../components/events.vue"

export default [
  {
    path: "/",
    component: Messages
  },
  {
    path: "/phone_numbers",
    component: PhoneNumbers
  },
  {
    path: "/login",
    component: Login
  },
  {
    path: "/events",
    component: Events
  }
]

