import { handleActions }  from 'redux-actions'
import Community          from '../models/Community'
import ConvertCase          from '../utils/ConvertCase'

export const communityInitialState = new Community()

export const communityReducerMap = {
  CREATE_COMMUNITY: {
    next: (state, action) => {
      return new Community(ConvertCase.camelKeysOf(action.payload))
    },
    throw: (state, action) => {
      return new Community({
        errors: action.payload.messages
      })
    }
  }
}

export default handleActions(communityReducerMap, communityInitialState)
