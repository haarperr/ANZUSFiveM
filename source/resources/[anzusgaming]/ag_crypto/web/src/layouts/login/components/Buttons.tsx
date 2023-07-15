import { Button } from '@mantine/core';

const ButtonStyle = {
    top: '3.3vh',
    width: '50%',
    marginBottom: '2px',
    left: '20%',
    marginRight: '2vw',
    marginLeft: '1vw',
};

interface Props {
    showGeneration: boolean;
    disableLoginButton: boolean;
    onLoginClick: () => void;
    onGenerationClick: () => void;
}

const Buttons: React.FC<Props> = ({ showGeneration, disableLoginButton, onLoginClick, onGenerationClick }) => {
    return (
        <>
            <Button sx={ButtonStyle} onClick={onLoginClick} disabled={disableLoginButton}>
                Login
            </Button>

            {showGeneration ? (
                <Button sx={ButtonStyle} onClick={onGenerationClick}>
                    Generate Wallet
                </Button>
            ) : (
                <></>
            )}
        </>
    );
};

export default Buttons;
