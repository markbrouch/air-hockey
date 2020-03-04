import { ApolloServer, gql } from "apollo-server-lambda";
import { GoogleSpreadsheet } from "google-spreadsheet";
import { v4 as uuid } from "uuid";

import { NowRequest, NowResponse } from "@now/node";
import { APIGatewayProxyResult } from "aws-lambda";

const typeDefs = gql`
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

const resolvers = {
  Query: {
    allPlayers: async (parent, args, { db }) => {
      return await db.sheetsById[0].getRows();
    }
  },
  Mutation: {
    async addPlayer(parent, { firstName, lastName }, { db }) {
      const row = await db.sheetsById[0].addRow({
        id: uuid(),
        firstName,
        lastName
			});

			return row;
    }
  }
};

const server = new ApolloServer({
  typeDefs,
  resolvers,
  context: async () => {
    const doc = new GoogleSpreadsheet(process.env.GOOGLE_SPREADSHEET_ID);

    await doc.useServiceAccountAuth({
      client_email: process.env.GOOGLE_SERVICE_ACCOUNT_EMAIL,
      private_key: Buffer.from(
        process.env.GOOGLE_PRIVATE_KEY,
        "base64"
      ).toString("utf8")
    });

    await doc.loadInfo();

    return { db: doc };
  }
});

const handler = (event, context) =>
  new Promise((resolve, reject) =>
    server.createHandler()(
      event,
      context,
      (error: string | Error, result: APIGatewayProxyResult) => {
        if (error) reject(error);

        resolve(result);
      }
    )
  );

const splitMultiValue = (object: Object) => {
  const singleValue = {};
  const multiValue = {};

  Object.keys(object).forEach(key => {
    const value = object[key];

    if (Array.isArray(value)) {
      multiValue[key] = value;
    } else {
      singleValue[key] = value;
    }
  });

  return [singleValue, multiValue];
};

module.exports = async (req: NowRequest, res: NowResponse) => {
  const [headers, multiValueHeaders] = splitMultiValue(req.headers);
  const [
    queryStringParameters,
    multiValueQueryStringParameters
  ] = splitMultiValue(req.query);

  await handler(
    {
      httpMethod: req.method,
      path: req.url,
      headers,
      multiValueHeaders,
      body: JSON.stringify(req.body),
      queryStringParameters,
      multiValueQueryStringParameters
    },
    {}
  )
    .then((result: APIGatewayProxyResult) =>
      res.status(result.statusCode).send(result.body)
    )
    .catch((error: Error) => res.status(500).send(error));
};
