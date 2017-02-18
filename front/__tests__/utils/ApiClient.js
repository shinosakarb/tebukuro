import nock from 'nock'
import ApiClient from '../../client/utils/ApiClient'

describe('ApiClient', () => {
  const path = '/example'

  describe('get', () => {
    test('request success' ,() => {
      const response = [{id: 1}, {id: 2}]
      nock(Config.ApiEndPoint)
        .get(path)
        .reply(200, response)

      return ApiClient.get(path)
        .then((payload) => {
          expect(payload.length).toBe(2)
        })
    })
    test('request error' ,() => {
      nock(Config.ApiEndPoint)
        .get(path)
        .reply(404)

      return ApiClient.get(path)
        .catch((payload) => {
          expect(payload.messages[0]).toBe('Not Found')
        })
    })
  })

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
          .post(path)
          .reply(201, response)

        const communityParams = {
          name: name,
          description: description
        }

        return ApiClient.post(path, communityParams)
          .then((payload) => {
            expect(payload.id).toBe(response.id)
            expect(payload.name).toBe(response.name)
            expect(payload.description).toBe(response.description)
          })
      })
    })

    describe('when invalid param', () => {
      it('should payload in error', () => {
        const nameError = ["can't be blank"]
        const descriptionError = ["can't be blank"]

        const response = {
          name: nameError,
          description: descriptionError
        }

        nock(Config.ApiEndPoint)
          .post(path)
          .reply(422, response)

        const communityParams = {
          name: '',
          description: ''
        }

        return ApiClient.post(path, communityParams)
          .catch((payload) => {
            expect(payload.messages[0]).toContain('name')
            expect(payload.messages[1]).toContain('description')
          })
      })
    })
  })

  describe('patch', () => {
    test('request success' ,() => {
      const response = {
        name: 'test'
      }

      nock(Config.ApiEndPoint)
        .patch(`${path}/1`)
        .reply(200, response)

      const params = {
        name: 'test'
      }

      return ApiClient.patch(`${path}/1`, params)
        .then((payload) => {
          expect(payload.name).toBe(response.name)
        })
    })
    test('request error' ,() => {
      const response = {
        name: ["can't be blank"]
      }

      nock(Config.ApiEndPoint)
        .patch(`${path}/1`)
        .reply(422, response)

      const params = {
        name: ''
      }

      return ApiClient.patch(`${path}/1`, params)
        .catch((payload) => {
          expect(payload.messages[0]).toContain('name')
        })
    })
  })

  describe('delete', () => {
    test('request success' ,() => {
      const response = {
        name: 'test'
      }

      nock(Config.ApiEndPoint)
        .delete(`${path}/1`)
        .reply(200, response)

      return ApiClient.delete(`${path}/1`)
        .then((payload) => {
          expect(payload.name).toBe(response.name)
        })
    })
    test('request error' ,() => {
      nock(Config.ApiEndPoint)
        .delete(`${path}/1`)
        .reply(404)

      return ApiClient.delete(`${path}/1`)
        .catch((payload) => {
          expect(payload.messages[0]).toBe('Not Found')
        })
    })
  })
})
