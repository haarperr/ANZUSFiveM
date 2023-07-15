import { Grid, Title } from '@mantine/core';
import { useEffect, useState } from 'react';
import { useStore } from '../../store';
import { fetchNui } from '../../utils/fetchNui';
import Input from '../common/components/Input';
import RefreshButton from '../common/components/RefreshButton';
import TransactionTable from '../transactions/components/TransactionTable';

const Wallet: React.FC = () => {
    const user = useStore((store) => store.user);
    const [transactions, setTransactions] = useState([]);
    const [disabled, setDisabled] = useState(false);

    const getTransactions = async () => {
        handleDisable();
        const res = await fetchNui('getOwnTransactionData', { page: 0, search: user.wallet });
        setTransactions(Object.values(res.results));
    };

    const handleDisable = () => {
        if (disabled) return;
        setDisabled(true);
        setTimeout(() => {
            setDisabled(false);
        }, 1500);
    };

    useEffect(() => {
        getTransactions();
    }, []);

    return (
        <>
            <RefreshButton onClick={getTransactions} />
            <Grid columns={2} sx={{ fontSize: 16, position: 'absolute', marginTop: '0.5vh' }}>
                <Input
                    type="text"
                    label="Wallet Identifier"
                    setValue={() => null}
                    value={user.wallet?.toString()}
                    sx={{ width: '15vw', marginLeft: '2vw' }}
                />
                <Input
                    type="text"
                    label="Value"
                    setValue={() => null}
                    value={user.value?.toString()}
                    sx={{ width: '15vw', marginRight: '2vw' }}
                />
                <TransactionTable
                    data={transactions}
                    sx={{ marginLeft: '2vw', width: '90%', marginTop: '1vh' }}
                    caption={'Your Transactions'}
                />
            </Grid>
        </>
    );
};

export default Wallet;
