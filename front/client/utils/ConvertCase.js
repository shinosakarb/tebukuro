import _ from 'lodash' 

const ConvertCase = {
  convertKeys(dict, converter){
    return _.mapKeys(dict, (v, k) => converter(k))
  },

  camelKeysOf(dict){
    return this.convertKeys(dict, _.camelCase)
  },

  snakeKeysOf(dict){
    return this.convertKeys(dict, _.snakeCase)
  }
}

export default ConvertCase
