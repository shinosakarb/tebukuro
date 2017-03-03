import { Record as originRecord } from 'immutable'

export default (args = {}) => {
  const base = originRecord({errors: [], ...args})

  return class BaseClass extends base {
    isError() {
      return this.errors.length !== 0
    }

    isEndedBy(sttribute) {
      // TODO It depends on the local machine
      return this.makeDateWith(sttribute) ? (new Date()).getTime() > this.makeDateWith(sttribute).getTime() : false
    }

    isStartingBy(sttribute) {
      // TODO It depends on the local machine
      return this.makeDateWith(sttribute) ? (new Date()).getTime() >= this.makeDateWith(sttribute).getTime() : false
    }

    makeDateWith(attribute) {
      return this.get(attribute) && this.get(attribute).length > 0 ? new Date(this.get(attribute)) : null
    }
  }
}
