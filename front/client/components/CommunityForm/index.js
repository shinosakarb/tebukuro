import React, { Component } from 'react'

export default class CommunityForm extends Component {
  render() {
    return (
      <div>
        <h3>create community form</h3>
        <form>
          <div>
            <label>
              name
              <input type="text" />
            </label>
          </div>
          <div>
            <label>
              description
              <textarea />
            </label>
          </div>
          <div>
            <input type="submit" />
          </div>
        </form>
      </div>
    )
  }
}
