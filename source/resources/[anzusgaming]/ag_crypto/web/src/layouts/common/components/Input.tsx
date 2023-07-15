import { Box, Grid, Tooltip, TextInput, NumberInput, ThemeIcon } from '@mantine/core';

import { BsQuestionCircle } from 'react-icons/bs';

interface Props {
    label: string;
    type: 'text' | 'number' | 'password';
    value?: string | number;
    setValue: (value: any) => void;
    infoCircle?: string;
    span?: number;
    sx?: any;
    disabled?: boolean;
}

const Input: React.FC<Props> = ({ label, type, infoCircle, span, value, setValue, sx, disabled }) => {
    return (
        <Grid.Col span={span || 1}>
            <Box>
                {type === 'text' || type === 'password' ? (
                    <TextInput
                        value={value}
                        type={type}
                        onChange={(e) => setValue(e.target.value)}
                        label={label}
                        sx={sx}
                        disabled={disabled}
                        rightSection={
                            infoCircle && (
                                <Tooltip label={infoCircle} withArrow arrowSize={10} multiline width={200}>
                                    <ThemeIcon variant="light" mr={10}>
                                        <BsQuestionCircle size={18} />
                                    </ThemeIcon>
                                </Tooltip>
                            )
                        }
                    />
                ) : (
                    <NumberInput
                        label={label}
                        step={0.1}
                        precision={2}
                        min={0}
                        value={typeof value === 'number' ? value : undefined}
                        onChange={(value) => setValue(value as number)}
                        hideControls
                        rightSection={
                            infoCircle && (
                                <Tooltip label={infoCircle} withArrow arrowSize={10} multiline width={200}>
                                    <ThemeIcon variant="light" mr={10}>
                                        <BsQuestionCircle size={18} />
                                    </ThemeIcon>
                                </Tooltip>
                            )
                        }
                    />
                )}
            </Box>
        </Grid.Col>
    );
};

export default Input;
