import RequestUrls from '../constants/RequestUrls'
import ApiClient from '../utils/ApiClient'

export const createEvent = (params) => {
  return ApiClient.post(`${RequestUrls.communityEvents(params.community_id)}`, params)
}

export const getEvents = (communityId) => {
  return ApiClient.get(`${RequestUrls.communityEvents(communityId)}`)
}

export const showEvent = (id) => {
  return ApiClient.get(`${RequestUrls.events}/${id}`)
}

export const editEvent = (params) => {
  return ApiClient.patch(`${RequestUrls.events}/${params.id}`, params)
}

export const deleteEvent = (id) => {
  return ApiClient.delete(`${RequestUrls.events}/${id}`)
}
