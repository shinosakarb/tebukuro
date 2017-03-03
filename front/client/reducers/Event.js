import { handleActions }    from 'redux-actions'
import Event                from '../models/Event'
import { ticketReducerMap } from './Ticket'

export const eventInitialState = new Event()

export const eventReducerMap = {
  CREATE_EVENT: {
    next: (state, action) => {
      const event = new Event({
        id:             action.payload.id,
        name:           action.payload.name,
        description:    action.payload.description,
        communityId:    action.payload.community_id,
        eventStartsAt:  action.payload.event_starts_at,
        eventEndsAt:    action.payload.event_ends_at,
        address:        action.payload.address
      })
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
