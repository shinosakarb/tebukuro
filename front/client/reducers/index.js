import { combineReducers } from 'redux'
import { routerReducer } from 'react-router-redux'
import { authStateReducer } from "redux-auth"
import Community from './Community'
import CommunityList from './CommunityList'
import Event from './Event'

export default combineReducers({
  Community,
  CommunityList,
  Event,
  auth: authStateReducer,
  routing: routerReducer
})
