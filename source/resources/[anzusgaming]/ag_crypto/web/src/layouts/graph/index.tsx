import Chart from 'chart.js/auto';
import { CategoryScale } from 'chart.js';
import { Box, Stack } from '@mantine/core';
import { fetchNui } from '../../utils/fetchNui';
import Sidebar from '../sidebar';
import RefreshButton from '../common/components/RefreshButton';
import LineChart from './components/LineChart';
import { useChartData, usePriceHistory } from '../../store/graph';
import moment from 'moment';
import { dateFormatter } from '../../utils/misc';

Chart.register(CategoryScale);

const Graph: React.FC = () => {
    const click = () => {
        fetchNui('getPriceHistory');
    };
    const priceHistory = usePriceHistory((state) => state.priceHistory);

    const chartData = {
        labels: priceHistory.map((data: any) => dateFormatter(new Date(data.time), { year: undefined })),
        datasets: [
            {
                label: 'Price ',
                data: priceHistory.map((data) => data.price),
                backgroundColor: ['rgba(75,192,192,1)', '#ecf0f1', '#50AF95', '#f3ba2f', '#2a71d0'],
                borderColor: 'black',
                borderWidth: 2,
            },
        ],
    };

    console.log(chartData, priceHistory);

    return (
        <>
            <RefreshButton onClick={click} />
            <LineChart chartData={chartData} currentValue={chartData.datasets[0].data.at(-1) ?? 0} />
        </>
    );
};

export default Graph;
