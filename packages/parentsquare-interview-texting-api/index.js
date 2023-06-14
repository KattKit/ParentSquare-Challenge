import axios from "axios";

export default class Client {
  constructor({ baseUrl, username, api_key }) {
    this.baseUrl = baseUrl || ""
    this.username = username
    this.api_key = api_key
  }

  renderError(error) {
    if (error.response && error.response.data && error.response.data.message)
    {
      return error.response.data.message
    } else if (error.response && error.response.statusText ) {
      return error.response.statusText
    } else {
      return error
    }
  } 

  async get(url) {
    const response =  await axios.get(
      url, { 
        BaseURL: this.baseUrl,
        headers: {
          Authorization: `Bearer ${this.api_key}` 
        }
      })
    if (response.status === 200) {
      return response.data
    } else {
      throw response
    }
  }

  async login(username, api_key) {
    this.username = username
    this.api_key = api_key
    const url = `api/admin/${username}`
    return await this.get(url)

  }

  async createMessage({to_number, message}){
    const response = await axios.post(
      "api/message",{
        to_number,
        message
      }, { 
        BaseURL: this.baseUrl,
        headers: {
          "Authorization": `Bearer ${this.api_key}` 
        }
      })
    if (response.status === 200) {
      return response.data
    } else {
      throw response
    }
  }
  async showMessage(id) {
    const url = `api/message/${id}`
    return await this.get(url)
  }
  async fetchMessages(search) {
    const query = this.buildQuery(search)
    const url = `api/message?${query}`
    return await this.get(url)
  }

  async showEvent(id) {
    const url = `api/event/${id}`
    return await this.get(url)
  }
  async fetchEvents(search) {
    const query = this.buildQuery(search)
    const url = `api/event?${query}`
    return await this.get(url)
  }

  async showPhoneNumber({id, number}) {
    const param = id || number
    const query = id ? "" : "find_by=number"
    const url = `api/message/${param}?${query}`
    return await this.get(url)
  }
  async fetchPhoneNumbers(search) {
    const query = this.buildQuery(search)
    const url = `api/phone_number?${query}`
    return await this.get(url)
  }

  buildQuery(search) {
    if (!search) {
      return ""
    }
    return search
      .keys
      .map((key) => `${key}=${search[key]}`)
      .join("&")
  }
}

