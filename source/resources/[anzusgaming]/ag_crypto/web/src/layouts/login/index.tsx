import { Box, Center, Grid, Stack } from '@mantine/core';
import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useStore, useSetters } from '../../store';
import { Notification } from '@mantine/core';
import Sidebar from '../sidebar';
import Buttons from './components/Buttons';
import Inputs from './components/Fields';

import { uniqueNamesGenerator, adjectives, colors, animals, starWars, names } from 'unique-names-generator';
import { fetchNui } from '../../utils/fetchNui';
import { setClipboard } from '../../utils/setClipboard';

const Login: React.FC = () => {
    const [disableLoginButton, setDisableLoginButton] = useState(false);

    const showServerOutage = useStore((store) => store.showServerOutage);
    const setServerOutage = useSetters((setter) => setter.setServerOutage);
    const setLoggedIn = useSetters((setter) => setter.setLoggedIn);
    const setUser = useSetters((setter) => setter.setUser);
    const setNotification = useSetters((setter) => setter.setNotification);
    const keyPhrase = useStore((state) => state.keyPhrase);
    const notification = useStore((state) => state.notification);
    const navigate = useNavigate();

    const login = async () => {
        setDisableLoginButton(true);
        const response = await fetchNui('login', { keyPhrase });
        setDisableLoginButton(false);

        if (response.result == null || response.result.length == 0) return;

        setLoggedIn(true);
        setUser({ wallet: response.result.wallet, value: response.result.value, orders: response.orders });
        navigate('/exchange');
    };

    const generateWallet = async () => {
        const random = () => {
            return (Math.random() + 1).toString(36).slice(2, 4);
        };

        const wallet = `M${random()}-K${random()}-3${random()}`;

        const randomName = uniqueNamesGenerator({
            dictionaries: [adjectives, animals, starWars, names],
            length: 4,
            separator: ' ',
        }).toLowerCase();

        await fetchNui('createWallet', { keyPhrase: randomName, wallet });

        setClipboard(randomName);
        const date = new Date();
        setServerOutage(date.setTime(date.getTime() + 30 * 60 * 1000));
        setNotification({
            message:
                'Successfully created wallet; <a style="color: red">your key phrase is copied to your clipboard, this cannot be changed; you need to save this</a>',
            title: 'Wallet Created',
            type: 'success',
            show: true,
        });
        return;
    };

    const diff = ((showServerOutage ?? 0) - new Date().getTime()) / 1000 / 60;
    if (diff <= 0) setServerOutage(0);

    return (
        <>
            {showServerOutage && !notification.show ? (
                <Notification title="Server Outage" color="red" loading>
                    Wallet creation is currently under high load, please try again in{' '}
                    {diff >= 1 ? `${Math.abs(Math.round(diff))} minute(s)` : `${(diff * 60).toFixed(0)} second(s)`}
                </Notification>
            ) : (
                <></>
            )}
            <Center>
                <Grid columns={2} sx={{ fontSize: 16, top: '30%', position: 'absolute', width: '24vw' }}>
                    <Inputs />
                    <Buttons
                        disableLoginButton={disableLoginButton}
                        showGeneration={!showServerOutage}
                        onLoginClick={login}
                        onGenerationClick={generateWallet}
                    />
                </Grid>
            </Center>
        </>
    );
};

export default Login;
