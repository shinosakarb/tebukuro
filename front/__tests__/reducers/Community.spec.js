import { createAction }     from 'redux-actions'
import CommunityReducer     from '../../client/reducers/Community'
import ApiResponseError     from '../../client/utils/ApiResponseError'
import { CREATE_COMMUNITY } from '../../client/actions/Community'
import CommunityModel       from '../../client/models/Community'

const model = (params) => {
  return new CommunityModel(params)
}

describe('Community', () => {
  describe('CREATE_COMMUNITY', () => {
    const createCommunity = createAction(CREATE_COMMUNITY)

    it("should handle CREATE_COMMUNITY", () => {
      const id = 1
      const name = 'communityName'
      const description = 'communityDescription'

      const response = {
        id: id,
        name: name,
        description: description
      }

      const createCommunity = createAction(CREATE_COMMUNITY)
      const subject = CommunityReducer(model(), createCommunity(response))

      expect(subject.id).toBe(response.id)
      expect(subject.name).toBe(response.name)
      expect(subject.description).toBe(response.description)
    })

    it("should handle CREATE_COMMUNITY error", () => {
      const errorMessage = 'error'
      const action = createCommunity(new ApiResponseError([errorMessage]))
      const subject = CommunityReducer(model(), action)
      expect(subject.errors[0]).toBe(errorMessage)
    })
  })
})
