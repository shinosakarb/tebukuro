import RequestUrls from '../constants/RequestUrls'
import ApiClient from '../utils/ApiClient'

export const createCommunity = (name, description) => {
  const communityParams = {
    name: name,
    description: description
  }
  return ApiClient.post(RequestUrls.communities, communityParams)
}

export const getCommunities = () => {
  return ApiClient.get(RequestUrls.communities)
}
