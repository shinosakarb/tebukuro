import { handleActions }    from 'redux-actions'
import Event                from '../models/Event'
import { ticketReducerMap } from './Ticket'
import ConvertCase          from '../utils/ConvertCase'

export const eventInitialState = new Event()

export const eventReducerMap = {
  CREATE_EVENT: {
    next: (state, action) => {
      const event = new Event(ConvertCase.camelKeysOf(action.payload))
      return event.setTickets(
        action.payload.tickets ? action.payload.tickets.map((item) => {
          return ticketReducerMap.CREATE_TICKET.next(
            null,
            {payload: item}
          )
        }) : []
      )
    },
    throw: (state, action) => {
      return new Event({
        errors: action.payload.messages
      })
    }
  }
}

export default handleActions(eventReducerMap, eventInitialState)
