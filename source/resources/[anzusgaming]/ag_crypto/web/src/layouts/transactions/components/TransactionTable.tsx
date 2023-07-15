import { Transaction } from '../../../store/transactions';
import { Table } from '@mantine/core';
import { dateFormatter } from '../../../utils/misc';

interface Props {
    data: Transaction[];
    sx?: any;
    caption?: string;
}

const TransactionTable: React.FC<Props> = ({ data, sx, caption }) => {
    const rows =
        data.length > 0
            ? data.map((data) => {
                  const date = new Date(data.time);
                  return (
                      <tr key={data.id}>
                          <td>{data.sender}</td>
                          <td>{data.receiver}</td>
                          <td>{data.amount}</td>
                          <td>{dateFormatter(date)}</td>
                      </tr>
                  );
              })
            : 'No data found';

    return (
        <Table sx={{ ...{ marginTop: '3vh' }, ...sx }}>
            {caption ? <caption style={{ marginRight: '2.5vw' }}>{caption}</caption> : null}
            <thead>
                <tr>
                    <th>Sender</th>
                    <th>Receiver</th>
                    <th>Amount</th>
                    <th>Time</th>
                </tr>
            </thead>
            <tbody>{rows}</tbody>
        </Table>
    );
};

export default TransactionTable;
