import { useRecoilValue, useSetRecoilState } from 'recoil';
import { citizenState } from './state';
import { PhoneEvents } from '@typings/phone';
import { useNuiEvent } from '@common/hooks/useNuiEvent';
import InjectDebugData from '@os/debug/InjectDebugData';

InjectDebugData([
    {
        app: 'AGDETAIL',
        method: PhoneEvents.SET_LICENCES,
        data: [],
    },
]);

export const useLicensesService = () => {
    const SetLicenses = useSetRecoilState(citizenState.licenses);
    useNuiEvent('AGDETAIL', PhoneEvents.SET_LICENCES, SetLicenses);
    return useLicenses();
};

export const useLicenses = () => useRecoilValue(citizenState.licenses);
