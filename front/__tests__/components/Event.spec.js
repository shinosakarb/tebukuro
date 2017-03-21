import React         from 'react'
import { shallow }   from 'enzyme'
import shallowToJson from 'enzyme-to-json'
import EventModel    from '../../client/models/Event'
import Event         from '../../client/components/Event'
import Params        from '../factories/Event'

const model = (params) => {
  return new EventModel(params)
}

describe('Event', () => {
  it('render event component', () => {
    const component = shallow(
      <Event event={ model(Params.event1) } />
    )

    const tree = shallowToJson(component)
    expect(tree).toMatchSnapshot()
  })
})
