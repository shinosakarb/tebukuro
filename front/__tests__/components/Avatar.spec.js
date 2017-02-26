import React from 'react'
import AvatarComponent from '../../client/components/Avatar'
import {shallow} from 'enzyme'
import toJson from 'enzyme-to-json'

describe('Avatar', () => {
  const subject = (src) => (shallow(<AvatarComponent src={src} />))

  test('render Avatar', () => {
    const src = 'example.png'
    expect(toJson(subject(src))).toMatchSnapshot()
  })

  test('not render Avatar', () => {
    const src = undefined
    expect(toJson(subject(src))).toMatchSnapshot()
  })
})
