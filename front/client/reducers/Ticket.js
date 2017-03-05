import { handleActions }  from 'redux-actions'
import Ticket             from '../models/Ticket'

export const ticketInitialState = new Ticket()

export const ticketReducerMap = {
  CREATE_TICKET: {
    next: (state, action) => {
      return new Ticket({
        id:           action.payload.id,
        name:         action.payload.name,
        cost:         action.payload.cost,
        quantity:     action.payload.quantity,
        eventId:      action.payload.event_id,
        saleStartsAt: action.payload.sale_starts_at,
        saleEndsAt:   action.payload.sale_ends_at
      })
    },
    throw: (state, action) => {
      return new Ticket({
        errors: action.payload.messages
      })
    }
  }
}

export default handleActions(ticketReducerMap, ticketInitialState)
