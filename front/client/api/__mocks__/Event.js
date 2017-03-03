const path = require('path')
const Event = jest.genMockFromModule('../Event')

let mockResult = Object.create(null)
export const __setMockResult = (normal = true) => {
  mockResult = normal
}

export const showEvent = (id) => mockResult ? Promise.resolve({message: "normal mock"}) : Promise.reject({message: "error mock"})
export const createEvent = require('../Event').createEvent
export const getEvents = require('../Event').getEvents
export const editEvent = require('../Event').editEvent
export const deleteEvent = require('../Event').deleteEvent
