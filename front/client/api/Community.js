import RequestUrls from '../constants/RequestUrls'
import ApiClient from '../utils/ApiClient'

export const createCommunity = (params) => {
  return ApiClient.post(RequestUrls.communities, params)
}

export const getCommunities = () => {
  return ApiClient.get(RequestUrls.communities)
}

export const showCommunity = (id) => {
  return ApiClient.get(`${RequestUrls.communities}/${id}`)
}
