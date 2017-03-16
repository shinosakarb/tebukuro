import React               from 'react'
import { Provider }        from 'react-redux'
import configureStore      from 'redux-mock-store'
import thunk               from 'redux-thunk'
import { mount, render }   from 'enzyme'
import ToJson              from 'enzyme-to-json'
import sinon               from 'sinon'

import EventContainer      from '../../client/containers/Event'
import EventComponent      from '../../client/components/Event'
import TicketListComponent from '../../client/components/TicketList'
import EventModel          from '../../client/models/Event'
import TicketModel         from '../../client/models/Ticket'

sinon.spy(EventContainer.prototype, 'componentDidMount')
jest.mock('../../client/api/Event')

const middlewares = [thunk]
const mockStore = configureStore(middlewares)
let store = Object.create(null)
let initialState = {}

const eventParams = {
  id: 1,
  name: 'test',
  description: 'This event is active in Umeda.',
  eventStartsAt: '2017-03-04T13:00:00.000Z',
  eventEndsAt: '2017-03-04T17:00:00.000Z',
  address: 'Hilton Plaza West 12F',
}

const ticketsParams = [ 
  {
    id:            3,
    name:          'ticketName1',
    cost:          4,
    quantity:      5,
    eventId:       1,
    saleStartsAt: '2017-03-01T09:00:00.000Z',
    saleEndsAt:   '2017-03-01T10:30:00.000Z'
  },
  {
    id:            7,
    name:          'ticketName2',
    cost:          8,
    quantity:      9,
    eventId:       1,
    saleStartsAt: '2017-12-11T13:30:00.000Z',
    saleEndsAt:   '2017-12-11T15:00:00.000Z'
  }
]

let eventModel = new EventModel(eventParams)
const ticketListModel = ticketsParams.map((ticket) => new TicketModel(ticket))
eventModel = eventModel.setTickets(ticketListModel)

const routerParams = { eventId: eventModel.id }

describe('Event container', () => {
  beforeEach(() => {
    initialState = { event: eventModel }
    store = mockStore(initialState)
  })

  it('maps event and actions in the store to Event component props', () => {
    const wrapper = mount(
      <Provider store={store}>
        <EventContainer params={ routerParams }/>
      </Provider>
    )

    const eventComponent = wrapper.find(EventComponent)
    const ticketListComponent = wrapper.find(TicketListComponent)

    expect(EventContainer.prototype.componentDidMount.calledOnce).toBe(true)
    expect(eventComponent.prop('event')).toBe(eventModel)
    expect(ticketListComponent.prop('tickets')).toBe(eventModel.tickets)
  })

  it('renders Event and TicketList component', () => {
    const wrapper = render(
      <Provider store={store}>
        <EventContainer />
      </Provider>
    )
    const tree = ToJson(wrapper)
    expect(tree).toMatchSnapshot()
  })
})
