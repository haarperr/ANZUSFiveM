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

const Sell: React.FC<Props> = ({ wallet }) => {
    const setNotification = useSetters((setter) => setter.setNotification);
    const [disabled, setDisabled] = useState(false);
    const [amount, setAmount] = useState(0);
    const [price, setPrice] = useState(0);

    const Submit = async () => {
        setDisabled(true);
        if (price <= 0 || amount <= 0) {
            setDisabled(false);
            return setNotification({
                message: 'Price and amount must be greater than 0',
                show: true,
                type: 'error',
                title: 'Sell Order',
            });
        }
        const res = await fetchNui('submitSellOrder', { amount, price, wallet });

        setNotification({ message: res.message, show: true, type: res.status, title: 'Sell Order' });
        setDisabled(false);
    };

    return (
        <>
            <Input
                label="Amount"
                type="number"
                span={2}
                value={amount}
                infoCircle="The amount of crypto you wish to sell"
                setValue={setAmount}
            />
            <Input
                label="Price"
                type="number"
                span={2}
                value={price}
                infoCircle="The minimum price you wish to sell per singular crypto"
                setValue={setPrice}
            />
            <Button sx={ButtonStyle} onClick={Submit} disabled={disabled}>
                Place Sell Order
            </Button>
        </>
    );
};

export default Sell;
