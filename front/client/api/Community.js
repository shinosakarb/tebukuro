import ApiRequest from './ApiRequest'
import request from 'superagent'

export const createCommunityHandler = (name, description) => {
  const communityParams = {
    name: name,
    description: description
  }
  return ApiRequest.post('/communities', communityParams)
}

export const showCommunity = (id) => {
  return ApiRequest.get('/communities/' + id.toString())
}

export const getCommunities = () => {
  return request.get(`${Config.ApiEndPoint}/communities.json`)
    .then(res => res.body)
}
