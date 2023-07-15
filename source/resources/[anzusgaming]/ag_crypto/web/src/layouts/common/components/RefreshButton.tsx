import { Button } from '@mantine/core';
import { useState } from 'react';
import { TbRefresh } from 'react-icons/tb';

interface Props {
    onClick: () => void;
}

const RefreshButton: React.FC<Props> = ({ onClick }) => {
    const [buttonDisable, setDisabled] = useState(false);
    return (
        <>
            <Button
                sx={{
                    position: 'absolute',
                    top: '1vh',
                    right: '0px',
                    height: 'unset !important',
                    backgroundColor: 'transparent',
                    '&:hover': { background: 'transparent' },
                    '&:disabled': { opacity: 0.5, background: 'transparent' },
                }}
                onClick={() => {
                    setDisabled(true);
                    setTimeout(() => {
                        setDisabled(false);
                    }, 1500);

                    onClick();
                }}
                disabled={buttonDisable}
            >
                <TbRefresh />
            </Button>
        </>
    );
};

export default RefreshButton;
