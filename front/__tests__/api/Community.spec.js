import nock              from 'nock'
import Community         from '../../client/models/Community'
import * as CommunityAPI from '../../client/api/Community'
import RequestUrls       from '../../client/constants/RequestUrls'
import Params            from '../factories/Community'
import TestUtils         from '../factories/TestUtils'

describe('Community', () => {

  const params = new Community(Params.community1).toSnakeKeys()
  const emptyParams = TestUtils.makeEmptyParams(params)

  const attrNames = [ 'name', 'description' ]
  const errorMessage = ['を入力してください']
  const errorResponse = TestUtils.makeErrorResponse(attrNames, errorMessage)

  const id = params.id

  describe('createCommunity', () => {
    describe('when valid param', () => {
      it('should return action', () => {

        nock(Config.ApiEndPoint)
          .post(RequestUrls.communities)
          .reply(201, params)

        return CommunityAPI.createCommunity(params)
          .then((payload) => {
            expect(payload).toEqual(params)
          })
      })
    })

    describe('when invalid param', () => {
      it('should return action with error', () => {

        nock(Config.ApiEndPoint)
          .post(RequestUrls.communities)
          .reply(422, errorResponse)

        return CommunityAPI.createCommunity(emptyParams)
          .catch((payload) => {
            payload.messages.map((message, index) => {
              expect(message).toContain(attrNames[index])
            })
          })
      })
    })
  })

  describe('getCommunities', () => {
    test('get JSON of communities', () =>{
      const response = [ Params.community1, Params.community2 ]

      nock(Config.ApiEndPoint)
        .get(RequestUrls.communities)
        .reply(200, response)

      return CommunityAPI.getCommunities()
        .then((pyaload) => {
          expect(pyaload).toEqual(response)
        })
    })
  })
})
