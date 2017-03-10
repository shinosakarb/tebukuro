import React, { Component }   from 'react'
import { connect }            from 'react-redux'
import { bindActionCreators } from 'redux'
import * as Actions           from '../../actions/Event'
import EventComponent         from '../../components/Event'
import TicketListComponent    from '../../components/TicketList'

export class Event extends Component {
  render() {
    return (
      <div>
        event page sample
        <EventComponent event={ this.props.event } />
        <TicketListComponent tickets={ this.props.event.tickets } />
      </div>
    )
  }
}

const mapStateToProps = (state) => {
  return {
    event: state.event
  }
}

const mapDispatchToProps = (dispatch) => {
  return {
    actions: bindActionCreators(Actions, dispatch)
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(Event)
