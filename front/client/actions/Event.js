import { createAction } from 'redux-actions'
import { createEvent as createAPI, showEvent as showAPI } from '../api/Event'
import Actions from '../constants/Actions'
import errorUrls from '../constants/ErrorUrls'
import ActionDispatch from '../utils/ActionDispatch'

export const createEvent = createAction(Actions.Event.createEvent, createAPI)

export const showEvent = (id) => {
  return ActionDispatch.executeApi(showAPI, id, createAction(Actions.Event.createEvent), errorUrls.pageNotFound)
}
