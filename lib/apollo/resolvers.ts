import { v4 as uuid } from 'uuid';

export const resolvers = {
  Query: {
    allPlayers: async (parent, args, { db }) => {
      return await db.sheetsById[0].getRows();
    },
  },
  Mutation: {
    async addPlayer(parent, { firstName, lastName }, { db }) {
      const row = await db.sheetsById[0].addRow({
        id: uuid(),
        firstName,
        lastName,
      });

      return row;
    },
  },
};