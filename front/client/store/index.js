import { createStore, applyMiddleware } from 'redux'
import { routerMiddleware } from 'react-router-redux'
import TebukuroApp from '../reducers'

export default (preloadState = {}, history) => {
  return createStore(TebukuroApp, {}, applyMiddleware(routerMiddleware(history)))
}
