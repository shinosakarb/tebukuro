import { combineReducers } from 'redux'
import { routerReducer } from 'react-router-redux'
import Community from './Community'
import CommunityList from './CommunityList'

export default combineReducers({
  Community,
  CommunityList,
  routing: routerReducer
})
