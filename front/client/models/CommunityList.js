import { Record, Set } from 'immutable'

export const CommunityListRecord = Record({
  communities: Set.of()
})

export default class CommunityList extends CommunityListRecord {
  setCommunities(list) {
    return this.set('communities', Set.of(...list))
  }
}
