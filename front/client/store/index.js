import { createStore, applyMiddleware, compose } from 'redux'
import { routerMiddleware } from 'react-router-redux'
import promiseMiddleware from 'redux-promise'
import TebukuroApp from '../reducers'

import Immutable from 'immutable'
import { Records } from '../models'

export default (preloadState = {}, history) => {
  const middlewares = [
    routerMiddleware(history),
    promiseMiddleware
  ]

  const composeEnhancers =
    process.env.NODE_ENV !== 'production' &&
    typeof window === 'object' &&
    window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ ?
      window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__({
        serialize: {
          immutable: Immutable,
          refs: Records
        }
      }) : compose

  const enhancer = composeEnhancers(applyMiddleware(...middlewares))

  const store = createStore(TebukuroApp, {}, enhancer)

  if (module.hot) {
    module.hot.accept('../reducers', () =>
      store.replaceReducer(require('../reducers').default)
    )
  }

  return store
}
