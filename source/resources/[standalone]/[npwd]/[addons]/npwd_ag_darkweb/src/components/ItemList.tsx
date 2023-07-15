import { List } from '@mui/material';
import React from 'react';
import { useRecoilRefresher_UNSTABLE, useRecoilValue } from 'recoil';
import { itemsAtom } from '../atoms/market';
import Item from './Item';
import type { Item as ItemType } from '../../types/item';
import { useSetCartItems } from '../atoms/cart';

const ItemList = () => {
  const items = useRecoilValue(itemsAtom);
  const refreshItems = useRecoilRefresher_UNSTABLE(itemsAtom);
  const setCartItems = useSetCartItems();

  const handleAddToCart = (clickedItem: ItemType) => {
    setCartItems((prev) => {
      const isItemInCart = prev.find((item) => item.id === clickedItem.id);
      const stock = items.find((item) => item.id === clickedItem.id)?.stock ?? 1;

      if (isItemInCart) {
        return prev.map((item) => {
          if (item.id === clickedItem.id) {
            if (item.amount + 1 <= stock) return { ...item, amount: item.amount + 1 };
            return item;
          }
          return item;
        });
      }

      return [...prev, { ...clickedItem, amount: 1 }];
    });
  };

  return (
    <List sx={{ width: '100%' }}>
      {items.map((item) => (
        <Item key={item.id} item={item} handleAddToCart={handleAddToCart} />
      ))}
    </List>
  );
};

export default ItemList;
