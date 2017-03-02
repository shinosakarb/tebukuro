import Event from '../../client/models/Event'
import MockDate from 'mockdate'

describe('Event', () => {
  describe('isEnd', () => {
    beforeAll(() => {
      MockDate.set(new Date('2017/03/02 09:00:00'))
    })
    test('event termination', () => {
      const subject = new Event({eventEndsAt: '2017/03/02 08:59:59'})
      expect(subject.isEnd()).toBe(true)
    })
    test('before the event ends',() => {
      const subject = new Event({eventEndsAt: '2017/03/02 09:00:00'})
      expect(subject.isEnd()).toBe(false)
    })
  })

  describe('convertEventStartsAtToDate', () => {
    test('blank eventStartsAt', () => {
      const subject = new Event({eventStartsAt: ''})
      expect(subject.convertEventStartsAtToDate()).toBeNull()
    })
    test('presence eventStartsAt', () => {
      const subject = new Event({eventStartsAt: '2017/03/02 09:00:00'})
      expect(subject.convertEventStartsAtToDate().getTime()).toBe((new Date('2017/03/02 09:00:00')).getTime())
    })
  })
  describe('convertEventEndsAtToDate', () => {
    test('blank eventEndsAt', () => {
      const subject = new Event({eventEndsAt: ''})
      expect(subject.convertEventEndsAtToDate()).toBeNull()
    })
    test('presence eventEndsAt', () => {
      const subject = new Event({eventEndsAt: '2017/03/02 09:00:01'})
      expect(subject.convertEventEndsAtToDate().getTime()).toBe((new Date('2017/03/02 09:00:01')).getTime())
    })
  })
})
