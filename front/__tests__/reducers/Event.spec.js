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

      const response = {
        id: id,
        name: name,
        description: description,
        community_id: communityId,
        event_starts_at: eventStartsAt,
        event_ends_at: eventEndsAt,
        address: address
      }

      const subject = EventReducer(model(), createEvent(response))

      expect(subject.id).toBe(response.id)
      expect(subject.name).toBe(response.name)
      expect(subject.description).toBe(response.description)
      expect(subject.communityId).toBe(response.community_id)
      expect(subject.eventStartsAt).toBe(response.event_starts_at)
      expect(subject.eventEndsAt).toBe(response.event_ends_at)
      expect(subject.address).toBe(response.address)
    })

    it("should handle CREATE_EVENT error", () => {
      const errorMessage = 'error'
      const action = createEvent(new ApiResponseError([errorMessage]))
      const subject = EventReducer(model(), action)
      expect(subject.errors[0]).toBe(errorMessage)
    })
  })
})
