import CommunityReducer     from '../../client/reducers/Community'
import { createCommunity }  from '../../client/actions/Community'
import CommunityModel       from '../../client/models/Community'

const model = (params) => {
  return new CommunityModel(params)
}

describe('Community', () => {
  describe('CREATE_COMMUNITY', () => {
    it("should handle CREATE_COMMUNITY", () => {
      const subject = CommunityReducer(
        model(),
        createCommunity({
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
