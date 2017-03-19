import React              from 'react'
import { mount, shallow } from 'enzyme'
import ToJson             from 'enzyme-to-json'
import { Event }          from '../../client/containers/Event'
import EventModel         from '../../client/models/Event'
import TicketModel        from '../../client/models/Ticket'

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

const props = {
  event:   eventModel,
  params:  { eventId: eventModel.id },
  actions: { showEvent: jest.fn() }
}

describe('Event container', () => {

  it('should call showEvent in componentDidMount once', () => {
    const wrapper = mount(<Event {...props} />)
    expect(props.actions.showEvent).toHaveBeenCalledTimes(1)
  })

  it('should render self and subcomponents', () => {
    const wrapper = shallow(<Event {...props} />)
    const tree = ToJson(wrapper)
    expect(tree).toMatchSnapshot()
  })
})
