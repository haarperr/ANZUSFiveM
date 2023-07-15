import { CircularProgress, Divider, Typography } from '@mui/material';
import React from 'react';
import RacesList from '../components/RacesList';

const Races = () => {
  return (
    <div>
      <Typography variant="h6">Active races</Typography>
      <Typography variant="caption" sx={{ lineHeight: 1 }}>
        You can easily setup a track yourself from the navigation below.
      </Typography>

      <Divider sx={{ margin: '1.5rem 0' }} />

      <React.Suspense fallback={<CircularProgress />}>
        <RacesList />
      </React.Suspense>
    </div>
  );
};

export default Races;
