import { Button } from '@mantine/core';
import { useState } from 'react';
import { useSetters } from '../../../store';
import { fetchNui } from '../../../utils/fetchNui';
import Input from '../../common/components/Input';

const ButtonStyle = {
    top: '3.3vh',
    width: '8vw',
};

interface Props {
    wallet: string;
}

const Transfer: React.FC<Props> = ({ wallet }) => {
    const setNotification = useSetters((setter) => setter.setNotification);
    const [disabled, setDisabled] = useState(false);
    const [amount, setAmount] = useState(0);
    const [transferWallet, setWallet] = useState('');

    const Submit = async () => {
        setDisabled(true);
        if (amount <= 0 || transferWallet.length != 11) {
            setDisabled(false);
            return setNotification({
                message: 'Amount must be greater than 0 and a valid wallet must be supplied',
                show: true,
                type: 'error',
                title: 'Transfer',
            });
        }

        if (transferWallet.toLowerCase() === wallet.toLowerCase()) {
            setDisabled(false);
            return setNotification({
                message: 'You cannot transfer crypto to yourself',
                show: true,
                type: 'error',
                title: 'Transfer',
            });
        }

        const res = await fetchNui('submitTransfer', { amount, transferWallet, wallet });

        setNotification({ message: res.message, show: true, type: res.status, title: 'Transfer' });
        setDisabled(false);
    };

    return (
        <>
            <Input
                label="Amount"
                type="number"
                span={2}
                value={amount}
                infoCircle="The amount of crypto you wish to transfer"
                setValue={setAmount}
            />
            <Input
                label="Wallet Identifier"
                type="text"
                span={2}
                infoCircle="The wallet you wish to transfer crypto to"
                value={transferWallet}
                setValue={setWallet}
            />
            <Button sx={ButtonStyle} onClick={Submit} disabled={disabled}>
                Transfer
            </Button>
        </>
    );
};

export default Transfer;
