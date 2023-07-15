import React from 'react';
import { NuiProvider } from 'react-fivem-hooks';
import styled from 'styled-components';

import { IPhoneSettings } from '@project-error/npwd-types';
import { i18n } from 'i18next';
import { Theme, StyledEngineProvider, Paper, LinearProgress } from '@mui/material';
import ThemeSwitchProvider from './ThemeSwitchProvider';
import Header, { HEADER_HEIGHT } from './components/Header';
import Footer from './components/Footer';
import { RecoilRoot } from 'recoil';
import Routes from './Routes';
import { DataSync } from './components/DataSync';
import { NUIEvents } from '../types/Events';

const Container = styled(Paper)`
  flex: 1;
  display: flex;
  flex-direction: column;
  box-sizing: border-box;
  max-height: 100%;
`;

const Content = styled.div`
  flex: 1;
  display: flex;
  flex-direction: column;
  box-sizing: border-box;
  padding: 1.5rem;
  max-height: calc(100% - 3.5rem - ${HEADER_HEIGHT});
  overflow: auto;
`;

interface AppProps {
  theme: Theme;
  i18n: i18n;
  settings: IPhoneSettings;
}

const App = (props: AppProps) => {
  return (
    <RecoilRoot>
      <StyledEngineProvider injectFirst>
        <ThemeSwitchProvider mode={props.theme.palette.mode}>
          <Container square elevation={0}>
            <React.Suspense
              fallback={
                <LinearProgress
                  color="primary"
                  sx={{ position: 'absolute', top: 0, left: 0, width: '100%' }}
                />
              }
            >
              <DataSync />
            </React.Suspense>

            <Header>Racing</Header>
            <Content>
              <React.Suspense
                fallback={
                  <LinearProgress
                    color="primary"
                    sx={{ position: 'absolute', top: 0, left: 0, width: '100%' }}
                  />
                }
              >
                <Routes />
              </React.Suspense>
            </Content>
            <Footer />
          </Container>
        </ThemeSwitchProvider>
      </StyledEngineProvider>
    </RecoilRoot>
  );
};

const WithProviders: React.FC<AppProps> = (props) => (
  <NuiProvider>
    <App {...props} />
  </NuiProvider>
);

export default WithProviders;
