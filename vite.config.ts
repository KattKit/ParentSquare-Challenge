import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import vue from '@vitejs/plugin-vue'


export default defineConfig({
  server: {
    watch: {
      ignored: ['!**/node_modules/parentsquare-interview-texting-api/**'],
    },
  },
  // The watched package must be excluded from optimization,
  // so that it can appear in the dependency graph and trigger hot reload.
  optimizeDeps: {
    exclude: ['parentsquare-interview-texting-api'],
  },
  css: {
    preprocessorOptions: {
      scss: {
        additionalData: `
        @import "node_modules/bootstrap/scss/bootstrap.scss";
        `
      }
    }
  },
  plugins: [
    RubyPlugin(),
    vue(),
  ],
})
