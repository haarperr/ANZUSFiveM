import React from 'react';
import { Route, Switch } from 'react-router-dom';
import { path } from '../npwd.config';
import Items from './views/Items';
import Basket from './views/Basket';

const Routes = () => {
  return (
    <Switch>
      <Route exact path={`${path}`} component={Items} />
      <Route path={`${path}/basket`} component={Basket} />
    </Switch>
  );
};

export default Routes;
