import React from 'react'
import CommunityModel from '../../client/models/Community'
import Community from '../../client/components/Community'
import renderer from 'react-test-renderer'

const model = (params) => {
  return new CommunityModel(params)
}

describe('Community', () => {
  it('render community component', () => {
    const communityParams = {
      name: 'shinosaka.rb',
      description: 'This community is active in shinosaka.'
    }

    const component = renderer.create(
      <Community community={ model(communityParams) } />
    )

    const tree = component.toJSON()
    expect(tree).toMatchSnapshot()
  })
})
