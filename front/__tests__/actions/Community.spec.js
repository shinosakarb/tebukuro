import configureStore         from 'redux-mock-store'
import thunk                  from 'redux-thunk'
import * as Actions           from '../../client/actions/Community'

jest.mock('../../client/api/Community')

const middlewares = [thunk]
const mockStore = configureStore(middlewares)
let store = mockStore({})

import {showCommunity} from '../../client/api/Community'

describe('Community', () => {
  describe('showCommunity', () => {
    beforeEach(() => {
      store = mockStore({})
    })

    test('normal termination', () => {
      require('../../client/api/Community').__setMockResult(true)
      return store.dispatch(Actions.showCommunity('1'))
        .then(() => {
          const actions = store.getActions()
          expect(actions[0].type).toBe('CREATE_COMMUNITY')
        })
    })

    test('abnormal termination', () => {
      require('../../client/api/Community').__setMockResult(false)
      return store.dispatch(Actions.showCommunity('1'))
        .then(() => {
          const actions = store.getActions()
          expect(actions[0].type).toBe('@@router/CALL_HISTORY_METHOD')
          expect(actions[0].payload.method).toBe('replace')
          expect(actions[0].payload.args[0]).toBe('not_found_url')
        })
    })
  })
})
