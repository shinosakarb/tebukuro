import { createAction } from 'redux-actions'
import TicketReducer    from '../../client/reducers/Ticket'
import ApiResponseError from '../../client/utils/ApiResponseError'
import Actions          from '../../client/constants/Actions'
import TicketModel      from '../../client/models/Ticket'

const model = (params) => {
  return new TicketModel(params)
}

describe('Ticket', () => {
  describe('CREATE_TICKET', () => {
    const createTicket = createAction(Actions.Ticket.createTicket)

    it("should handle CREATE_TICKET", () => {
      const id            = 1
      const name          = 'communityName'
      const description   = 'communityDescription'
      const cost          = 2
      const quantity      = 3
      const eventId       = 4
      const saleStartsAt  = '2017/03/02 09:00:00'
      const saleEndsAt    = '2017/03/02 11:00:00'

      const response = {
        id:             id,
        name:           name,
        cost:           cost,
        quantity:       quantity,
        event_id:       eventId,
        sale_starts_at: saleStartsAt,
        sale_ends_at:   saleEndsAt
      }

      const subject = TicketReducer(model(), createTicket(response))

      expect(subject.id).toBe(response.id)
      expect(subject.name).toBe(response.name)
      expect(subject.cost).toBe(response.cost)
      expect(subject.quantity).toBe(response.quantity)
      expect(subject.eventId).toBe(response.event_id)
      expect(subject.saleStartsAt).toBe(response.sale_starts_at)
      expect(subject.saleEndsAt).toBe(response.sale_ends_at)
    })

    it("should handle CREATE_TICKET error", () => {
      const errorMessage = 'error'
      const action = createTicket(new ApiResponseError([errorMessage]))
      const subject = TicketReducer(model(), action)
      expect(subject.errors[0]).toBe(errorMessage)
    })
  })
})
