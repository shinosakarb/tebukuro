import nock          from 'nock'
import Event         from '../../client/models/Event'
import * as EventAPI from '../../client/api/Event'
import RequestUrls   from '../../client/constants/RequestUrls'
import Params        from '../factories/Event'
import TestUtils     from '../factories/TestUtils'

describe('Event', () => {

  const params = new Event(Params.event1).toSnakeKeys()
  const emptyParams = TestUtils.makeEmptyParams(params)

  const attrNames = [ 'name', 'eventStartsAt', 'eventEndsAt', 'description', 'address']
  const errorMessage = ['を入力してください']
  const errorResponse = TestUtils.makeErrorResponse(attrNames, errorMessage)

  const id = params.id
  const communityId = params.community_id

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
          .reply(422, errorResponse)

        return EventAPI.createEvent(emptyParams)
          .catch((payload) => {
            payload.messages.map((message, index) => {
              expect(message).toContain(attrNames[index])
            })
          })
      })
    })
  })

  describe('getEvents', () => {
    test('get JSON of events', () =>{
      const response = [ Params.event1, Params.event2 ]

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
        .get(`${RequestUrls.events}/${id}`)
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
          .intercept(`${RequestUrls.events}/${id}`, 'PATCH')
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
          .intercept(`${RequestUrls.events}/${id}`, 'PATCH')
          .reply(422, errorResponse)

        return EventAPI.editEvent(emptyParams)
          .catch((payload) => {
            payload.messages.map((message, index) => {
              expect(message).toContain(attrNames[index])
            })
          })
      })
    })
  })

  describe('deleteEvent', () => {
    test('delete a event', () =>{
  
      nock(Config.ApiEndPoint)
        .intercept(`${RequestUrls.events}/${id}`, 'DELETE')
        .reply(200)

      return EventAPI.deleteEvent(id)
        .then((payload) => {
          expect(payload).toEqual({})
        })
    })
  })
})
