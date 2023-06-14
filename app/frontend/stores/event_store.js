import useArrayStore from "../compositions/use_array_store"

export default useArrayStore("event",{}, function(old, {id, data, tags, created_at}) {
  data = typeof data !== 'undefined' ? data : old.data
  return {
    ...old,
    id,
    data,
    tags,
    created_at
  }
})