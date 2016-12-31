import { combineReducers } from 'redux'
import { routerReducer } from 'react-router-redux'
import Community from './Community'

export default combineReducers({
  Community,
  routing: routerReducer
})
