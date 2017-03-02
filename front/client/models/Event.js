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

  isEnd() {
    // TODO It depends on the local machine
    return (new Date()).getTime() > this.convertEventEndsAtToDate().getTime()
  }

  convertEventStartsAtToDate() {
    return this.eventStartsAt && this.eventStartsAt.length > 0 ? new Date(this.eventStartsAt) : null
  }

  convertEventEndsAtToDate() {
    return this.eventEndsAt && this.eventEndsAt.length > 0 ? new Date(this.eventEndsAt) : null
  }
}
