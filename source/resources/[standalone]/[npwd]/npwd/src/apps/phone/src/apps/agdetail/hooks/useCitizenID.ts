import { useRecoilValue, useSetRecoilState } from 'recoil';
import { citizenState } from './state';
import { PhoneEvents } from '@typings/phone';
import { useNuiEvent } from '@common/hooks/useNuiEvent';
import InjectDebugData from '@os/debug/InjectDebugData';

// call this function in the Phone.tsx file.

InjectDebugData([
    {
        app: 'AGDETAIL',
        method: PhoneEvents.SET_CITIZEN_ID,
        data: `${Math.floor(1000 + Math.random() * 9000)}`,
    },
]);

export const useCitizenIDService = () => {
    const setCID = useSetRecoilState(citizenState.id);
    useNuiEvent('AGDETAIL', PhoneEvents.SET_CITIZEN_ID, setCID);
    return useCitizenID();
};

export const useCitizenID = () => useRecoilValue(citizenState.id);
