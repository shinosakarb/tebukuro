import { createAction } from 'redux-actions'
import EventReducer     from '../../client/reducers/Event'
import ApiResponseError from '../../client/utils/ApiResponseError'
import Actions          from '../../client/constants/Actions'
import EventModel       from '../../client/models/Event'

const model = (params) => {
  return new EventModel(params)
}

describe('Event', () => {
  describe('CREATE_EVENT', () => {
    const createEvent = createAction(Actions.Event.createEvent)

    it("should handle CREATE_EVENT", () => {
      const id = 1
      const name = 'eventName'
      const description = 'eventDescription'
      const communityId = 2
      const eventStartsAt = '2017/03/02 09:00:00'
      const eventEndsAt = '2017/03/02 12:00:00'
      const address = 'address'
      const tickets = [
        {
          id:             3,
          name:           'ticketName1',
          cost:           4,
          quantity:       5,
          event_id:       6,
          sale_starts_at: '2017/03/01 09:00:00',
          sale_ends_at:   '2017/03/01 10:30:00'
        },
        {
          id:             7,
          name:           'ticketName2',
          cost:           8,
          quantity:       9,
          event_id:       10,
          sale_starts_at: '2017/03/01 10:30:00',
          sale_ends_at:   '2017/03/01 12:00:00'
        }
      ]

      const response = {
        id: id,
        name: name,
        description: description,
        community_id: communityId,
        event_starts_at: eventStartsAt,
        event_ends_at: eventEndsAt,
        address: address,
        tickets: tickets
      }

      const subject = EventReducer(model(), createEvent(response))

      expect(subject.id).toBe(response.id)
      expect(subject.name).toBe(response.name)
      expect(subject.description).toBe(response.description)
      expect(subject.communityId).toBe(response.community_id)
      expect(subject.eventStartsAt).toBe(response.event_starts_at)
      expect(subject.eventEndsAt).toBe(response.event_ends_at)
      expect(subject.address).toBe(response.address)

      expect(subject.tickets.count()).toBe(2)
      let index = 0
      subject.tickets.forEach((ticket) => {
        expect(ticket.id).toBe(tickets[index].id)
        expect(ticket.name).toBe(tickets[index].name)
        expect(ticket.cost).toBe(tickets[index].cost)
        expect(ticket.quantity).toBe(tickets[index].quantity)
        expect(ticket.eventId).toBe(tickets[index].event_id)
        expect(ticket.saleStartsAt).toBe(tickets[index].sale_starts_at)
        expect(ticket.saleEndsAt).toBe(tickets[index].sale_ends_at)
        index += 1
      })
    })

    it("should handle CREATE_EVENT error", () => {
      const errorMessage = 'error'
      const action = createEvent(new ApiResponseError([errorMessage]))
      const subject = EventReducer(model(), action)
      expect(subject.errors[0]).toBe(errorMessage)
    })
  })
})
