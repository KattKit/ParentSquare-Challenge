// To see this message, add the following to the `<head>` section in your
// views/layouts/application.html.erb
//
//    <%= vite_client_tag %>
//    <%= vite_javascript_tag 'application' %>
console.log("Vite ⚡️ Rails")

import "../scss/application.scss"
import { createApp } from "vue"
import routes from "../config/routes"
import { createRouter, createWebHashHistory } from "vue-router"
import App from "../components/app.vue"
import TextService from "../services/text_service"
import currentUser from "../stores/current_user"
import MessageStore from "../stores/message_store"
import EventStore from "../stores/event_store"

const config = JSON.parse(document.querySelector("#configuration").innerHTML)
let notice = false;
try {
  notice = JSON.parse(document.querySelector("#notice").innerHTML);
} catch {
  notice = false;
}

const router = createRouter({
  history: createWebHashHistory(),
  routes,
})

router.beforeEach((to, from, next) => {
  if ((to.path !== "/login" && to.path !== "login" ) && !currentUser.isLoggedIn) {
    next({path: "/login"})
  } else if ((to.path === '/login' || to.path === 'login') && currentUser.isLoggedIn) {
    next({path: "/"})
  } else {
    next()
  }
})

let messageStore = new MessageStore()
let eventStore = new EventStore()

const app = createApp(App)
app.provide("notice", notice)
app.provide("textService", new TextService({ basePath: config.basePath, messageStore, eventStore }))
app.provide("currentUser", currentUser)
app.provide("messageStore", messageStore)
app.provide("eventStore", eventStore)
app.use(router)
app.mount("#app")