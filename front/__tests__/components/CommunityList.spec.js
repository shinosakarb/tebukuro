import React from 'react'
import CommunityListComponent from '../../client/components/CommunityList'
import CommunityListModel from '../../client/models/CommunityList'
import CommunityModel from '../../client/models/Community'
import renderer from 'react-test-renderer'

describe('CommunityList', () => {
  test('render list', () => {
    const communities = [new CommunityModel({id: 1, name: "name1"}), new CommunityModel({id: 2, name: "name2"})]
    const list = new CommunityListModel({communities: communities})
    const component = renderer.create(
      <CommunityListComponent CommunityList={list} />
    )

    const tree = component.toJSON()
    expect(tree).toMatchSnapshot()
  })
})
