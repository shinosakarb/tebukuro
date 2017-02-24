import React from 'react'
import { shallow } from 'enzyme'
import shallowToJson from 'enzyme-to-json'
import CommunityModel from '../../client/models/Community'
import Community from '../../client/components/Community'

const model = (params) => {
  return new CommunityModel(params)
}

describe('Community', () => {
  it('render community component', () => {
    const communityParams = {
      name: 'shinosaka.rb',
      description: 'This community is active in shinosaka.'
    }

    const component = shallow(
      <Community community={ model(communityParams) } />
    )

    const tree = shallowToJson(component)
    expect(tree).toMatchSnapshot()
  })
})
