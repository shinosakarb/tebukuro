import request from 'superagent'
import ApiResponseError from './ApiResponseError'

const onSuccess = (response) => {
  return response.body
}

const createErrorMessages = (errorBody) => {
  let errorMessages = []

  for (var key in errorBody) {
    // skip loop if the property is from prototype
    if (!errorBody.hasOwnProperty(key)) continue;

    errorBody[key].forEach((error) => {
      errorMessages.push(`${key}${error}`)
    })
  }

  return errorMessages
}

const onFailure = (error) => {
  let errorMessages = []

  if (error.status === 404) {
    errorMessages = ['Not Found']
  } else {
    errorMessages = createErrorMessages(error.response.body)
  }
  throw new ApiResponseError(errorMessages)
}

const ApiClient = {
  get(path, params) {
    return request.get(`${Config.ApiEndPoint}${path}`)
      .query(params)
      .then(onSuccess, onFailure)
  },
  post(path, params) {
    return request
      .post(`${Config.ApiEndPoint}${path}`)
      .send(params)
      .then(onSuccess, onFailure)
  },
  patch(path, params) {
    return request
      .patch(`${Config.ApiEndPoint}${path}`)
      .send(params)
      .then(onSuccess, onFailure)
  },
  delete(path) {
    return request
      .del(`${Config.ApiEndPoint}${path}`)
      .then(onSuccess, onFailure)
  }
}

export default ApiClient
