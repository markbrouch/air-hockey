import React from 'react';
import Head from '../components/head';
import PlayerTable from '../components/playerTable';
import { withApollo } from '../lib/apollo';

const Home = () => {
  return (
    <div>
      <Head title="Home" />
			<PlayerTable />
    </div>
  );
};

export default withApollo({ ssr: true })(Home);
