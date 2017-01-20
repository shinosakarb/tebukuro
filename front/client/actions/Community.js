import { createAction } from 'redux-actions'
import  * as CommunityAPI from '../api/Community'

export const CREATE_COMMUNITY = 'CREATE_COMMUNITY'
export const SHOW_COMMUNITY   = 'SHOW_COMMUNITY'

export const createCommunity = createAction(CREATE_COMMUNITY, CommunityAPI.createCommunityHandler)
export const showCommunity   = createAction(SHOW_COMMUNITY, CommunityAPI.showCommunity)
