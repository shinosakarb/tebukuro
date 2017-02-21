import React, { Component } from 'react'
import SignIn from '../SignIn'

export default class App extends Component {
  render() {
    return (
      <div>
        <SignIn />
        {this.props.children}
      </div>
    )
  }
}
