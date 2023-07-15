import create from 'zustand';

export interface PriceHistory {
    id: number;
    time: Date | number | string;
    price: number;
}

export interface ChartData {
    labels: string[];
    datasets: {
        label: string;
        data: number[];
        backgroundColor: string[];
        borderColor: string;
        borderWidth: number;
    }[];
}

export const usePriceHistory = create<{ priceHistory: PriceHistory[]; setPriceHistory: (value: PriceHistory[]) => void }>((set) => ({
    priceHistory: [],
    setPriceHistory: (priceHistory: PriceHistory[]) => set({ priceHistory })
}));

export const useChartData = create<{ chartData: ChartData; setChartData: (value: ChartData) => void }>((set) => ({
    chartData: {labels: [], datasets: []},
    setChartData: (chartData: ChartData) => set({ chartData })
}));