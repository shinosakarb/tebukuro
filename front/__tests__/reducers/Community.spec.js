import CommunityReducer from '../../client/reducers/Community'
import { addCommunity } from '../../client/actions/Community'
import CommunityModel   from '../../client/models/Community'

const model = (params) => {
  return new CommunityModel(params)
}

describe('Community', () => {
  describe('ADD_COMMUNITY', () => {
    it("should handle ADD_COMMUNITY", () => {
      const subject = CommunityReducer(
        model(),
        addCommunity({
          id:           10,
          name:         'communityName',
          description:  'communityDescription'
        })
      )
      expect(subject.id).toBe(10)
      expect(subject.name).toBe('communityName')
      expect(subject.description).toBe('communityDescription')
    })
  })
})
