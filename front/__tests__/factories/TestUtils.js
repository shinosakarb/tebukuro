const TestUtils = {

  makeEmptyParams(params){
    let emptyParams = {}
    Object.keys(params).map(key => {
      //Ids may not be empty.
      if (key.match(/(^|_)id$/)){
        emptyParams[key] = params[key]
      } else {
        emptyParams[key] = ''
      }
    })

    return emptyParams
  },

  makeErrorResponse(attrNames, errorMessage){
    const attrErrorNames = attrNames.map(attr => attr + 'Error')
    let errorResponse = {}
    attrErrorNames.map(attrErrorName => {
      errorResponse[attrErrorName] = errorMessage
    })

    return errorResponse
  }
}

export default TestUtils
