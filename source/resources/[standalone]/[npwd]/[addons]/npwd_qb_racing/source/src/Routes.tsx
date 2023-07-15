import React from 'react';
import { Route, Switch } from 'react-router-dom';
import { path } from '../npwd.config';
import Races from './views/Races';
import Tracks from './views/Tracks';
import SetupRace from './views/SetupRace';
import SetupTrack from './views/SetupTrack';

const Routes = () => {
  return (
    <Switch>
      <Route exact path={`${path}`} component={Races} />
      <Route path={`${path}/setupRace/:trackId?`} component={SetupRace} />
      <Route path={`${path}/setupTrack`} component={SetupTrack} />
      <Route path={`${path}/tracks`} component={Tracks} />
    </Switch>
  );
};

export default Routes;
