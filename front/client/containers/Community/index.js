import React from 'react'
import { connect } from 'react-redux'
import { showCommunity } from '../../actions/Community'
import Community from '../../components/Community'

const mapStateToProps = (state, ownProps) => {
  return {
    community: state.Community
  }
}

const mapDispatchToProps = (dispatch) => {
  return {
    // onSubmit: (name, description) => {
    //   dispatch(createCommunity(name, description))
    // }
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(Community)
