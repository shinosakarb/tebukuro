import React, { Component } from 'react'

export default class Community extends Component {
  render() {
    return (
      <div>
        <p>name: { this.props.community.name }</p>
        <p>description: { this.props.community.description }</p>
      </div>
    )
  }
}

Community.propTypes = {
  community: React.PropTypes.object.isRequired
}
