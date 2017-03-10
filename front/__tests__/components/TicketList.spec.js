import React from 'react'
import { shallow } from 'enzyme'
import shallowToJson from 'enzyme-to-json'
import TicketModel from '../../client/models/Ticket'
import TicketList from '../../client/components/TicketList'

const model = (params) => {
  return new TicketModel(params)
}

describe('TicketList', () => {
  it('render list of tickets', () => {
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

    const tickets = ticketsParams.map((params) => model(params))

    const component = shallow(<TicketList tickets={ tickets } />)

    const tree = shallowToJson(component)
    expect(tree).toMatchSnapshot()
  })
})
