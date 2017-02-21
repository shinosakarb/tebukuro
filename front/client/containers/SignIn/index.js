import React from 'react'
import { connect } from 'react-redux'
import OAuth from '../../components/OAuth'

const mapStateToProps = (state, ownProps) => {
  return {
    auth: state.auth
  }
}

export default connect(mapStateToProps, {})(OAuth)
