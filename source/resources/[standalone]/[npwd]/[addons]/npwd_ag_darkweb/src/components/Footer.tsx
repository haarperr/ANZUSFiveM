import { HomeRounded } from '@mui/icons-material';
import { Badge, BadgeProps, BottomNavigation, BottomNavigationAction, styled } from '@mui/material';
import React, { useEffect, useState } from 'react';
import { NavLink, useLocation } from 'react-router-dom';
import { path } from '../../npwd.config';
import { useCartItems } from '../atoms/cart';
import ShoppingCartIcon from '@mui/icons-material/ShoppingCart';

const StyledBadge = styled(Badge)<BadgeProps>(({ theme }) => ({
  '& .MuiBadge-badge': {
    right: -3,
    border: `2px solid ${theme.palette.background.paper}`,
    padding: '0 4px',
  },
}));

const MyBottomNavigation = styled(BottomNavigation)({
  '& .Mui-selected': {
    color: 'white',
    '& .MuiBottomNavigationAction-label': {
      color: 'white',
    },
    '& .MuiSvgIcon-root': {
      fill: 'white',
    },
  },
  '& .MuiBottomNavigationAction-label': {
    color: 'gray',
  },
});

const Footer = () => {
  const location = useLocation();
  const [page, setPage] = useState('');

  const cartItems = useCartItems();
  const [amount, setAmount] = useState(0);

  const handleChange = (_e: unknown, page: string) => {
    setPage(page);
  };

  useEffect(() => {
    setPage(location.pathname.replace(path, ''));
  }, [location]);

  useEffect(() => {
    setAmount(cartItems.reduce((sum, obj) => sum + obj.amount, 0));
  }, [cartItems]);

  return (
    <MyBottomNavigation value={page} onChange={handleChange} showLabels>
      <BottomNavigationAction
        label={'Home'}
        value=""
        color="primary"
        component={NavLink}
        icon={<HomeRounded />}
        to={path}
      />
      <BottomNavigationAction
        label={'Basket'}
        value="/basket"
        color="primary"
        component={NavLink}
        icon={
          <StyledBadge badgeContent={amount} color="secondary">
            <ShoppingCartIcon />
          </StyledBadge>
        }
        to={`${path}/basket`}
      />
    </MyBottomNavigation>
  );
};

export default Footer;
