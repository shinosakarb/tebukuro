import React from 'react'
import CommunityListModel from '../../models/CommunityList'

const CommunityList = ({CommunityList}) => {
  return (
    <table>
      <thead>
        <tr>
          <th>name</th>
        </tr>
      </thead>
      <tbody>
        {
          CommunityList.communities.map((community) => {
            return (
              <tr key={community.id}>
                <td>{community.name}</td>
              </tr>
            )
          })
        }
      </tbody>
    </table>
  )
}

CommunityList.propTypes = {
  CommunityList : React.PropTypes.instanceOf(CommunityListModel).isRequired,
}

export default CommunityList
