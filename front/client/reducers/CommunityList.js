import { handleActions }        from 'redux-actions'
import CommunityList            from '../models/CommunityList'
import { communityReducerMap }  from './Community'

export const communityListInitialState = new CommunityList()

export const communityListReducerMap = {
  CREATE_COMMUNITIES(state, action) {
    const communityList = new CommunityList()
    return communityList.setCommunities(
      action.payload.map((item) => {
        return communityReducerMap.CREATE_COMMUNITY.next(
          null,
          {payload: {id: item.id, name: item.name, description: item.description}}
        )
      })
    )
  }
}

export default handleActions(communityListReducerMap, communityListInitialState)
