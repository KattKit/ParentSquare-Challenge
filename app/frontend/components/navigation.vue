<template>
  <transition name="flip-in">
    <navbar v-show="currentUser.isLoggedIn" class="navbar navbar-expand-lg navbar-light">
      <div>
        <ul class="navbar-nav mr-auto">
          <li class="nav-item">
            <router-link class="nav-link" to="/">Messages</router-link>
          </li>
          <li class="nav-item">
            <router-link class="nav-link" to="/phone_numbers">Phone Numbers</router-link>
          </li>
          <li class="nav-item">
            <router-link class="nav-link" to="/events">Events</router-link>
          </li>
        </ul>
      </div>
      <div>
        <ul class="navbar-nav mr-auto">
          <li class="nav-item">
            <CreateMessage />
          </li>
          <li class="nav-item dropdown">
            <div class="btn btn-info dropdown-toggle" @click="showLogout = !showLogout">Admin: {{ currentUser.username }}</div>
            <div class="dropdown-menu show" v-if="showLogout">
              <a href="#" class="dropdown-item" @click="currentUser.isLoggedIn = false">logout</a>
            </div>
          </li>
        </ul>
      </div>
    </navbar>
  </transition>
</template>

<script>
import CreateMessage from './create_message.vue';
export default {
  name: "Navigation",
  inject: ["currentUser"],
  components: { CreateMessage },
  data() {
    return {
      showLogout: false
    }
  }

}
</script>

<style>


navbar {
  display: flex;
  flex-direction: row;
  width: 100%;
  border: 1px solid black;
  border-radius: 5px;
  padding: 4px;
  justify-content: space-between !important;

}

navbar nav {
  margin-right: 1em;
}

.flip-in-enter-active {
  animation: flip-in 0.5s;
}

.flip-in-leave-active {
  animation: flip-in 0.5s reverse;
}

@keyframes flip-in {
  0%{
    transform: translateY(-30px) rotateX(-0.25turn)
  }


  100% {
    transform: unset;
  }
}

</style>