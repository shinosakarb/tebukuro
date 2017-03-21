import React         from 'react'
import { Set }       from 'immutable'
import { shallow }   from 'enzyme'
import shallowToJson from 'enzyme-to-json'
import TicketModel   from '../../client/models/Ticket'
import TicketList    from '../../client/components/TicketList'
import Params        from '../factories/Ticket'

const model = (params) => {
  return new TicketModel(params)
}
const ticketsParams = [ Params.ticket1, Params.ticket2 ]

describe('TicketList', () => {
  it('render list of tickets', () => {
    const ticketsModel = ticketsParams.map((params) => model(params))
    const ticketsSet = Set.of(...ticketsModel) 

    const component = shallow(<TicketList tickets={ ticketsSet } />)

    const tree = shallowToJson(component)
    expect(tree).toMatchSnapshot()
  })
})
