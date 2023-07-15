import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';
import { debugData } from './utils/debugData';
import { MantineProvider } from '@mantine/core';
import { customTheme } from './theme';
import { isEnvBrowser } from './utils/misc';
import { HashRouter } from 'react-router-dom';
import { ModalsProvider } from '@mantine/modals';
import { Transaction } from './store/transactions';
import { ChartData, PriceHistory } from './store/graph';
import moment from 'moment';

debugData<Transaction[]>([
    {
        action: 'updateTransactionData',
        data: [
            {
                id: 1,
                sender: 'Ma0-K8c-3c1',
                receiver: 'Ma0-K8c-3c1',
                amount: 1,
                time: '2023-02-04 14:35:05',
            },
        ],
    },
]);

const data = [
    {
        id: 1,
        price: 1,
        time: new Date(),
    },
    {
        id: 2,
        price: 1,
        time: new Date(),
    },
    {
        id: 3,
        price: 2,
        time: new Date(),
    },
    {
        id: 4,
        price: 0.1,
        time: new Date(),
    },
];

debugData<PriceHistory[]>([
    {
        action: 'updatePriceHistory',
        data: data,
    },
]);

debugData<ChartData>([
    {
        action: 'updateChartData',
        data: {
            labels: data.map((data: any) => moment.unix(data.time).format('HH:mm')),
            datasets: [
                {
                    label: 'Price ',
                    data: data.map((data) => data.price),
                    backgroundColor: ['rgba(75,192,192,1)', '#ecf0f1', '#50AF95', '#f3ba2f', '#2a71d0'],
                    borderColor: 'black',
                    borderWidth: 2,
                },
            ],
        },
    },
]);

debugData(
    [
        {
            action: 'setVisible',
            data: undefined,
        },
    ],
    2000
);

if (isEnvBrowser()) {
    const root = document.getElementById('root');

    // https://i.imgur.com/iPTAdYV.png - Night time img
    root!.style.backgroundImage = 'url("https://i.imgur.com/3pzRj9n.png")';
    root!.style.backgroundSize = 'cover';
    root!.style.backgroundRepeat = 'no-repeat';
    root!.style.backgroundPosition = 'center';
}

ReactDOM.render(
    <React.StrictMode>
        <MantineProvider withNormalizeCSS withGlobalStyles theme={customTheme}>
            <ModalsProvider modalProps={{ transition: 'slide-up' }}>
                <HashRouter>
                    <App />
                </HashRouter>
            </ModalsProvider>
        </MantineProvider>
    </React.StrictMode>,
    document.getElementById('root')
);
