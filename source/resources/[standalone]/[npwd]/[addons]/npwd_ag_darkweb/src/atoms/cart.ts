import { atom, useRecoilValue, useSetRecoilState } from 'recoil';
import { CartItem } from '../../types/cart';

export const cartState = {
  items: atom<CartItem[]>({
    key: 'ag:dwcartitems',
    default: [],
  }),
};

export const useCartItems = () => useRecoilValue(cartState.items);
export const useSetCartItems = () => useSetRecoilState(cartState.items);
