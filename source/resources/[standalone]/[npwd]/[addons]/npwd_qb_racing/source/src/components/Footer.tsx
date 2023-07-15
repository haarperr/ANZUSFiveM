import { AddRounded, FlagCircleRounded } from '@mui/icons-material';
import FormatListBulletedRoundedIcon from '@mui/icons-material/FormatListBulletedRounded';
import { BottomNavigation, BottomNavigationAction } from '@mui/material';
import React, { useEffect, useState } from 'react';
import { NavLink, useLocation } from 'react-router-dom';
import { path } from '../../npwd.config';

const Footer = () => {
  const location = useLocation();
  const [page, setPage] = useState('');

  const handleChange = (_e: unknown, page: string) => {
    setPage(page);
  };

  useEffect(() => {
    setPage(location.pathname.replace(path, ''));
  }, [location]);

  return (
    <BottomNavigation value={page} onChange={handleChange} showLabels>
      <BottomNavigationAction
        label={'Races'}
        value=""
        component={NavLink}
        icon={<FormatListBulletedRoundedIcon />}
        to={`${path}`}
      />

      <BottomNavigationAction
        label={'Setup race'}
        value="/setupRace"
        color="secondary"
        component={NavLink}
        icon={<AddRounded />}
        to={`${path}/setupRace`}
      />

      <BottomNavigationAction
        label={'Tracks'}
        value="/tracks"
        color="secondary"
        component={NavLink}
        icon={<FlagCircleRounded />}
        to={`${path}/tracks`}
      />
    </BottomNavigation>
  );
};

export default Footer;
