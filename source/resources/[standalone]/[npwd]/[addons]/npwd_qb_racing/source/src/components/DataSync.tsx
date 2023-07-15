import { useNuiEvent } from 'react-fivem-hooks';
import { useRecoilRefresher_UNSTABLE, useRecoilValue } from 'recoil';
import { NUIEvents } from '../../types/Events';
import { racesAtom } from '../atoms/races';
import { tracksAtom } from '../atoms/tracks';
import { userAtom } from '../atoms/user';

export const DataSync = () => {
  useRecoilValue(racesAtom);
  useRecoilValue(userAtom);
  useRecoilValue(tracksAtom);
  const refreshRaces = useRecoilRefresher_UNSTABLE(racesAtom);
  const refreshTracks = useRecoilRefresher_UNSTABLE(tracksAtom);
  const refreshUser = useRecoilRefresher_UNSTABLE(userAtom);

  useNuiEvent({
    event: NUIEvents.UpdateData,
    callback: () => {
      console.log('updatedata');
      refreshUser();
      refreshRaces();
      refreshTracks();
    },
  });

  return null;
};
