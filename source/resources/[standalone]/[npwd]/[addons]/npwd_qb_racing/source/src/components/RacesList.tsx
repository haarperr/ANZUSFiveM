import { Stack } from '@mui/material';
import React from 'react';
import { useRecoilRefresher_UNSTABLE, useRecoilValue } from 'recoil';
import { racesAtom } from '../atoms/races';
import RaceCard from '../components/RaceCard';

const RacesList = () => {
  const races = useRecoilValue(racesAtom);
  const refreshRaces = useRecoilRefresher_UNSTABLE(racesAtom);

  return (
    <Stack spacing={1}>
      {races.map((race) => (
        <RaceCard key={race.id} race={race} onUpdate={refreshRaces} />
      ))}
    </Stack>
  );
};

export default RacesList;
