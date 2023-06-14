import useArrayStore from "../compositions/use_array_store"

export default useArrayStore("message",{}, function(old, {id, to, status}) {
  return {
    ...old,
    id,
    to,
    status,
  }
})
