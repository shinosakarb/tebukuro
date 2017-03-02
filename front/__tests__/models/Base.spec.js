import Base from '../../client/models/Base'

describe('Base', () => {
  describe('isError', () => {
    describe('when error is not empty', () => {
      it('should return true', () => {
        const klass = Base({ errors: ['error'] })
        const subject = new klass()
        expect(subject.isError()).toBe(true)
      })
    })

    describe('when error is empty', () => {
      it('should return false', () => {
        const klass = Base({ errors: [] })
        const subject = new klass()
        expect(subject.isError()).toBe(false)
      })
    })
  })
})
