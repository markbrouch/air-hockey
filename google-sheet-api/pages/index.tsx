import Container from '@material-ui/core/Container'
import Head from 'components/head';
import PlayerTable from 'components/playerTable';

const Home = () => {
  return (
    <Container>
      <Head title="Home" />
			<PlayerTable />
    </Container>
  );
};

export default Home;
