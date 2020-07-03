import { ApolloServer } from "apollo-server-micro";
import { GoogleSpreadsheet } from "google-spreadsheet";

import { schema } from '../../../lib/apollo/schema'

const apolloServer = new ApolloServer({
  schema,
  context: async () => {
    const doc = new GoogleSpreadsheet(process.env.GOOGLE_SPREADSHEET_ID);

    try {
      await doc.useServiceAccountAuth({
        client_email: process.env.GOOGLE_SERVICE_ACCOUNT_EMAIL,
        private_key: process.env.GOOGLE_PRIVATE_KEY,
      });
    } catch (error) {
      console.error(error);
    }

    try {
      await doc.loadInfo();
    } catch (error) {
      console.error(error);
    }

    return { db: doc };
  },
});

export const config = {
  api: {
    bodyParser: false,
  },
};

export default apolloServer.createHandler({ path: '/api/graphql' })