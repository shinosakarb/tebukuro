import Community from '../../client/models/Community'

describe('Community', () => {
  describe('isError', () => {
    describe('when error is not empty', () => {
      it('should return true', () => {
        const subject = new Community({ errors: ['error'] })
        expect(subject.isError()).toBe(true)
      })
    })

    describe('when error is empty', () => {
      it('should return false', () => {
        const subject = new Community({ errors: [] })
        expect(subject.isError()).toBe(false)
      })
    })
  })
})
