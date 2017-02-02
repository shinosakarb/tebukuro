import nock from 'nock'
import ApiRequest from '../../client/api/ApiRequest'
import RequestUrls from '../../client/constants/RequestUrls'

describe('ApiRequest', () => {
  describe('post', () => {
    describe('when success', () => {
      it('should return action', () => {
        const id = 1
        const name = 'communityName'
        const description = 'communityDescription'

        const response = {
          id: id,
          name: name,
          description: description
        }

        nock(Config.ApiEndPoint)
          .post(RequestUrls.communities)
          .reply(201, response)

        const communityParams = {
          name: name,
          description: description
        }

        return ApiRequest.post(RequestUrls.communities, communityParams)
          .then((payload) => {
            expect(payload.id).toBe(response.id)
            expect(payload.name).toBe(response.name)
            expect(payload.description).toBe(response.description)
          })
      })
    })

    describe('when invalid param', () => {
      it('should payload in error', () => {
        const nameError = ['を入力してください']
        const descriptionError = ['を入力してください']

        const response = {
          name: nameError,
          description: descriptionError
        }

        nock(Config.ApiEndPoint)
          .post(RequestUrls.communities)
          .reply(422, response)

        const communityParams = {
          name: '',
          description: ''
        }

        return ApiRequest.post(RequestUrls.communities, communityParams)
          .catch((payload) => {
            expect(payload.messages[0]).toContain('name')
            expect(payload.messages[1]).toContain('description')
          })
      })
    })
  })
})
