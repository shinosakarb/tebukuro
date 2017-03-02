import { handleActions }  from 'redux-actions'
import Event              from '../models/Event'

export const eventInitialState = new Event()

export const eventReducerMap = {
  CREATE_EVENT: {
    next: (state, action) => {
      return new Event({
        id:             action.payload.id,
        name:           action.payload.name,
        description:    action.payload.description,
        communityId:    action.payload.community_id,
        eventStartsAt:  action.payload.event_starts_at,
        eventEndsAt:    action.payload.event_ends_at,
        address:        action.payload.address
      })
    },
    throw: (state, action) => {
      return new Event({
        errors: action.payload.messages
      })
    }
  }
}

export default handleActions(eventReducerMap, eventInitialState)
