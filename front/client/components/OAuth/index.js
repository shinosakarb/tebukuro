import React from 'react'
import { OAuthSignInButton, SignOutButton } from "redux-auth/default-theme"

const OAuth = ({auth}) => {
  if (auth.getIn(["user", "isSignedIn"])) {
    return (
      <div>
        <img height="20" width="20" src={auth.getIn(["user", "attributes", "image"])} />
        <SignOutButton />
      </div>
    )
  } else {
    return (
      <OAuthSignInButton provider="github" />
    )
  }
}

OAuth.propTypes = {
  auth : React.PropTypes.object.isRequired,
}

export default OAuth
