import { handleActions }  from 'redux-actions'
import Ticket             from '../models/Ticket'
import ConvertCase        from '../utils/ConvertCase'

export const ticketInitialState = new Ticket()

export const ticketReducerMap = {
  CREATE_TICKET: {
    next: (state, action) => {
      return new Ticket(ConvertCase.camelKeysOf(action.payload))
    },
    throw: (state, action) => {
      return new Ticket({
        errors: action.payload.messages
      })
    }
  }
}

export default handleActions(ticketReducerMap, ticketInitialState)
