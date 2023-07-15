import create from 'zustand';

interface WalletLookup {
    value: number;
    created: string;
    transactions: {
        total: number;
        last: string;
        sum: number;
    }
}

interface Store {
  value: string;
  debouncedValue: string;
  walletLookup: WalletLookup;
  setDebouncedValue: (value: string) => void;
  setValue: (value: string) => void;
  setWalletLookup: (value: WalletLookup) => void;
}

export const useSearch = create<Store>((set) => ({
  value: '',
  debouncedValue: '',
  walletLookup: {
    value: 0,
    created: '',
    transactions: {
        total: 0,
        last: '',
        sum: 0
    }
  },
  setDebouncedValue: (value: string) => set({ debouncedValue: value }),
  setValue: (value: string) => set({ value: value }),
  setWalletLookup: (value: WalletLookup) => set({ walletLookup: value }),
}));
