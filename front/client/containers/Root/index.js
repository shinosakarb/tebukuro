import React from 'react'
import { Provider } from 'react-redux'
import { Router, Route, IndexRoute } from 'react-router'
import App from '../App'
import Top from '../../components/Top'
import CommunityList from '../CommunityList'
import CreateCommunityForm from '../CreateCommunityForm'

export default class Root extends React.Component {
  static propTypes = {
    history: React.PropTypes.object.isRequired,
    store: React.PropTypes.object.isRequired
  }

  render() {
    const { store, history } = this.props
    return (
      <Provider store={store}>
        <Router history={history}>
          <Route path="/" component={App}>
            <IndexRoute component={Top}/>
            <Route path="communities" component={CommunityList}/>
            <Route path="communities/new" component={CreateCommunityForm}/>
          </Route>
        </Router>
      </Provider>
    )
  }
}
