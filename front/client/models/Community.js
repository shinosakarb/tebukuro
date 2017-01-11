import { Record } from 'immutable'

export const CommunityRecord = Record({
  id:           0,
  name:         '',
  description:  ''
})

export default class Community extends CommunityRecord {
}
