import React     from 'react'
import { Set }   from 'immutable'

const TicketList = ({tickets}) => {
  return (
    <ul>
      {
        tickets.map((ticket) => {
          return (
            <li key={ ticket.id }>
              <p>name: { ticket.name }</p>
              <p>cost: { ticket.cost }</p>
              <p>quantity: { ticket.quantity }</p>
              // TODO: These Date object strings should be formatted.
              <p>saleStartsAt: { ticket.formatDateWith('saleStartsAt') }</p>
              <p>saleEndsAt: { ticket.formatDateWith('saleEndsAt') }</p>
            </li>
          )
        })
      }
    </ul>
  )
}

TicketList.propTypes = {
  tickets: React.PropTypes.instanceOf(Set).isRequired
}

export default TicketList
