import { createStore, applyMiddleware } from 'redux'
import { routerMiddleware } from 'react-router-redux'
import TebukuroApp from '../reducers'

export default (preloadState = {}, history) => {
  const middlewares = [
    routerMiddleware(history)
  ]

  return createStore(TebukuroApp, {}, applyMiddleware(...middlewares))
}
