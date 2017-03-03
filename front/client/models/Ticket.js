import Record from './Base'

export const TicketRecord = Record({
  id:           0,
  name:         '',
  cost:         0,
  quantity:     0,
  eventId:      0,
  saleStartsAt: '',
  saleEndsAt:   ''
})

export default class Ticket extends TicketRecord {
}
