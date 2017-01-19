import nock from 'nock'
import * as CommunityAPI from '../../client/api/Community'

describe('Community', () => {
  describe('createCommunity', () => {
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

        return CommunityAPI.createCommunity(name, description)
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

        return CommunityAPI.createCommunity(name, description)
        .catch((payload) => {
          expect(payload.messages[0]).toContain('name')
          expect(payload.messages[1]).toContain('description')
        })
      })
    })
  })

  describe('getCommunities', () => {
    test('get JSON of communities', async () =>{
      const response = [{id: 1, name: "name1", description: "description1"}, {id: 2, name: "name2", description: "description2"}]

      nock(Config.ApiEndPoint)
        .get('/communities.json')
        .reply(200, response)
      const subject = await CommunityAPI.getCommunities()
      expect(subject).toEqual(response)
    })
  })
})
