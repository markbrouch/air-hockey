import { v4 as uuid } from 'uuid';

export const resolvers = {
  Query: {
    allPlayers: async (parent, args, { db }) => {
      const rows = await db.sheetsById[0].getRows();
      
      rows.forEach(row => {
        if (!row.id) {
          row.id = uuid()

          row.save()
        }
      })

      return rows
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