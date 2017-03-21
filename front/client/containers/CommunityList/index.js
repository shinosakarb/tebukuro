import React, { Component }   from 'react'
import { connect }            from 'react-redux'
import { bindActionCreators } from 'redux'
import { Link }               from 'react-router'
import * as Actions           from '../../actions/CommunityList'
import CommunityListTable     from '../../components/CommunityList'

export class CommunityList extends Component {
  componentDidMount() {
    this.props.actions.createCommunities()
  }

  render() {
    return (
      <div>
        <CommunityListTable CommunityList={this.props.communityList} />

        <Link to="/communities/new">new</Link>
      </div>
    )
  }
}

const mapStateToProps = (state) => {
  return {
    communityList: state.CommunityList
  }
}

const mapDispatchToProps = (dispatch) => {
  return {
    actions: bindActionCreators(Actions, dispatch)
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(CommunityList)
