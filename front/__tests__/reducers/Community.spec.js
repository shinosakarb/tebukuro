import { createAction }     from 'redux-actions'
import CommunityReducer     from '../../client/reducers/Community'
import ApiResponseError     from '../../client/utils/ApiResponseError'
import Actions              from '../../client/constants/Actions'
import CommunityModel       from '../../client/models/Community'
import CommunityParams      from '../factories/Community'

const model = (params) => new CommunityModel(params)

describe('Community', () => {
  describe('CREATE_COMMUNITY', () => {
    const createCommunity = createAction(Actions.Community.createCommunity)

    it("should handle CREATE_COMMUNITY", () => {
      const community = model(CommunityParams.community1)
      const response = community.toSnakeKeys()
      const subject = CommunityReducer(model(), createCommunity(response))

      expect(subject.toSnakeKeys()).toEqual(response)
    })

    it("should handle CREATE_COMMUNITY error", () => {
      const errorMessage = 'error'
      const action = createCommunity(new ApiResponseError([errorMessage]))
      const subject = CommunityReducer(model(), action)
      expect(subject.errors[0]).toBe(errorMessage)
    })
  })
})
