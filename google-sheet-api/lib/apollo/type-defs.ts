import gql from 'graphql-tag'

export const typeDefs = gql`
  type Query {
    allPlayers: [Player!]
  }

  type Mutation {
    addPlayer(firstName: String!, lastName: String!): Player!
  }

  type Player {
    id: ID!
    lastName: String!
    firstName: String!
  }
`;