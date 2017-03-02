import React from 'react'
import RouteUrls from '../../constants/RouteUrls'
import { Link } from 'react-router'

const Top = () => {
  return (
    <div>
      <div>tebukuro top sample</div>

      <Link to={RouteUrls.communities}>Community List</Link>
    </div>
  )
}

export default Top
