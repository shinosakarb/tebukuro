import React from 'react'
import {Map} from 'immutable'
import OAuthComponent from '../../client/components/OAuth'
import {shallow} from 'enzyme'
import toJson from 'enzyme-to-json'

describe('OAuth', () => {
  const subject = (auth) => (shallow(<OAuthComponent auth={auth} />))

  test('render Signin', () => {
    const auth = Map({user: Map({isSignedIn: true, attributes: Map({image: 'example.png'})})})
    expect(toJson(subject(auth))).toMatchSnapshot()
  })

  test('render Signout', () => {
    const auth = Map({user: Map({isSignedIn: false})})
    expect(toJson(subject(auth))).toMatchSnapshot()
  })
})
