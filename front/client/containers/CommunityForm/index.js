import React from 'react'
import { connect } from 'react-redux'
import { createCommunity } from '../../actions/Community'
import CommunityForm from '../../components/CommunityForm'

const mapStateToProps = (state, ownProps) => {
  return {
    community: state.Community
  }
}

const mapDispatchToProps = (dispatch) => {
  return {
    onSubmit: (params) => {
      dispatch(createCommunity(params))
    }
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(CommunityForm)
