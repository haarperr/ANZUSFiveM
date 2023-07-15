import { Box } from '@mantine/core';
import { useState } from 'react';
import { useSetters, useStore } from '../../store';
import { fetchNui } from '../../utils/fetchNui';
import RefreshButton from '../common/components/RefreshButton';
import OrderTable from './components/OrderTable';

const Orders: React.FC = () => {
    const [disabled, setDisabled] = useState(false);
    const user = useStore((state) => state.user);
    const setUser = useSetters((setter) => setter.setUser);

    const getUserOrders = async () => {
        handleDisable();
        const response = await fetchNui('getUserOrders', { wallet: user.wallet });
        setUser({ ...user, ...{ orders: response } });
    };

    const deleteOrder = async (id: any) => {
        handleDisable();
        await fetchNui('deleteOrder', { id: id });
        setUser({ ...user, ...{ orders: user.orders.filter((x) => x.id !== id) } });
    };

    const handleDisable = () => {
        if (disabled) return;
        setDisabled(true);
        setTimeout(() => {
            setDisabled(false);
        }, 1500);
    };

    return (
        <>
            <RefreshButton onClick={getUserOrders} />
            <Box>
                <OrderTable data={user.orders} caption={'Your Orders'} disabled={disabled} deleteOrder={deleteOrder} />
            </Box>
        </>
    );
};

export default Orders;
