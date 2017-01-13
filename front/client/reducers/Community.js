import { handleActions }  from 'redux-actions'
import Community          from '../models/Community'

export const communityInitialState = new Community()

export const communityReducerMap = {
  CREATE_COMMUNITY: {
    next: (state, action) => {
      return new Community({
        id:           action.payload.id,
        name:         action.payload.name,
        description:  action.payload.description
      })
    },
    throw: (state, action) => {
      return new Community({
        errors: action.payload.messages
      })
    }
  }
}

export default handleActions(communityReducerMap, communityInitialState)
