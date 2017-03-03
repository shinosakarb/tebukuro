import Base from '../../client/models/Base'
import MockDate from 'mockdate'

const subjectClass = (params) => {
  const klass = Base(params)
  return new klass()
}

describe('Base', () => {
  describe('isError', () => {
    describe('when error is not empty', () => {
      it('should return true', () => {
        const subject = subjectClass({ errors: ['error'] })
        expect(subject.isError()).toBe(true)
      })
    })

    describe('when error is empty', () => {
      it('should return false', () => {
        const subject = subjectClass({ errors: [] })
        expect(subject.isError()).toBe(false)
      })
    })
  })

  describe('isEndedBy', () => {
    beforeAll(() => {
      MockDate.set(new Date('2017/03/02 09:00:00'))
    })

    test('non existent attribute', () => {
      const subject = subjectClass({eventEndsAt: '2017/03/02 08:59:59'})
      expect(subject.isEndedBy('eventStartsAt')).toBe(false)
    })

    test('event termination', () => {
      const subject = subjectClass({eventEndsAt: '2017/03/02 08:59:59'})
      expect(subject.isEndedBy('eventEndsAt')).toBe(true)
    })

    test('before the event ends',() => {
      const subject = subjectClass({eventEndsAt: '2017/03/02 09:00:00'})
      expect(subject.isEndedBy('eventEndsAt')).toBe(false)
    })
  })

  describe('isStartingBy', () => {
    beforeAll(() => {
      MockDate.set(new Date('2017/03/02 09:00:00'))
    })

    test('non existent attribute', () => {
      const subject = subjectClass({eventStartsAt: '2017/03/02 09:00:00'})
      expect(subject.isStartingBy('eventEndsAt')).toBe(false)
    })

    test('event termination', () => {
      const subject = subjectClass({eventStartsAt: '2017/03/02 09:00:00'})
      expect(subject.isStartingBy('eventStartsAt')).toBe(true)
    })

    test('before the event ends',() => {
      const subject = subjectClass({eventStartsAt: '2017/03/02 09:00:01'})
      expect(subject.isStartingBy('eventStartsAt')).toBe(false)
    })
  })

  describe('makeDateWith', () => {
    test('non existent attribute', () => {
      const subject = subjectClass({eventStartsAt: ''})
      expect(subject.makeDateWith('eventEndsAt')).toBeNull()
    })

    test('blank eventStartsAt', () => {
      const subject = subjectClass({eventStartsAt: ''})
      expect(subject.makeDateWith('eventStartsAt')).toBeNull()
    })

    test('presence eventStartsAt', () => {
      const subject = subjectClass({eventStartsAt: '2017/03/02 09:00:00'})
      expect(subject.makeDateWith('eventStartsAt').getTime()).toBe((new Date('2017/03/02 09:00:00')).getTime())
    })
  })
})
