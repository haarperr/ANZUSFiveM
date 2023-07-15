import { ServerPromiseResp } from '@project-error/npwd-types';
import { atom, selector } from 'recoil';
import { RacingEvents } from '../../types/Events';
import { User } from '../../types/User';
import fetchNui from '../utils/fetchNui';
import { isEnvBrowser } from '../utils/misc';
import { MockerUser } from '../utils/mocks';

export const userAtom = atom<User | null>({
  key: 'npwd-qb-racing:user',
  default: selector<User | null>({
    key: 'npwd-qb-racing:default-user',
    get: async () => {
      try {
        const resp = await fetchNui<ServerPromiseResp<User>>(RacingEvents.GetUser);

        if (!resp.data) {
          console.log('no response data');
          return null;
        }

        return resp.data;
      } catch {
        if (isEnvBrowser()) {
          return MockerUser;
        }

        return null;
      }
    },
  }),
});
