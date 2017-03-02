import { createAction }     from 'redux-actions'
import CommunityListReducer from '../../client/reducers/CommunityList'
import Actions              from '../../client/constants/Actions'
import CommunityListModel   from '../../client/models/CommunityList'

const model = (params) => {
  return new CommunityListModel(params)
}

describe('CommunityList', () => {
  describe('CREATE_COMMUNITIES', () => {
    it("should handle CREATE_COMMUNITIES", () => {
      const values = [
        {
          id:           11,
          name:         'communityName1',
          description:  'communityDescription1'
        },
        {
          id:           12,
          name:         'communityName2',
          description:  'communityDescription2'
        }
      ]
      const subject = CommunityListReducer(
        model(),
        createAction(Actions.CommunityList.createCommunities)(values)
      )

      expect(subject.communities.count()).toBe(2)
      let index = 0
      subject.communities.forEach((community) => {
        expect(community.id).toBe(values[index].id)
        expect(community.name).toBe(values[index].name)
        expect(community.description).toBe(values[index].description)
        index += 1
      })
    })
  })
})
