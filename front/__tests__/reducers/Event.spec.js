import { createAction } from 'redux-actions'
import EventReducer     from '../../client/reducers/Event'
import ApiResponseError from '../../client/utils/ApiResponseError'
import Actions          from '../../client/constants/Actions'
import EventModel       from '../../client/models/Event'
import TicketModel      from '../../client/models/Ticket'
import EventParams      from '../factories/Event'
import TicketParams     from '../factories/Ticket'

const model = (params) => new EventModel(params)

describe('Event', () => {
  describe('CREATE_EVENT', () => {
    const createEvent = createAction(Actions.Event.createEvent)

    it("should handle CREATE_EVENT", () => {
      const event = new model(EventParams.event1)
      const tickets = [ TicketParams.ticket1, TicketParams.ticket2 ]

      let response = event.toSnakeKeys()
      response.tickets = tickets.map(ticket => (new TicketModel(ticket)).toSnakeKeys())

      const eventState = EventReducer(model(), createEvent(response))
      let subject = eventState.toSnakeKeys()
      // Tickets are in the Set as Event's value, so needs to be transformed separately.
      subject.tickets = eventState.tickets.map(ticket => ticket.toSnakeKeys()).toArray()
      
      expect(subject.tickets.length).toBe(2)
      expect(subject).toEqual(response)
    })

    it("should handle CREATE_EVENT error", () => {
      const errorMessage = 'error'
      const action = createEvent(new ApiResponseError([errorMessage]))
      const subject = EventReducer(model(), action)
      expect(subject.errors[0]).toBe(errorMessage)
    })
  })
})
