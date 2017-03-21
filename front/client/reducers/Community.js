import { handleActions }  from 'redux-actions'
import Community          from '../models/Community'

export const communityInitialState = new Community()

export const communityReducerMap = {
  CREATE_COMMUNITY: {
    next: (state, action) => {
      return new Community(
        (new Community).camelKeysOf(action.payload)
      )
    },
    throw: (state, action) => {
      return new Community({
        errors: action.payload.messages
      })
    }
  }
}

export default handleActions(communityReducerMap, communityInitialState)
