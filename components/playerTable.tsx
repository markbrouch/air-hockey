import { useQuery } from '@apollo/react-hooks';
import gql from 'graphql-tag';

export const ALL_PLAYERS_QUERY = gql`
	query allPlayers {
		allPlayers {
			id
			firstName
			lastName
		}
	}
`;

export default function PlayerTable() {
	const { loading, data, error } = useQuery(ALL_PLAYERS_QUERY);

	if (error) console.error(error)
	if (error) return <div>error</div>

	if (loading) return <div>Loading</div>

	const { allPlayers } = data;

	return (
		<table>
			<thead>
				<tr>
					<th>First Name</th>
					<th>Last Name</th>
				</tr>
			</thead>
			<tbody>
				{allPlayers.map((player) => (
					<tr key={player.id}>
						<td>{player.firstName}</td>
						<td>{player.lastName}</td>
					</tr>
				))}
			</tbody>
		</table>
	)
}
