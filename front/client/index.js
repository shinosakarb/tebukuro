import React from 'react'
import ReactDOM from 'react-dom'
import { configure } from 'redux-auth'
import { AppContainer } from 'react-hot-loader'
import configureStore from './store'
import { browserHistory } from 'react-router'
import { syncHistoryWithStore } from 'react-router-redux'
import Root from './containers/Root'
import RequestUrls from './constants/RequestUrls'

const state = {}
const store = configureStore(state, browserHistory)
const history = syncHistoryWithStore(browserHistory, store)

const renderApp = (RootComponent) => {
  store.dispatch(configure({
      apiUrl              : Config.ApiEndPoint,
      authProviderPaths   : {
        github    : RequestUrls.auth.github,
        facebook  : RequestUrls.auth.facebook,
        twitter   : RequestUrls.auth.twitter
    }
  },{clientOnly: true, cleanSession: false})).then(
    ReactDOM.render(
      <AppContainer>
        <RootComponent store={store} history={history} />
      </AppContainer>,
      document.getElementById('root')
    )
  )
}

renderApp(Root)

if (module.hot) {
  module.hot.accept('./containers/Root', () => {
    renderApp(require('./containers/Root').default)
  })
}
