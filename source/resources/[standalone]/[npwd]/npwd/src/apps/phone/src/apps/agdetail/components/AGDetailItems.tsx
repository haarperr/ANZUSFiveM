import React from 'react';
import {
  ListItem,
  ListItemText,
  ListItemIcon,
  ListItemSecondaryAction,
  IconButton,
  Typography,
} from '@mui/material';
import { Tooltip } from '@ui/components/Tooltip';

interface AGDetailItemProps {
  options?: any;
  label: string;
  value?: string | object | number | null;
  onClick?: any;
  icon: JSX.Element;
  theme: any;
}

export const AGDetailItem: React.FC<AGDetailItemProps> = ({
  options,
  label,
  value,
  onClick,
  icon,
  theme,
}) => (
  <ListItem divider>
    <ListItemIcon>{icon}</ListItemIcon>
    <ListItemText
      primary={<Typography style={{ color: theme.palette.text.primary }}>{label}</Typography>}
      secondary={
        <Typography style={{ color: theme.palette.text.secondary }}>
          {value ? value : undefined}
        </Typography>
      }
    />
  </ListItem>
);

interface AGDetailItemIconActionProps {
  icon: JSX.Element;
  actionIcon: JSX.Element;
  label: string;
  labelSecondary: string;
  handleAction: () => void;
  actionLabel: string;
  theme: any;
}

export const AGDetailItemIconAction: React.FC<AGDetailItemIconActionProps> = ({
  icon,
  label,
  handleAction,
  actionIcon,
  labelSecondary,
  actionLabel,
  theme,
}) => (
  <>
    <ListItem divider>
      <ListItemIcon>{icon}</ListItemIcon>
      <ListItemText
        primary={<Typography style={{ color: theme.palette.text.primary }}>{label}</Typography>}
        secondary={
          <Typography style={{ color: theme.palette.text.secondary }}>{labelSecondary}</Typography>
        }
      />
      <ListItemSecondaryAction>
        <Tooltip
          arrow
          title={<Typography variant="body2">{actionLabel}</Typography>}
          placement="top-end"
        >
          <IconButton edge="end" onClick={handleAction} size="large">
            {actionIcon}
          </IconButton>
        </Tooltip>
      </ListItemSecondaryAction>
    </ListItem>
  </>
);
