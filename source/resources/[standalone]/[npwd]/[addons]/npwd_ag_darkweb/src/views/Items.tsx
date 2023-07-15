import { CircularProgress } from '@mui/material';
import React from 'react';
import ItemList from '../components/ItemList';

const Items = () => {
  return (
    <div>
      <React.Suspense fallback={<CircularProgress />}>
        <ItemList />
      </React.Suspense>
    </div>
  );
};

export default Items;
