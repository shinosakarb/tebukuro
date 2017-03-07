import { routerActions } from 'react-router-redux'

const ActionDispatch = {
  executeApi(api, apiParams, action, errorUrl){
    return dispatch => {
      return api(apiParams)
        .then(json => dispatch(action(json)))
        .catch(() => dispatch(routerActions.replace(errorUrl)))
    }
  },
}

export default ActionDispatch
