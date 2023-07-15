import { SQLJSON } from './Common';

export interface RawUser {
  id: number;
  cid: number;
  citizenid: string;
  license: string;
  name: string;
  money: SQLJSON;
  job: SQLJSON;
  charinfo: SQLJSON;
  gang: SQLJSON;
  position: SQLJSON;
  metadata: SQLJSON;
  inventory: SQLJSON;
  last_updated: number;
}

export interface User {
  id: string;
  cid: number;
  citizenid: string;
  license: string;
  name: string;
  money: {
    bank: number;
    cash: number;
    crypto: number;
  };
  charInfo: {
    cid: string;
    firstname: string;
    nationality: string;
    account: string;
    card: number;
    birthdate: string;
    gender: number;
    lastname: string;
    backstory: string;
    phone: string;
  };
}
