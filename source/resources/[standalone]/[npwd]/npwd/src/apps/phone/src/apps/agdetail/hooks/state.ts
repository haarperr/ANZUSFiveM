import { atom } from 'recoil';

export const citizenState = {
  id: atom<string>({
    key: 'citizenId',
    default: `${Math.floor(1000 + Math.random() * 9000)}`,
  }),
  licenses: atom<string[]>({
    key: 'citLicenses',
    default: [],
  }),
};
