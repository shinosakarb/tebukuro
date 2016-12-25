import React from 'react'
import ReactDOM from 'react-dom'
import { AppContainer } from 'react-hot-loader'
import store from './store'
import App from './containers/App'
import { Provider } from 'react-redux'

ReactDOM.render(
  <Provider store={store}>
    <AppContainer>
      <App/>
    </AppContainer>
  </Provider>,
  document.getElementById('root')
)

if (module.hot) {
  module.hot.accept('./containers/App', () => {
    const NextApp = require('./containers/App').default
    ReactDOM.render(
      <Provider store={store}>
        <AppContainer>
          <NextApp/>
        </AppContainer>
      </Provider>,
      document.getElementById('root')
    )
  })
}
