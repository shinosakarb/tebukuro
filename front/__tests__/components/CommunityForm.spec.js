import React from 'react'
import { mount, shallow } from 'enzyme'
import toJson from 'enzyme-to-json'
import CommunityForm from '../../client/components/CommunityForm'
import Community from '../../client/models/Community'

describe('CommunityForm', () => {
  it('render form', () => {
    const onSubmitMock = jest.fn()

    const component = shallow(
      <CommunityForm onSubmit={onSubmitMock} community={new Community()}/>
    )

    let tree = toJson(component)
    expect(tree).toMatchSnapshot()
  })

  describe('props onSubmit', () => {
    let renderedForm
    let onSubmitMock

    beforeEach(() => {
      onSubmitMock = jest.fn()

      renderedForm = mount(
        <CommunityForm onSubmit={onSubmitMock} community={new Community()} />
      )
    })

    describe('when submit', () => {
      beforeEach(() => {
        renderedForm.find('[type="submit"]').get('0').click()
      })

      it('should execute onSubmit function', () => {
        expect(onSubmitMock).toBeCalled()
      })
    })
  })

  describe('when error', () => {
    let renderedForm

    beforeEach(() => {
      renderedForm = mount(
        <CommunityForm onSubmit={() => {}} community={new Community({errors: ['error']})} />
      )
    })

    it('should exists error claass dom', () => {
      expect(renderedForm.find('.error p').length).toEqual(1)
    })
  })
})
