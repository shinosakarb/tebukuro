import Record from './Base'
import { Set } from 'immutable'

export const EventRecord = Record({
  id:             0,
  name:           '',
  description:    '',
  communityId:    0,
  eventStartsAt:  '',
  eventEndsAt:    '',
  address:        '',
  tickets:        Set.of()
})

export default class Event extends EventRecord {
  setTickets(list) {
    return this.set('tickets', Set.of(...list))
  }
}
