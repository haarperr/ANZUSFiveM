import { Avatar, IconButton, ListItem, ListItemAvatar, ListItemText } from '@mui/material';
import { Item } from '../../types/item';
import React from 'react';

import { AddShoppingCart } from '@mui/icons-material';

interface ItemProps {
  item: Item;
  handleAddToCart: (clickedItem: Item) => void;
}

const Item = ({ item, handleAddToCart }: ItemProps) => {
  return (
    <ListItem
      secondaryAction={
        <IconButton edge="end" aria-label="add" onClick={() => handleAddToCart(item)}>
          <AddShoppingCart />
        </IconButton>
      }
    >
      <ListItemAvatar>
        <Avatar src={`nui://ox_inventory/web/images/${item.item}.png`} />
      </ListItemAvatar>
      <ListItemText
        primary={item.label}
        secondary={`Price: ${item.price} - Stock: ${item.stock}`}
      />
    </ListItem>
  );
};

export default Item;
