import create, { GetState, SetState } from 'zustand';

export type StringField = string | null | undefined;
export type NumberField = number | null | undefined;

export interface OrderData {
    id: NumberField;
    type: 'BUY' | 'SELL';
    amount: NumberField;
    price: NumberField;
    time: string;
}

export interface StoreState {
  keyPhrase: StringField;
  loggedIn: boolean;
  user: {
    wallet: StringField;
    value: NumberField;
    orders: OrderData[]
  };
  showServerOutage: NumberField;
  notification: {
    message?: StringField;
    show: boolean;
    type?: 'error' | 'success',
    title?: StringField
  }
}

interface StateSetters {
  setKeyPhrase: (value: StoreState['keyPhrase']) => void;
  setLoggedIn: (value: StoreState['loggedIn']) => void;
  setUser: (value: StoreState['user']) => void;
  setServerOutage: (value: StoreState['showServerOutage']) => void;
  setNotification: (value: StoreState['notification']) => void;
}

export const useStore = create<StoreState>(() => ({
    keyPhrase: '',
    loggedIn: false,
    user: {
        wallet: '',
        value: 0,
        orders: []
    },
    showServerOutage: 0,
    notification: {
        message: '',
        show: false,
        type: 'success',
        title: ''
    }
}));

export const defaultState = useStore.getState();

export const useSetters = create<StateSetters>((set: SetState<StateSetters>, get: GetState<StateSetters>) => ({
    setKeyPhrase: (value: StoreState['keyPhrase']) => useStore.setState({ keyPhrase: value }),
    setLoggedIn: (value: StoreState['loggedIn']) => useStore.setState({ loggedIn: value }),
    setUser: (value: StoreState['user']) => useStore.setState({ user: value }),
    setServerOutage: (value: StoreState['showServerOutage']) => useStore.setState({ showServerOutage: value }),
    setNotification: (value: StoreState['notification']) => useStore.setState({ notification: value })
}));
