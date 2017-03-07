import { createAction } from 'redux-actions'
import configureStore from 'redux-mock-store'
import thunk          from 'redux-thunk'
import ActionDispatch from '../../client/utils/ActionDispatch'

const middlewares = [thunk]
const mockStore = configureStore(middlewares)
let store = Object.create(null)

const mockAction = createAction('CREATE_TEST')
const mockApi = (params) => params ? Promise.resolve() : Promise.reject()
const mockErrorUrl = 'mock_error_url'
const action = (params) => ActionDispatch.executeApi(mockApi, params, mockAction, mockErrorUrl)

describe('ActionDispatch', () => {
  describe('executeApi', () => {
    beforeEach(() => store = mockStore({}) )

    test('normal termination', () => {
      return store.dispatch(action(true))
        .then(() => {
          const actions = store.getActions()
          expect(actions[0].type).toBe('CREATE_TEST')
      })
    })

    test('abnormal termination', () => {
      return store.dispatch(action(false))
        .then(() => {
          const actions = store.getActions()
          expect(actions[0].type).toBe('@@router/CALL_HISTORY_METHOD')
          expect(actions[0].payload.method).toBe('replace')
          expect(actions[0].payload.args[0]).toBe(mockErrorUrl)
      })
    })
  })
})
