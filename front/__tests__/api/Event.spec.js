import nock from 'nock'
import Event from '../../client/models/Event'
import * as EventAPI from '../../client/api/Event'
import RequestUrls from '../../client/constants/RequestUrls'

describe('Event', () => {
  const id = 1
  const communityId = 1

  const params = {
    id: id,
    community_id: communityId,
    name: 'eventName',
    event_starts_at: '2017/03/04 13:00:00',
    event_ends_at: '2017/03/04 13:00:00',
    description: 'eventDescription',
    address: 'eventAddress'
  }

  const invalidParams = {
    id: id,
    community_id: communityId,
    name: '',
    event_starts_at: '',
    event_ends_at: '',
    description: '',
    address: ''
  }

  const nameError = ['を入力してください']
  const eventStartsAtError = ['を入力してください']
  const eventEndsAtError = ['を入力してください']
  const descriptionError = ['を入力してください']
  const addressError = ['を入力してください']

  const responseError = {
    nameError: nameError,
    eventStartsAtError: eventStartsAtError,
    eventEndsAtError: eventEndsAtError,
    description: descriptionError,
    address: addressError
  }

  describe('createEvent', () => {
    describe('when valid param', () => {
      it('should return action', () => {

        nock(Config.ApiEndPoint)
          .post(`${RequestUrls.communityEvents(communityId)}`)
          .reply(201, params)

        return EventAPI.createEvent(params)
          .then((payload) => {
            expect(payload).toEqual(params)
          })
      })
    })

    describe('when invalid param', () => {
      it('should return action with error', () => {

        nock(Config.ApiEndPoint)
          .post(`${RequestUrls.communityEvents(communityId)}`)
          .reply(422, responseError)

        return EventAPI.createEvent(invalidParams)
          .catch((payload) => {
            expect(payload.messages[0]).toContain('name')
            expect(payload.messages[1]).toContain('eventStartsAt')
            expect(payload.messages[2]).toContain('eventEndsAt')
            expect(payload.messages[3]).toContain('description')
            expect(payload.messages[4]).toContain('address')
          })
      })
    })
  })

  describe('getEvents', () => {
    test('get JSON of events', () =>{
      const response = [
        {
          id: id,
          community_id: communityId,
          name: 'eventName1',
          event_starts_at: '2017/03/04 13:00:00',
          event_ends_at: '2017/03/04 17:00:00',
          description: 'eventDescription',
          address: 'eventAddress'
        },
        {
          id: 2,
          community_id: 2,
          name: 'eventName2',
          event_starts_at: '2017/05/27 10:00:00',
          event_ends_at: '2017/05/27 18:00:00',
          description: "eventDescription2",
          address: "eventAddress2"
        }
      ]

      nock(Config.ApiEndPoint)
        .get(`${RequestUrls.communityEvents(communityId)}`)
        .reply(200, response)

      return EventAPI.getEvents(communityId)
        .then((payload) => {
          expect(payload).toEqual(response)
        })
    })
  })

  describe('showEvent', () => {
    test('get JSON of a event', () =>{

      nock(Config.ApiEndPoint)
        .get(`${RequestUrls.events}/${params.id}`)
        .reply(200, params)

      return EventAPI.showEvent(id)
        .then((payload) => {
          expect(payload).toEqual(params)
        })
    })
  })

  describe('editEvent', () => {
    describe('when valid param', () => {
      it('should return action', () => {
  
        nock(Config.ApiEndPoint)
          .intercept(`${RequestUrls.events}/${params.id}`, 'PATCH')
          .reply(200, params)
  
        return EventAPI.editEvent(params)
          .then((payload) => {
            expect(payload).toEqual(params)
          })
      })
    })

    describe('when invalid param', () => {
      it('should return action with error', () => {

        nock(Config.ApiEndPoint)
          .intercept(`${RequestUrls.events}/${params.id}`, 'PATCH')
          .reply(422, responseError)

        return EventAPI.editEvent(invalidParams)
          .catch((payload) => {
            expect(payload.messages[0]).toContain('name')
            expect(payload.messages[1]).toContain('eventStartsAt')
            expect(payload.messages[2]).toContain('eventEndsAt')
            expect(payload.messages[3]).toContain('description')
            expect(payload.messages[4]).toContain('address')
          })
      })
    })
  })

  describe('deleteEvent', () => {
    test('delete a event', () =>{
  
      nock(Config.ApiEndPoint)
        .intercept(`${RequestUrls.events}/${params.id}`, 'DELETE')
        .reply(200)

      return EventAPI.deleteEvent(id)
        .then((payload) => {
          expect(payload).toEqual({})
        })
    })
  })
})
