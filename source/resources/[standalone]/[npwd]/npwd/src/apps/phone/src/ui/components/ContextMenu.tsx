import React from 'react';
import { ListItemIcon, ListItemText, Slide, Paper, Tooltip } from '@mui/material';
import StarIcon from '@mui/icons-material/Star';
import makeStyles from '@mui/styles/makeStyles';
import { List } from './List';
import { ListItem } from './ListItem';
import { useTranslation } from 'react-i18next';

const useStyles = makeStyles((theme) => ({
  root: {
    borderTop: '1px solid',
    borderColor: theme.palette.primary.main,
    width: '100%',
    minHeight: '10%',
    maxHeight: '100%',
    zIndex: 2,
    overflow: 'auto',
  },
}));

export interface IContextMenuOption {
  onClick(e, option): void;
  label: string;
  description?: string;
  selected?: boolean;
  premium?: number;
  icon?: React.ReactNode;
  key?: string;
}

interface ContextMenuProps {
  open: boolean;
  onClose: () => void;
  options: Array<IContextMenuOption>;
}

export const ContextMenu: React.FC<ContextMenuProps> = ({ open, onClose, options }) => {
  const classes = useStyles();
  const [t] = useTranslation();

  const _options = onClose
    ? [
        ...options,
        {
          label: t('GENERIC.CLOSE'),
          onClick: onClose,
        } as IContextMenuOption,
      ]
    : options;

  return (
    <Slide
      direction="up"
      in={open}
      style={{ position: 'absolute', bottom: 0 }}
      mountOnEnter
      unmountOnExit
    >
      <Paper square className={classes.root}>
        <List disablePadding>
          {_options.map((option) => (
            <ListItem
              selected={option.selected}
              key={option.key || option.label}
              button
              onClick={(e) => {
                option.onClick(e, option);
                onClose();
              }}
            >
              {option.icon && <ListItemIcon>{option.icon}</ListItemIcon>}
              <ListItemText primary={option.label} secondary={option.description} />
              {!!option.premium && (
                <ListItemIcon>
                  <Tooltip
                    title={t('SETTINGS.TOOLTIPS.PREMIUM_OPTION', { premiumLevel: option.premium })}
                  >
                    <StarIcon />
                  </Tooltip>
                </ListItemIcon>
              )}
            </ListItem>
          ))}
        </List>
      </Paper>
    </Slide>
  );
};
