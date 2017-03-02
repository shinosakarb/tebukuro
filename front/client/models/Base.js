import { Record as originRecord } from 'immutable'

export default (args = {}) => {
  const base = originRecord({errors: [], ...args})

  return class BaseClass extends base {
    isError() {
      return this.errors.length !== 0
    }
  }
}
