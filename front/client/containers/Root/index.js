import React from 'react'
import { Provider } from 'react-redux'
import { Router, Route, IndexRoute } from 'react-router'
import RouteUrls from '../../constants/RouteUrls'
import App from '../App'
import Top from '../../components/Top'
import CommunityList from '../CommunityList'
import CreateCommunityForm from '../CommunityForm'
import Event from '../Event'
import PageNotFound from '../../components/PageNotFound'

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
            <Route path={RouteUrls.communities} component={CommunityList}/>
            <Route path={RouteUrls.newCommunity} component={CreateCommunityForm}/>
            <Route path={RouteUrls.community}/>
            <Route path={RouteUrls.editCommunity}/>
            <Route path={RouteUrls.events}/>
            <Route path={RouteUrls.newEvent}/>
            <Route path={RouteUrls.event} component={Event}/>
            <Route path={RouteUrls.editEvent}/>
          </Route>
          <Route path="*" component={PageNotFound} />
        </Router>
      </Provider>
    )
  }
}
