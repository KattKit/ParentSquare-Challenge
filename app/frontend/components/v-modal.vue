<template>
  <div>
    <slot name="button" @click="toggle()" :open="open" :close="close" :toggle="toggle">
      <button type="button" class="btn btn-info" @click="toggle()">{{ button }}  </button>
    </slot>

    <Transition name="slide">
      <Teleport to="body" v-if="show">
        <div class="modal" tabindex="-1" role="dialog">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <slot name="header" :open="open" :close="close" :toggle="toggle">
                  <h5 class="modal-title">{{ title }}</h5>
                  <button type="button" class="close" @click="show = false" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                  </button>
                </slot>
              </div>
              <div class="modal-body">
                <slot></slot>
              </div>
              <div class="modal-footer">
                <slot name="footer" :open="open" :close="close" :toggle="toggle">
                  <button type="button" class="btn btn-primary" @click="show = false; clear()">Close</button>
                </slot>
              </div>
            </div>
          </div>
        </div>
        <div class="modal-backdrop"></div>
      </Teleport>
    </Transition>
  </div>
</template>

<script>
export default {
  name: "v-modal",
  data() {
    return {
      show: false,
      loading: false
    }
  },
  methods: {
    toggle() {
      this.show = !this.show
    },
    open() {
      this.show = true
    },
    close() {
      this.show = false
    }
  },
  props: {
    title: {
      default: "Message"
    },
    button: {
      default: "Toggle Message",
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