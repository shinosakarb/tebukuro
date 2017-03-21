import React              from 'react'
import { mount, shallow } from 'enzyme'
import ToJson             from 'enzyme-to-json'
import { CommunityList }  from '../../client/containers/CommunityList'
import CommunityModel     from '../../client/models/Community'
import CommunityListModel from '../../client/models/CommunityList'

const communities = [new CommunityModel({id: 1, name: "name1"}), new CommunityModel({id: 2, name: "name2"})]
const communityList = new CommunityListModel({communities: communities})

const props = {
  communityList: communityList,  
  actions: { createCommunities: jest.fn() }
}

describe('CommunityList container', () => {

  it('should call createCommunities in componentDidMount once', () => {
    const wrapper = mount(<CommunityList {...props} />)
    expect(props.actions.createCommunities).toHaveBeenCalledTimes(1)
  })

  it('should render self and a subcomponent', () => {
    const wrapper = shallow(<CommunityList {...props} />)
    const tree = ToJson(wrapper)
    expect(tree).toMatchSnapshot()
  })
})
