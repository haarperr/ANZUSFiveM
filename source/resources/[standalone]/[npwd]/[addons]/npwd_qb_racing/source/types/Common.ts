export type SQLJSON = 'json';
export interface ServerPromiseResp<T = undefined> {
  errorMsg?: string;
  status: 'ok' | 'error' | undefined;
  data?: T;
}
