import ApiRequest from './ApiRequest'
import request from 'superagent'
import RequestUrls from '../constants/RequestUrls'

export const createCommunity = (name, description) => {
  const communityParams = {
    name: name,
    description: description
  }
  return ApiRequest.post(RequestUrls.communities, communityParams)
}

export const getCommunities = () => {
  return request.get(`${Config.ApiEndPoint}${RequestUrls.communities}`)
    .then(res => res.body)
}
