import { combineReducers } from 'redux'
import { routerReducer } from 'react-router-redux'
import { authStateReducer } from "redux-auth"
import Community from './Community'
import CommunityList from './CommunityList'

export default combineReducers({
  Community,
  CommunityList,
  auth: authStateReducer,
  routing: routerReducer
})
