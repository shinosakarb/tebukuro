import React from 'react'
import { mount } from 'enzyme';
import CommunityForm from '../../client/components/CommunityForm'
import Community from '../../client/models/Community'
import renderer from 'react-test-renderer'

describe('CommunityForm', () => {
  it('render form', () => {
    const onSubmitMock = jest.fn()

    const component = renderer.create(
      <CommunityForm onSubmit={onSubmitMock} community={new Community()}/>
    )

    let tree = component.toJSON()
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
