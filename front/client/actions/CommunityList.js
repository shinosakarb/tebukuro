import { createAction } from 'redux-actions'
import { getCommunities } from '../api/Community'
import Actions from '../constants/Actions'

export const createCommunities = createAction(Actions.CommunityList.createCommunities, getCommunities)
