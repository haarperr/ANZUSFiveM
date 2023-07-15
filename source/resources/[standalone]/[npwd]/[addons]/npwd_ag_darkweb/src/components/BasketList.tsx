import { Box, Button, List, Typography } from '@mui/material';
import React from 'react';
import { useCartItems, useSetCartItems } from '../atoms/cart';
import { CartItem } from '../../types/cart';
import BasketItem from './BasketItem';
import { useState } from 'react';
import { useEffect } from 'react';
import fetchNui from '../utils/fetchNui';
import { NUIEvents } from '../../types/events';
import { ServerPromiseResp } from '@project-error/npwd-types';
import { useRecoilRefresher_UNSTABLE } from 'recoil';
import { itemsAtom } from '../atoms/market';

const Basket = () => {
  const cart = useCartItems();
  const setCartItems = useSetCartItems();
  const refreshItem = useRecoilRefresher_UNSTABLE(itemsAtom);
  const [totalPrice, setTotalPrice] = useState(0);

  const removeFromCart = (item: CartItem) => {
    setCartItems((prevItems) => {
      const newCartItems = prevItems.map((cartItem) => {
        if (cartItem.id === item.id) {
          return { ...cartItem, amount: cartItem.amount - 1 };
        }
        return cartItem;
      });
      const filteredCartItems = newCartItems.filter((cartItem) => cartItem.amount > 0);
      return filteredCartItems;
    });
  };

  const checkout = async () => {
    fetchNui<ServerPromiseResp<void>>(NUIEvents.Checkout, cart).then((resp) => {
      setCartItems([]);
      refreshItem();
    });
  };

  useEffect(() => {
    setTotalPrice(cart.reduce((sum, item) => sum + item.price * item.amount, 0));
  }, [cart]);

  return (
    <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
      {cart.length > 0 ? (
        <>
          <List sx={{ width: '100%' }}>
            {cart.map((cart) => (
              <BasketItem key={cart.id} item={cart} removeFromCart={removeFromCart} />
            ))}
          </List>
          <Button
            variant="contained"
            color="primary"
            sx={{
              marginTop: 'auto',
              fontFeatureSettings: 'tnum',
              fontVariantNumeric: 'tabular-nums',
            }}
            onClick={checkout}
          >
            Purchase for {totalPrice}
          </Button>
        </>
      ) : (
        <Box
          sx={{
            margin: 0,
            position: 'absolute',
            top: '50%',
            left: '50%',
            '-ms-transform': 'translate(-50%, -50%)',
            transform: 'translate(-50%, -50%)',
          }}
        >
          <Typography variant="h5" color="primary.contrastText">
            Basket is empty
          </Typography>
        </Box>
      )}
    </div>
  );
};

export default Basket;
