import { ServerPromiseResp } from '@project-error/npwd-types';
import { atom, selector } from 'recoil';
import fetchNui from '../utils/fetchNui';
import { isEnvBrowser } from '../utils/misc';
import { NUIEvents } from '../../types/events';
import { Item } from '../../types/item';
import { MockedItems } from '../utils/mocks';

export const itemsAtom = atom<Item[]>({
  key: 'ag:dwitems',
  default: selector<Item[]>({
    key: 'ag:dwdefaultItems',
    get: async () => {
      try {
        const resp = await fetchNui<ServerPromiseResp<Item[]>>(NUIEvents.GetItems);

        if (!resp.data) {
          console.log('no response data');
          return [];
        }

        return resp.data;
      } catch {
        if (isEnvBrowser()) {
          return MockedItems;
        }

        return [];
      }
    },
  }),
});
