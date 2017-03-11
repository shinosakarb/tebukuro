import React     from 'react'

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
  tickets: React.PropTypes.arrayOf(React.PropTypes.object).isRequired
}

export default TicketList
