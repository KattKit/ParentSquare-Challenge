import { reactive } from "vue"

export default function(name, { identity }, update_item) {
  identity = typeof identity !== 'undefined' ? identity : "id";
  return class {
    #ary = []

    get [name]() {
      return this.#ary.values()
    }
  
    [Symbol.iterator]() {
      return this.#ary.values()
    }
  
    get length() {
      return this.#ary.length
    }

    update(item) {
      let val = this.#ary.find((oldItem) => oldItem[identity] === item[identity])
      let val_idx = this.#ary.indexOf(val)
      if (val === undefined) {
        this.#ary.push(update_item({}, item))
      } else {
        val = update_item(val, item)
        this.#ary.splice(val_idx, 1, val)
      }
    }
  }
}