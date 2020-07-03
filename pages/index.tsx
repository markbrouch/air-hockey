import { initializeApollo } from '../lib/apollo/client';
import Head from '../components/head';
import PlayerTable from '../components/playerTable';

const Home = () => {
  return (
    <div>
      <Head title="Home" />
			<PlayerTable />
    </div>
  );
};

export default Home;
