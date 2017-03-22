import _ from 'lodash' 

const convertKeys  = (dict, converter) => {
  return _.mapKeys(dict, (v, k) => converter(k))
}

const ConvertCase = {
  camelKeysOf(dict){
    return convertKeys(dict, _.camelCase)
  },

  snakeKeysOf(dict){
    return convertKeys(dict, _.snakeCase)
  }
}

export default ConvertCase
