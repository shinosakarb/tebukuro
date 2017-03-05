import React, { Component } from 'react'

export default class Event extends Component {
  render() {
    return (
      <div>
        <p>name: { this.props.event.name }</p>
        <p>eventStartsAt: { this.props.event.eventStartsAt }</p>
        <p>eventEndsAt: { this.props.event.eventEndsAt }</p>
        <p>description: { this.props.event.description }</p>
        <p>address: { this.props.event.address }</p>
      </div>
    )
  }
}

Event.propTypes = {
  event: React.PropTypes.object.isRequired
}
