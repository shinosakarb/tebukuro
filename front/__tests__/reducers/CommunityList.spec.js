import { createAction }     from 'redux-actions'
import CommunityListReducer from '../../client/reducers/CommunityList'
import Actions              from '../../client/constants/Actions'
import CommunityModel       from '../../client/models/Community'
import CommunityListModel   from '../../client/models/CommunityList'
import CommunityParams      from '../factories/Community'

const model = (params) => new CommunityModel(params)
const listModel = (params) => new CommunityListModel(params)

describe('CommunityList', () => {
  describe('CREATE_COMMUNITIES', () => {
    it("should handle CREATE_COMMUNITIES", () => {
      const list = [
          model(CommunityParams.community1),
          model(CommunityParams.community2)
      ] 
      const response = list.map( community => community.toSnakeKeys() )
      const listState = CommunityListReducer(
        model(), createAction(Actions.CommunityList.createCommunities)(response)
      )
      const subject = listState.communities.map( community => {
        return community.toSnakeKeys()
      })

      expect(subject.count()).toBe(2)
      // Subject needs tobe transformed from Set to Array.
      expect(subject.toArray()).toEqual(response)
    })
  })
})
