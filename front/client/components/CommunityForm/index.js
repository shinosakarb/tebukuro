import React, { Component } from 'react'

const onErrorComponent = (community) => {
  if (community.isError()) {
    let errors = []

    community.errors.forEach((error) => {
      errors.push(<p key={ error }>{error}</p>)
    })

    return <div className="error">{ errors }</div>
  }
}

export default class CommunityForm extends Component {
  onSubmitHandler(e) {
    e.preventDefault()
    const params = {
      name: this.refs.inputName.value,
      description: this.refs.inputDescription.value
    }
    this.props.onSubmit(params)
  }

  render() {
    return (
      <div>
        <h3>create community form</h3>
        { onErrorComponent(this.props.community) }
        <form onSubmit={ this.onSubmitHandler.bind(this) }>
          <div>
            <label>
              name
              <input type="text" ref="inputName" />
            </label>
          </div>
          <div>
            <label>
              description
              <textarea ref="inputDescription" />
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

CommunityForm.propTypes = {
  onSubmit: React.PropTypes.func.isRequired,
  community: React.PropTypes.object.isRequired
}
