import { Box, Button, Center, Grid, Input, Sx, TextInput } from '@mantine/core';
import { useState } from 'react';
import { TbInputSearch } from 'react-icons/tb';
import { useSearch } from '../../../store/search';
import { fetchNui } from '../../../utils/fetchNui';
import { dateFormatter } from '../../../utils/misc';

const InputStyle: Sx = {
    width: '15vw',
    marginRight: '2vw',
    marginTop: '2vh',
};

const WalletLookup: React.FC = () => {
    const search = useSearch();
    const [disabled, setDisabled] = useState(false);

    const handleDisable = () => {
        if (disabled) return;
        setDisabled(true);
        setTimeout(() => {
            setDisabled(false);
        }, 1500);
    };

    const HandleSearch = async () => {
        handleDisable();
        const res = await fetchNui('walletLookup', { search: search.value.length == 0 ? null : search.value });
        search.setWalletLookup({
            value: res.value,
            created: dateFormatter(res.created),
            transactions: {
                total: res.total_transactions,
                sum: res.total_transacted,
                last: res.last_transaction != 0 ? dateFormatter(res.last_transaction) : 'Never',
            },
        });
    };

    return (
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
            <Grid columns={2} sx={{ fontSize: 16, position: 'absolute', margin: '3vh' }}>
                <TextInput
                    type="text"
                    label={'Value'}
                    value={search.walletLookup.value}
                    onChange={() => null}
                    sx={InputStyle}
                />
                <TextInput
                    type="text"
                    label={'Created'}
                    value={search.walletLookup.created}
                    onChange={() => null}
                    sx={InputStyle}
                />
                <TextInput
                    type="text"
                    label={'Total Transactions'}
                    value={search.walletLookup.transactions.total}
                    onChange={() => null}
                    sx={InputStyle}
                />
                <TextInput
                    type="text"
                    label={'Total Transacted'}
                    value={search.walletLookup.transactions.sum}
                    onChange={() => null}
                    sx={InputStyle}
                />
                <TextInput
                    type="text"
                    label={'Last Transaction'}
                    value={search.walletLookup.transactions.last}
                    onChange={() => null}
                    sx={InputStyle}
                />
            </Grid>
        </Box>
    );
};

export default WalletLookup;
