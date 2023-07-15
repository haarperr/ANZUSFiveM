import {
  Delete,
  Flag,
  FlagRounded,
  LeaderboardRounded,
  MoreVertRounded,
} from '@mui/icons-material';
import {
  Avatar,
  Card,
  CardContent,
  CardHeader,
  Chip,
  IconButton,
  ListItemIcon,
  ListItemText,
  Menu,
  MenuItem,
  MenuList,
  Stack,
  Tooltip,
} from '@mui/material';
import React, { useRef, useState } from 'react';
import { useHistory } from 'react-router-dom';
import { useRecoilValue } from 'recoil';
import { path } from '../../npwd.config';
import { userAtom } from '../atoms/user';
import { Track } from '../../types/Racing';
import { formatTrackTime } from '../utils/racing';
import fetchNui from '../utils/fetchNui';
import { RacingEvents } from '../../types/Events';

interface TrackCardProps {
  track: Track;
  onDelete?(): void;
  isEditable?: boolean;
}

const TrackCard = ({ track, isEditable, onDelete }: TrackCardProps) => {
  const history = useHistory();
  const user = useRecoilValue(userAtom);
  const menuRef = useRef(null);
  const [isExpanded, setIsExpanded] = useState(false);

  const handleToggleExpanded = () => {
    setIsExpanded((prev) => !prev);
  };

  const handleDeleteTrack = async () => {
    const isDeleted = await fetchNui(RacingEvents.DeleteTrack, track.raceId);
    if (isDeleted && onDelete) {
      onDelete();
    }
  };

  const isCreator = track.creatorId === user?.citizenid;

  return (
    <Card elevation={4}>
      <CardHeader
        title={track.name}
        subheader={track.creatorName}
        avatar={
          <Avatar
            alt={track.creatorName}
            sx={{ backgroundColor: 'primary.main', color: 'primary.contrastText' }}
          >
            {track?.creatorName?.substring(0, 1)}
          </Avatar>
        }
        action={
          isEditable && (
            <IconButton onClick={handleToggleExpanded} ref={menuRef}>
              <MoreVertRounded />
            </IconButton>
          )
        }
      />

      <Menu
        open={isExpanded}
        onClose={handleToggleExpanded}
        anchorEl={menuRef.current}
        anchorOrigin={{ vertical: 'bottom', horizontal: 'right' }}
        transformOrigin={{
          vertical: 'top',
          horizontal: 'right',
        }}
      >
        <MenuList dense disablePadding>
          {isCreator && (
            <MenuItem onClick={handleDeleteTrack}>
              <ListItemIcon>
                <Delete />
              </ListItemIcon>
              <ListItemText>Delete</ListItemText>
            </MenuItem>
          )}
          <MenuItem onClick={() => history.push(`${path}/setupRace/${track.id}`)}>
            <ListItemIcon>
              <Flag />
            </ListItemIcon>
            <ListItemText>Start race from this track</ListItemText>
          </MenuItem>
        </MenuList>
      </Menu>

      <CardContent>
        <Stack direction="row" spacing={1}>
          <Tooltip title="Track record">
            <Chip
              icon={<LeaderboardRounded fontSize="small" sx={{ paddingLeft: '0.35rem' }} />}
              label={`${formatTrackTime(track.record?.time ?? 0)}`}
            />
          </Tooltip>

          <Tooltip title="Number of checkpoints">
            <Chip
              label={`${track.checkpoints.length}`}
              icon={<FlagRounded fontSize="small" sx={{ paddingLeft: '0.25rem' }} />}
            />
          </Tooltip>

          <Tooltip title="Track length">
            <Chip label={`${(track.distance / 1609).toFixed(2)}m`} />
          </Tooltip>
        </Stack>
      </CardContent>
    </Card>
  );
};

export default TrackCard;
