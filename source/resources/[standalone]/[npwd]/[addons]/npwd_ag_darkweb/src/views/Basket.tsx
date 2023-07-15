import { CircularProgress } from '@mui/material';
import React from 'react';
import BasketList from '../components/BasketList';

const Basket = () => {
  return (
    <div>
      <React.Suspense fallback={<CircularProgress />}>
        <BasketList />
      </React.Suspense>
    </div>
  );
};

export default Basket;
