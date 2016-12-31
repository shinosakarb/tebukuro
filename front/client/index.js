import React from 'react'
import ReactDOM from 'react-dom'
import { AppContainer } from 'react-hot-loader'
import configureStore from './store'
import { browserHistory } from 'react-router'
import { syncHistoryWithStore } from 'react-router-redux'
import Root from './containers/Root'

const state = {}
const store = configureStore(state, browserHistory)
const history = syncHistoryWithStore(browserHistory, store)

const renderApp = (RootComponent) => {
  ReactDOM.render(
    <AppContainer>
      <RootComponent store={store} history={history} />
    </AppContainer>,
    document.getElementById('root')
  )
}

renderApp(Root)

if (module.hot) {
  module.hot.accept('./containers/Root', () => {
    renderApp(require('./containers/Root').default)
  })
}
