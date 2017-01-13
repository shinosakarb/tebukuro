import request from 'superagent'
import ApiResponseError from './ApiResponseError'

const ApiRequest = {
  post(path, params) {
    const onSuccess = (response) => {
      return response.body
    }

    const createErrorMessages = (errorBody) => {
      let errorMessages = []

      for (var key in errorBody) {
        // skip loop if the property is from prototype
        if (!errorBody.hasOwnProperty(key)) continue;

        errorBody[key].forEach((error) => {
          errorMessages.push(key + error)
        })
      }

      return errorMessages
    }

    const onFailure = (error) => {
      const errorMessages = createErrorMessages(error.response.body)
      throw new ApiResponseError(errorMessages)
    }

    return request
      .post(Config.ApiEndPoint + path)
      .send(params)
      .then(onSuccess, onFailure)
  }
}

export default ApiRequest
