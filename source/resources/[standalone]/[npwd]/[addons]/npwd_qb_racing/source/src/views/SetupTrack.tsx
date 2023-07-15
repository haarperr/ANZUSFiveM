import { ErrorRounded } from '@mui/icons-material';
import { Alert, Button, Divider, Stack, TextField, Typography } from '@mui/material';
import React, { FormEvent, useState } from 'react';
import { NUIEvents, RacingEvents } from '../../types/Events';
import fetchNui from '../utils/fetchNui';

const SetupTrack = () => {
  const [trackName, setTrackName] = useState('');
  const [error, setError] = useState('');

  const handleCreateTrack = async (event: FormEvent) => {
    event.preventDefault();

    setError('');
    const [isAuthorized, isNameAvailable, inEditor] = await fetchNui<
      [boolean, boolean, boolean],
      string
    >(NUIEvents.GetIsAuthorizedToCreateRaces, trackName);

    if (!isNameAvailable) {
      setError('Track name is not available.');
      return;
    }

    if (!isAuthorized) {
      setError('You are not authorized to create tracks.');
      return;
    }

    if (inEditor) {
      setError('You are currently in editor.');
      return;
    }

    fetchNui(RacingEvents.CreateTrack, trackName);
  };

  return (
    <div>
      <Typography variant="h6">Setup a new track</Typography>
      <Typography variant="caption">
        Once there's a race created it will show up here. Come back later!
      </Typography>

      <Divider light sx={{ margin: '1.5rem 0' }} />

      <form onSubmit={handleCreateTrack}>
        <Stack spacing={1.5}>
          <TextField
            label="Track name"
            value={trackName}
            onChange={(event) => setTrackName(event.target.value)}
          />

          <Button type="submit">Start creating track</Button>

          {error && (
            <Alert color="error" icon={<ErrorRounded />}>
              {error}
            </Alert>
          )}
        </Stack>
      </form>
    </div>
  );
};

export default SetupTrack;
