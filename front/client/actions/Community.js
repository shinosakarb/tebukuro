import { createAction } from 'redux-actions'
import { createCommunityHandler } from '../api/Community'

export const CREATE_COMMUNITY = 'CREATE_COMMUNITY'

export const createCommunity = createAction(CREATE_COMMUNITY, createCommunityHandler)
