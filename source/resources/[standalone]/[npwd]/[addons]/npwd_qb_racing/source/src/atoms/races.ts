import { ServerPromiseResp } from '@project-error/npwd-types';
import { atom, selector } from 'recoil';
import { RacingEvents } from '../../types/Events';
import { Race, Track } from '../../types/Racing';
import fetchNui from '../utils/fetchNui';
import { isEnvBrowser } from '../utils/misc';
import { MockedRaces } from '../utils/mocks';

export const racesAtom = atom<Race[]>({
  key: 'qb:races',
  default: selector<Race[]>({
    key: 'qb:defaultRaces',
    get: async () => {
      try {
        const resp = await fetchNui<ServerPromiseResp<Race[]>>(RacingEvents.GetRaces);

        if (!resp.data) {
          console.log('no response data');
          return [];
        }

        return resp.data;
      } catch {
        if (isEnvBrowser()) {
          return MockedRaces;
        }

        return [];
      }
    },
  }),
});
