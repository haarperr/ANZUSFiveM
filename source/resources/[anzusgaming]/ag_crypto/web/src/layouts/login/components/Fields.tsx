import Input from '../../common/components/Input';
import { useStore, useSetters } from '../../../store';

const Inputs: React.FC = () => {
    const keyPhrase = useStore((state) => state.keyPhrase);
    const setKeyPhrase = useSetters((setter) => setter.setKeyPhrase);

    return (
        <Input
            label="Key Phrase"
            type="password"
            span={2}
            sx={{ width: '100%' }}
            infoCircle="The key phrase of the wallet you wish to login to"
            value={keyPhrase || ''}
            setValue={setKeyPhrase}
        />
    );
};

export default Inputs;
