const path = require('path')
const Community = jest.genMockFromModule('../Community')

let mockResult = Object.create(null)
export const __setMockResult = (normal = true) => {
  mockResult = normal
}

export const showCommunity = (id) => mockResult ? Promise.resolve({message: "normal mock"}) : Promise.reject({message: "error mock"})
export const createCommunity = require('../Community').createCommunity
export const getCommunities = require('../Community').getCommunities
