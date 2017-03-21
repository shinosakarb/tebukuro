import { handleActions }  from 'redux-actions'
import Ticket             from '../models/Ticket'

export const ticketInitialState = new Ticket()

export const ticketReducerMap = {
  CREATE_TICKET: {
    next: (state, action) => {
      return new Ticket(
        (new Ticket).camelKeysOf(action.payload)
      )
    },
    throw: (state, action) => {
      return new Ticket({
        errors: action.payload.messages
      })
    }
  }
}

export default handleActions(ticketReducerMap, ticketInitialState)
