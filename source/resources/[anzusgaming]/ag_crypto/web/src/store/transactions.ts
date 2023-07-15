import create from 'zustand';

export interface TransactionRet {
    results: Transaction[];
    count: number
}

export interface Transaction {
  id: number;
  sender: string
  receiver: string
  amount: number
  time: string
}

export const useTransactions = create<{ transactions: TransactionRet; setTransactions: (value: TransactionRet) => void }>((set) => ({
  transactions: {results: [], count: 0},
  setTransactions: (transactions: TransactionRet) => set({ transactions })
}));
