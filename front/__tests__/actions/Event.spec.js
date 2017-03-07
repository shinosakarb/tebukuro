import configureStore from 'redux-mock-store'
import thunk          from 'redux-thunk'
import * as Actions   from '../../client/actions/Event'
import {showEvent}    from '../../client/api/Event'
import errorUrls from '../../client/constants/ErrorUrls'

jest.mock('../../client/api/Event')

const middlewares = [thunk]
const mockStore = configureStore(middlewares)
let store = Object.create(null)

describe('Event', () => {
  describe('showEvent', () => {
    beforeEach(() => {
      store = mockStore({})
    })

    test('normal termination', () => {
      require('../../client/api/Event').__setMockResult(true)
      return store.dispatch(Actions.showEvent('1'))
        .then(() => {
          const actions = store.getActions()
          expect(actions[0].type).toBe('CREATE_EVENT')
        })
    })

    test('abnormal termination', () => {
      require('../../client/api/Event').__setMockResult(false)
      return store.dispatch(Actions.showEvent('1'))
        .then(() => {
          const actions = store.getActions()
          expect(actions[0].payload.args[0]).toBe(errorUrls.pageNotFound)
        })
    })
  })
})
