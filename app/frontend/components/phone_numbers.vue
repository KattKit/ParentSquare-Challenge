<template>
  <div class="container">
    <h2>Phone Numbers</h2>
    <table class="content-table table">
      <thead>
        <th scope="col">
          Id
        </th >
        <th scope="col">
          Number
        </th>
        <th>
          # Messages
        </th>
        <th scope="col">
          Status
        </th>
      </thead>
      <tbody>
        <tr v-for="phoneNumber in filteredPhoneNumbers" :key="phoneNumber.id">
          <td>{{ phoneNumber.id }}</td>
          <td>{{ phoneNumber.number }}</td>
          <td>{{ phoneNumber.count }}</td>
          <td>{{ phoneNumber.status }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>
<script>

export default {
  name: "PhoneNumbers"
}
</script>
