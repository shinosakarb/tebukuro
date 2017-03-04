export default {
  communities: "/communities",
  events: "/events",
  communityEvents: (community_id) => {
    return `/communities/${community_id}/events`
  },
  auth: {
    github        : "/auth/github",
    facebook      : "/auth/facebook",
    twitter       : "/auth/twitter",
  }
}
