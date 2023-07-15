import { Avatar, IconButton, ListItem, ListItemAvatar, ListItemText } from '@mui/material';
import React from 'react';

import { RemoveShoppingCart } from '@mui/icons-material';
import { CartItem } from '../../types/cart';

interface ItemProps {
  item: CartItem;
  removeFromCart: (clickedItem: CartItem) => void;
}

const BasketItem = ({ item, removeFromCart }: ItemProps) => {
  return (
    <ListItem
      secondaryAction={
        <IconButton edge="end" aria-label="add" onClick={() => removeFromCart(item)}>
          <RemoveShoppingCart />
        </IconButton>
      }
    >
      <ListItemAvatar>
        <Avatar src={`nui://ox_inventory/web/images/${item.item}.png`} />
      </ListItemAvatar>
      <ListItemText
        primary={item.label}
        secondary={`Price: ${item.price} - Amount: ${item.amount}`}
      />
    </ListItem>
  );
};

export default BasketItem;
