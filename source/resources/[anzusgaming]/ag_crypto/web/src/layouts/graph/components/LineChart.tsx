import React from 'react';
import { Line } from 'react-chartjs-2';

interface Props {
    chartData: any;
    currentValue: number;
}

let formatCurrency = new Intl.NumberFormat('en-US', {
    style: 'currency',
    currency: 'USD',
});

const LineChart: React.FC<Props> = ({ chartData, currentValue }) => {
    return (
        <div className="chart-container">
            <h2 style={{ textAlign: 'center' }}>Bitcoin Value</h2>
            <Line
                data={chartData}
                options={{
                    plugins: {
                        title: {
                            display: true,
                            text: `Current Value (per singular) - ${formatCurrency.format(currentValue)}`,
                        },
                        legend: {
                            display: false,
                        },
                    },
                }}
            />
        </div>
    );
};
export default LineChart;
