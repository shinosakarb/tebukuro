import { createAction } from 'redux-actions'
import { getCommunities } from '../api/Community'

export const CREATE_COMMUNITIES = 'CREATE_COMMUNITIES'

export const createCommunities = createAction(CREATE_COMMUNITIES, getCommunities)
