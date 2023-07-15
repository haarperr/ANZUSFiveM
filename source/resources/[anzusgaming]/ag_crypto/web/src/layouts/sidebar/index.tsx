import { Center, Tabs, Text } from '@mantine/core';
import {
    TbAirConditioningDisabled,
    TbDetails,
    TbGraph,
    TbLogin,
    TbLogout,
    TbMenu,
    TbMoneybag,
    TbWallet,
} from 'react-icons/tb';
import { useNavigate } from 'react-router-dom';
import { useSetters, useStore } from '../../store';

const Sidebar: React.FC = () => {
    const navigate = useNavigate();

    const loggedIn = useStore((state) => state.loggedIn);
    const setNotification = useSetters((setter) => setter.setNotification);

    return (
        <>
            <Tabs
                orientation="vertical"
                color="blue"
                sx={{ height: '100%' }}
                value={location.pathname.substring(10)}
                onTabChange={(value) => {
                    setNotification({ show: false });
                    navigate(`/${value}`);
                }}
            >
                <Tabs.List>
                    <Center>
                        <img
                            src={'img/logo.png'}
                            alt="new"
                            width={50}
                            height={50}
                            style={{ marginBottom: 5, marginTop: 10, opacity: '50%' }}
                            draggable={false}
                        />
                    </Center>
                    <Tabs.Tab value={'graph'} icon={<TbGraph size={20} />}>
                        Graph
                    </Tabs.Tab>
                    <Tabs.Tab value={'transactions'} icon={<TbMenu size={20} />}>
                        Transactions
                    </Tabs.Tab>
                    <Tabs.Tab value={'wallet/lookup'} icon={<TbWallet size={20} />}>
                        Wallet Search
                    </Tabs.Tab>
                    {loggedIn ? (
                        <>
                            <Tabs.Tab value={'exchange'} icon={<TbAirConditioningDisabled size={20} />}>
                                Exchange
                            </Tabs.Tab>
                            <Tabs.Tab value={'wallet'} icon={<TbWallet size={20} />}>
                                Wallet
                            </Tabs.Tab>
                            <Tabs.Tab value={'wallet/orders'} icon={<TbMenu size={20} />}>
                                Orders
                            </Tabs.Tab>
                            <Tabs.Tab value={'signout'} icon={<TbLogout size={20} />}>
                                Sign Out
                            </Tabs.Tab>
                        </>
                    ) : (
                        <Tabs.Tab value={'login'} icon={<TbLogin size={20} />}>
                            Login
                        </Tabs.Tab>
                    )}
                </Tabs.List>
            </Tabs>
        </>
    );
};

export default Sidebar;
