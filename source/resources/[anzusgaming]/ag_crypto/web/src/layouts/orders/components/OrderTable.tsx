import { Button, Table, Tooltip } from '@mantine/core';
import { OrderData } from '../../../store';
import { TbTrash } from 'react-icons/tb';

interface Props {
    data: OrderData[];
    sx?: any;
    caption?: string;
    disabled: boolean;
    deleteOrder: (id: any) => void;
}

const OrderTable: React.FC<Props> = ({ data, sx, caption, disabled, deleteOrder }) => {
    const rows =
        data?.length > 0
            ? data.map((data) => {
                  return (
                      <tr key={data.id}>
                          <td>{data.type}</td>
                          <td>{data.amount}</td>
                          <td>${data.price}</td>
                          <td>
                              <Tooltip label="Delete Order">
                                  <Button
                                      onClick={() => {
                                          deleteOrder(data.id);
                                      }}
                                      disabled={disabled}
                                  >
                                      <TbTrash />
                                  </Button>
                              </Tooltip>
                          </td>
                      </tr>
                  );
              })
            : 'No data found';

    return (
        <Table sx={sx}>
            {caption ? <caption style={{ marginRight: '2.5vw' }}>{caption}</caption> : null}
            <thead>
                <tr>
                    <th>Type</th>
                    <th>Amount</th>
                    <th>Price</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>{rows}</tbody>
        </Table>
    );
};

export default OrderTable;
