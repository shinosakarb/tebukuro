import React from 'react'
import CommunityForm from '../../../client/components/CommunityForm'
import renderer from 'react-test-renderer'

describe('CommunityForm', () => {
  it('render form', () => {
    const component = renderer.create(
      <CommunityForm />
    )

    let tree = component.toJSON()
    expect(tree).toMatchSnapshot()
  })
})
