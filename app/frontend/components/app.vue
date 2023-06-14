<template>
  <div>
    <Navigation />
    <transition>
      <router-view></router-view>
    </transition>
  </div>
</template>

<script>
import Navigation from "./navigation.vue";

export default {
  name: "App",
  components: { Navigation },
  data() { return {} }

}
</script>

<style scoped>
div {
  width: 100%;
}
</style>

