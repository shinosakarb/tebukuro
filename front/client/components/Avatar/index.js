import React from 'react'

const Avatar = ({src}) => {
  const img = src && src.length > 0 ? <img height="20" width="20" src={src} /> : null

  return (
    <span>{img}</span>
  )
}

Avatar.propTypes = {
  src : React.PropTypes.string,
}

export default Avatar
