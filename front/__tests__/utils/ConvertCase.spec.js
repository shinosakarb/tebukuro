import ConvertCase from '../../client/utils/ConvertCase'

describe('ConvertCase', () => {
  const camelKeysParams = {
    name: 'name',
    eventStartsAt: '2017-03-04 13:00',
    eventEndsAt: '2017-03-04 17:00'
  }

  const snakeKeysParams = {
    name: 'name',
    event_starts_at: '2017-03-04 13:00',
    event_ends_at: '2017-03-04 17:00'
  }

  describe('camelKeysOf', () => {
    it('converts snake case to camel case', () => {
      expect(ConvertCase.camelKeysOf(snakeKeysParams)).toEqual(camelKeysParams)
    })
  })

  describe('snakeKeysOf', () => {
    it('converts snake case to camel case', () => {
      expect(ConvertCase.snakeKeysOf(camelKeysParams)).toEqual(snakeKeysParams)
    })
  })
})
