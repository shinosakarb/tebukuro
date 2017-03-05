import React from 'react'
import { shallow } from 'enzyme'
import shallowToJson from 'enzyme-to-json'
import EventModel from '../../client/models/Event'
import Event from '../../client/components/Event'

const model = (params) => {
  return new EventModel(params)
}

describe('Event', () => {
  it('render event component', () => {
    const eventParams = {
      name: 'rubykansai#77',
      eventStartsAt: '2017-03-04 13:00',
      eventEndsAt: '2017-03-04 17:00',
      description: 'This event is active in Umeda.',
      address: 'Hilton Plaza West 12F'
    }

    const component = shallow(
      <Event event={ model(eventParams) } />
    )

    const tree = shallowToJson(component)
    expect(tree).toMatchSnapshot()
  })
})
