import { Record } from 'immutable'

export const CommunityRecord = Record({
  id:           0,
  name:         '',
  description:  '',
  errors:       []
})

export default class Community extends CommunityRecord {
  isError() {
    return this.errors.length !== 0
  }
}
