import { Box, createStyles, Transition, Notification, Stack } from '@mantine/core';
import { Routes, Route, useNavigate } from 'react-router-dom';
import { useNuiEvent } from './hooks/useNuiEvent';
import { useVisibility } from './store/visibility';
import { useExitListener } from './hooks/useExitListener';
import Transactions from './layouts/transactions';
import { TransactionRet, useTransactions } from './store/transactions';
import Graph from './layouts/graph';
import { ChartData, PriceHistory, useChartData, usePriceHistory } from './store/graph';
import Login from './layouts/login';
import Exchange from './layouts/exchange';
import Signout from './layouts/signout';
import { useSetters, useStore } from './store';
import Sidebar from './layouts/sidebar';
import Wallet from './layouts/wallet';
import WalletLookup from './layouts/wallet/lookup';
import Orders from './layouts/orders';

const useStyles = createStyles((theme) => ({
    container: {
        width: '100%',
        height: '100%',
        display: 'flex',
        justifyContent: 'center',
        alignItems: 'center',
    },

    main: {
        width: 900,
        height: 500,
        backgroundColor: theme.colors.dark[8],
        borderRadius: theme.radius.sm,
    },

    search: {
        width: '40%',
        transition: '300ms',
        '&:focus-within': {
            width: '50%',
        },
    },
}));

const App: React.FC = () => {
    const { classes } = useStyles();
    const [visible, setVisible] = useVisibility((state) => [state.visible, state.setVisible]);

    const setNotification = useSetters((setter) => setter.setNotification);
    const notification = useStore((state) => state.notification);
    const loggedIn = useStore((state) => state.loggedIn);

    const priceHistory = usePriceHistory((state) => state.priceHistory);
    const setPriceHistory = usePriceHistory((state) => state.setPriceHistory);

    const setTransactions = useTransactions((state) => state.setTransactions);

    const setChartData = useChartData((state) => state.setChartData);

    const navigate = useNavigate();

    useNuiEvent('setVisible', (data: number) => {
        setVisible(true);
        if (data === undefined) {
            if (!loggedIn) return navigate('/login');
            return navigate('/graph');
        }
    });

    useNuiEvent('updateTransactionData', (data: TransactionRet) => {
        return setTransactions({ results: Object.values(data.results), count: data.count });
    });

    useNuiEvent('updatePriceHistory', (data: PriceHistory[] | number) => {
        if (typeof data === 'number') return setPriceHistory(priceHistory.filter((t) => t.id !== data));
        return setPriceHistory(data.sort((a: any, b: any) => a.time - b.time));
    });

    useNuiEvent('updateChartData', (data: ChartData) => {
        return setChartData(data);
    });

    useExitListener(() => {
        setNotification({ show: false, message: '' });
        setVisible(false);
    });

    return (
        <Box className={classes.container}>
            <Transition transition="slide-up" mounted={visible}>
                {(style) => (
                    <Box className={classes.main} style={style}>
                        <Box sx={{ height: '100%', display: 'flex' }}>
                            <Sidebar />

                            <Stack p={16} sx={{ width: '100%' }} justify="space-between">
                                {notification.show ? (
                                    <Notification
                                        title={notification.title}
                                        color={notification.type === 'success' ? 'green' : 'red'}
                                        onClose={() => {
                                            setNotification({ show: false, message: '', title: '' });
                                        }}
                                    >
                                        <div dangerouslySetInnerHTML={{ __html: notification.message as string }} />
                                    </Notification>
                                ) : null}

                                <Routes>
                                    <Route path="/login" element={<Login />} />
                                    <Route path="/transactions" element={<Transactions />} />
                                    <Route path="/graph" element={<Graph />} />
                                    <Route path="/wallet/lookup" element={<WalletLookup />} />
                                    <Route path="/exchange" element={<Exchange />} />
                                    <Route path="/signout" element={<Signout />} />
                                    <Route path="/wallet" element={<Wallet />} />
                                    <Route path="/wallet/orders" element={<Orders />} />
                                </Routes>
                            </Stack>
                        </Box>
                    </Box>
                )}
            </Transition>
        </Box>
    );
};

export default App;
