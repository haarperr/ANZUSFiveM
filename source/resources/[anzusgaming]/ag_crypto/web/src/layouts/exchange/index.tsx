import { Grid, Stack } from '@mantine/core';
import { useStore } from '../../store';
import Buy from './components/Buy';
import Sell from './components/Sell';
import Transfer from './components/Transfer';

const Exchange: React.FC = () => {
    const wallet = useStore((state) => state.user.wallet) as string;

    return (
        <>
            <Grid columns={6} sx={{ fontSize: 16, top: '25%', position: 'absolute' }}>
                {/* Buy */}
                <Buy wallet={wallet} />

                {/* Sell */}
                <Sell wallet={wallet} />

                {/* Transfer */}
                <Transfer wallet={wallet} />
            </Grid>
        </>
    );
};

export default Exchange;
