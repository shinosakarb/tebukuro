import React          from 'react'
import { shallow }    from 'enzyme'
import shallowToJson  from 'enzyme-to-json'
import CommunityModel from '../../client/models/Community'
import Community      from '../../client/components/Community'
import Params         from '../factories/Community'

const model = (params) => {
  return new CommunityModel(params)
}

describe('Community', () => {
  it('render community component', () => {
    const component = shallow(
      <Community community={ model(Params.community1) } />
    )

    const tree = shallowToJson(component)
    expect(tree).toMatchSnapshot()
  })
})
