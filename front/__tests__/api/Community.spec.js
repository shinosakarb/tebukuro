import nock from 'nock'
import { createCommunityHandler } from '../../client/api/Community'

describe('createCommunityHandler', () => {
  describe('when valid param', () => {
    const name = 'communityName'
    const description = 'communityDescription'

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
      .post('/communities')
      .reply(201, response)

      return createCommunityHandler(name, description)
      .then((payload) => {
        expect(payload.id).toBe(response.id)
        expect(payload.name).toBe(response.name)
        expect(payload.description).toBe(response.description)
      })
    })
  })

  describe('when invalid param', () => {
    it('should return action with error', () => {
      const nameError = ['を入力してください']
      const descriptionError = ['を入力してください']

      const response = {
        name: nameError,
        description: descriptionError
      }

      nock(Config.ApiEndPoint)
      .post('/communities')
      .reply(422, response)

      const name = ''
      const description = ''

      return createCommunityHandler(name, description)
      .catch((payload) => {
        expect(payload.messages[0]).toContain('name')
        expect(payload.messages[1]).toContain('description')
      })
    })
  })
})
