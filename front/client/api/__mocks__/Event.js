const path = require('path')
const Event = jest.genMockFromModule('../Event')

let mockResult = Object.create(null)
export const __setMockResult = (normal = true) => {
  mockResult = normal
}

export const showEvent = (id) => mockResult ? Promise.resolve({message: "normal mock"}) : Promise.reject({message: "error mock"})
