import React              from 'react'
import { mount, shallow } from 'enzyme'
import ToJson             from 'enzyme-to-json'
import { Event }          from '../../client/containers/Event'
import EventModel         from '../../client/models/Event'
import TicketModel        from '../../client/models/Ticket'
import EventParams        from '../factories/Event'
import TicketParams       from '../factories/Ticket'

const eventParams = EventParams.event1
const ticketsParams = [ TicketParams.ticket1, TicketParams.ticket2 ]

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
