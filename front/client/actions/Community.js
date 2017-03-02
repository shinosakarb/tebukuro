import { createAction } from 'redux-actions'
import { routerActions } from 'react-router-redux'
import { createCommunity as createAPI, showCommunity as showAPI } from '../api/Community'
import Actions from '../constants/Actions'

export const createCommunity = createAction(Actions.Community.createCommunity, createAPI)

export const showCommunity = (id) => {
  return dispatch => {
    return showAPI(id)
      .then(json => dispatch(createCommunity(json)))
      .catch(() => dispatch(routerActions.replace("not_found_url")))
  }
}
