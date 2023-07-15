import { Box, Button, Center, Input, Pagination, TextInput } from '@mantine/core';
import { useState } from 'react';
import { TbInputSearch } from 'react-icons/tb';
import { useSearch } from '../../store/search';
import { useTransactions } from '../../store/transactions';
import { fetchNui } from '../../utils/fetchNui';
import RefreshButton from '../common/components/RefreshButton';
import TransactionTable from './components/TransactionTable';

const Transactions: React.FC = () => {
    const [activePage, setPage] = useState(1);
    const [disabled, setDisabled] = useState(false);
    const search = useSearch();
    const data = useTransactions((state) => state.transactions);

    const click = () => {
        handleDisable();
        fetchNui('getTransactionData');
    };

    const handleDisable = () => {
        if (disabled) return;
        setDisabled(true);
        setTimeout(() => {
            setDisabled(false);
        }, 1500);
    };

    const ChangePage = async (page: number) => {
        handleDisable();
        setPage(page);
        await fetchNui('getTransactionData', {
            page: (page - 1) * 8,
            search: search.value.length == 0 ? null : search.value,
        });
    };

    const HandleSearch = async () => {
        handleDisable();
        await fetchNui('getTransactionData', { page: 0, search: search.value.length == 0 ? null : search.value });
    };

    return (
        <>
            <RefreshButton onClick={click} />
            <Box>
                <Center>
                    <Input
                        icon={<TbInputSearch />}
                        placeholder="Wallet Identifier"
                        sx={{ top: '2vh', width: '50%', right: '1.5vw' }}
                        value={search.value}
                        onChange={(e) => search.setValue(e.target.value)}
                        rightSection={
                            <Button onClick={HandleSearch} disabled={disabled}>
                                Search
                            </Button>
                        }
                    />
                </Center>
                <TransactionTable data={data.results} />
            </Box>
            <Pagination total={Math.ceil(data.count / 8)} disabled={disabled} page={activePage} onChange={ChangePage} />
        </>
    );
};

export default Transactions;
