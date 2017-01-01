import { handleActions }  from 'redux-actions'
import Community          from '../models/Community'

export const communityInitialState = new Community()

export const communityReducerMap = {
  CREATE_COMMUNITY(state, action) {
    return new Community({
      id:           action.payload.id,
      name:         action.payload.name,
      description:  action.payload.description
    })
  }
}

export default handleActions(communityReducerMap, communityInitialState)
