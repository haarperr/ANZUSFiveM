import React, { ReactNode } from 'react';
import { Typography, useTheme } from '@mui/material';
import styled from '@emotion/styled';

export const HEADER_HEIGHT = '4rem';
const Container = styled.div<{ backgroundColor: string }>`
  display: flex;
  align-items: center;

  min-height: ${HEADER_HEIGHT};
  padding-left: 1.5rem;
  background-color: ${({ backgroundColor }) => backgroundColor};
`;

interface HeaderProps {
  children: ReactNode;
}

const Header = ({ children }: HeaderProps) => {
  const theme = useTheme();
  return (
    <Container backgroundColor={theme.palette.primary.main}>
      <Typography variant="h5" color="primary.contrastText">
        {children}
      </Typography>
    </Container>
  );
};

export default Header;
