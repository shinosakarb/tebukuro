export default class ApiResponseError extends Error {
  constructor(messages) {
    super(messages)
    this.messages = messages
    this.name = 'ApiResponseError'
  }
}
