import { useNuiEvent } from 'react-fivem-hooks';
import { useRecoilRefresher_UNSTABLE, useRecoilValue } from 'recoil';
import { NUIEvents } from '../../types/events';
import { itemsAtom } from '../atoms/market';

export const DataSync = () => {
  useRecoilValue(itemsAtom);
  const refreshRaces = useRecoilRefresher_UNSTABLE(itemsAtom);

  useNuiEvent({
    event: NUIEvents.UpdateData,
    callback: () => {
      refreshRaces();
    },
  });

  return null;
};
