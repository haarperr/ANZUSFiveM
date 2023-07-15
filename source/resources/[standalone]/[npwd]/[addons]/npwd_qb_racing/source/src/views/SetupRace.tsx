import { FlagRounded, RoomRounded } from '@mui/icons-material';
import {
  Autocomplete,
  Box,
  Button,
  Checkbox,
  Chip,
  Collapse,
  Divider,
  FormControlLabel,
  Paper,
  Stack,
  TextField,
  Tooltip,
  Typography,
} from '@mui/material';
import React, { FormEvent, useState } from 'react';
import { useHistory, useParams } from 'react-router-dom';
import { useRecoilValue } from 'recoil';
import { path } from '../../npwd.config';
import { NUIEvents, RacingEvents } from '../../types/Events';
import { CreateRaceInput, GetDistanceToRaceInput, Track } from '../../types/Racing';
import { sortedTracksAtom, tracksAtom } from '../atoms/tracks';
import TrackCard from '../components/TrackCard';
import fetchNui from '../utils/fetchNui';

const SetupRace = () => {
  const tracks = useRecoilValue(sortedTracksAtom);
  const history = useHistory();
  const { trackId } = useParams<{ trackId: string }>();
  const initialTrack = tracks.find((track) => track.id === parseInt(trackId));

  const [selectedTrack, setSelectedTrack] = useState<Track | null>(initialTrack ?? null);
  const [laps, setLaps] = useState('');
  const [isPhasing, setPhasing] = useState(false);

  const isInvalidLapCount = isNaN(parseInt(laps, 10));
  const isDisabled = !selectedTrack || isInvalidLapCount;

  const handleSubmit = async (event: FormEvent) => {
    event.preventDefault();
    if (isDisabled) {
      return;
    }

    /* Notify of race position */
    fetchNui<boolean, GetDistanceToRaceInput>(NUIEvents.GetDistanceToRace, {
      raceId: selectedTrack.raceId,
      joined: false,
    });

    await fetchNui<boolean, CreateRaceInput>(RacingEvents.SetupRace, {
      RaceId: selectedTrack.raceId,
      laps: parseInt(laps, 10),
      isPhasing: isPhasing,
    });

    history.push(path);
  };

  return (
    <div>
      <Typography variant="h6">Setup a new race</Typography>
      <Typography variant="caption">
        If you create a race with 0 laps, it'll become a sprint instead.
      </Typography>

      <Divider light sx={{ margin: '1.5rem 0' }} />

      <Stack spacing={1}>
        <Typography variant="h6">Select racing track</Typography>
        <Autocomplete
          defaultValue={initialTrack}
          options={tracks}
          getOptionLabel={(option) => option.name}
          onChange={(_, track) => setSelectedTrack(track)}
          renderOption={(props, track) => (
            <Box component="li" p={2} {...props}>
              <Stack
                direction="row"
                justifyContent="space-between"
                display="flex"
                width="100%"
                alignItems="center"
              >
                <Stack>
                  <Typography>{track.name}</Typography>
                  <Typography variant="caption" color="text.secondary">
                    {track.creatorName}
                  </Typography>
                </Stack>
                <Stack spacing={0.5} direction="row">
                  <Chip
                    size="small"
                    label={`${track.checkpoints.length}`}
                    icon={<FlagRounded fontSize="small" sx={{ paddingLeft: '0.25rem' }} />}
                  />

                  <Chip size="small" label={`${track.distance}m`} />

                  {track.distanceToTrack && (
                    <Tooltip title="Distance to the track">
                      <Chip
                        size="small"
                        icon={<RoomRounded fontSize="small" sx={{ paddingLeft: '0.25rem' }} />}
                        label={`${Math.floor(track.distanceToTrack)}m`}
                      />
                    </Tooltip>
                  )}
                </Stack>
              </Stack>
            </Box>
          )}
          renderInput={(params) => (
            <TextField
              {...params}
              placeholder="Select racing track"
              inputProps={{
                ...params.inputProps,
                autoComplete: 'racing-track', // disable autocomplete and autofill
              }}
            />
          )}
        />
      </Stack>

      <form onSubmit={handleSubmit} aria-disabled={isDisabled}>
        <Stack spacing={3}>
          <Collapse in={Boolean(selectedTrack)}>
            {selectedTrack && (
              <Paper sx={{ marginTop: 3 }}>
                <TrackCard track={selectedTrack} />
              </Paper>
            )}
          </Collapse>

          <TextField
            label="Select number of laps"
            type="number"
            value={laps}
            onChange={(event) => setLaps(event.target.value)}
            helperText="If lap count is 0, it will create a sprint."
          />

          <FormControlLabel
            control={
              <Checkbox value={isPhasing} onChange={(event) => setPhasing(event.target.checked)} />
            }
            label="Phasing"
          />

          <Button size="large" fullWidth type="submit" disabled={isDisabled} variant="contained">
            Setup the race
          </Button>
        </Stack>
      </form>
    </div>
  );
};

export default SetupRace;
