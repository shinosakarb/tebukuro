import { Record, Set } from 'immutable'

const CommunityListRecord = Record({
  communities: Set.new()
})

export default class CommunityList extends CommunityListRecord {
  setCommunities(list) {
    return this.set('communities', Set.of(...list))
  }
}
