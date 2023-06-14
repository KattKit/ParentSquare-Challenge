<template>
 <div class="page container">
    <div class="alert alert-warning" v-show="alert">
      {{ alert }}
    </div>
    <form class="box">
      <h1>
        Admin
      </h1>
      <div>
        <label class="sr-only" for="username">
          Username
        </label>
        <input id="username" type="text" class="form-control" placeholder="Username" v-model="username"/>
      </div>
      <div>
        <label class="sr-only" for="api_key">
          Api key
        </label>
        <input id="api_key" type="api_key" class="form-control" placeholder="Api key" v-model="api_key"/>
      </div>

      <button class="btn btn-primary form-control mt-4" @click.prevent="onSubmit" >Login</button>
      <button class="btn btn-secondary form-control mt-4" @click.prevent="onAnonymous">Remain Anonymous</button>
    </form>
 </div>
</template>

<script>

export default {
  name: "Login",
  inject: [ "notice", "textService", "currentUser"],
  data: () => {
    return {
      username: "",
      api_key: "",
      loading: false,
      message: false
    };
  },
  computed: {
    alert: (vm) => {
      if (!!vm.notice) {
        return vm.notice
      } else if (vm.message) {
        return vm.message
      }

      return false
    }
  },
  methods: {
    onSubmit(event) {
      [this.loading, this.message] = this.textService.login(this.username, this.api_key)
    },
    onAnonymous(event) {
      this.currentUser.username = "Anonymous"
      this.currentUser.isLoggedIn = true
      this.$router.push("/")
    }
  },
  watch: {
    loading(newVal, oldVal) {
      if ((!newVal && oldVal) && this.currentUser.isLoggedIn) {
        this.$router.push("/")
      }
    }
  }

}
</script>

<style scopped>

div.page {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100%;
  flex-direction: column;
}

h1 {
  position: relative;
  top: -40px;
  background-color: #f5f5f5;
  width: min-content;
  border: 1px solid black;
  border-radius: 2em / 5em;
  padding-left: 5px;
  padding-right: 5px;

}

form {
  /* justify-content: center; */
  /* justify-content: space-evenly; */
  border: 1px solid black;
  width: 100%;
  max-width: 330px;
  padding: 15px;
  margin: 0 auto;
  border-radius: 5px;
}

h1 {
  display: block;
}
</style>