import ApiRequest from './ApiRequest'

export const createCommunityHandler = (name, description) => {
  const communityParams = {
    name: name,
    description: description
  }
  return ApiRequest.post('/communities', communityParams)
}
