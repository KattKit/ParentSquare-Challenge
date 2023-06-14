import { reactive } from "vue"

let currentUser = reactive(
  {
    username: "",
    authToken: "",
    isLoggedIn: false
  }
)

export default currentUser