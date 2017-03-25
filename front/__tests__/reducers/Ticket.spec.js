import { createAction } from 'redux-actions'
import TicketReducer    from '../../client/reducers/Ticket'
import ApiResponseError from '../../client/utils/ApiResponseError'
import Actions          from '../../client/constants/Actions'
import TicketModel      from '../../client/models/Ticket'
import TicketParams     from '../factories/Ticket'

const model = (params) =>  new TicketModel(params)

describe('Ticket', () => {
  describe('CREATE_TICKET', () => {
    const createTicket = createAction(Actions.Ticket.createTicket)

    it("should handle CREATE_TICKET", () => {
      const ticket = new model(TicketParams.ticket1)
      const response = ticket.toSnakeKeys()
      const subject = TicketReducer(model(), createTicket(response))

      expect(subject.toSnakeKeys()).toEqual(response)
    })

    it("should handle CREATE_TICKET error", () => {
      const errorMessage = 'error'
      const action = createTicket(new ApiResponseError([errorMessage]))
      const subject = TicketReducer(model(), action)
      expect(subject.errors[0]).toBe(errorMessage)
    })
  })
})
