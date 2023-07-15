import React from 'react';
import { AppWrapper } from '@ui/components';
import { AppContent } from '@ui/components/AppContent';
import { useApp } from '@os/apps/hooks/useApps';
import { AppTitle } from '@ui/components/AppTitle';
import { AGDetailCategory } from './AGDetailCategory';
import { AGDetailItem, AGDetailItemIconAction } from './AGDetailItems';
import { setClipboard } from '@os/phone/hooks';
import { useSnackbar } from '@os/snackbar/hooks/useSnackbar';
import { useTranslation } from 'react-i18next';
import { FileCopy, Phone, Badge, CheckCircle, Close } from '@mui/icons-material';
import { useMyPhoneNumber } from '@os/simcard/hooks/useMyPhoneNumber';
import { useCitizenID } from '../hooks/useCitizenID';
import { useLicenses } from '../hooks/useLicenses';
import { useTheme } from '@mui/material';

export const AGDetailApp: React.FC = () => {
  const detailApp = useApp('AGDETAIL');
  const { addAlert } = useSnackbar();
  const [t] = useTranslation();

  const myNumber = useMyPhoneNumber();
  const myCID = useCitizenID();
  let licenses = useLicenses();
  if (typeof licenses == 'string') {
    licenses = JSON.parse(licenses);
  }

  const handleCopyPhoneNumber = () => {
    setClipboard(myNumber);
    addAlert({
      message: t('GENERIC.WRITE_TO_CLIPBOARD_MESSAGE', {
        content: 'number',
      }),
      type: 'success',
    });
  };

  const handleCopyStateID = () => {
    setClipboard(myCID);
    addAlert({
      message: t('GENERIC.WRITE_TO_CLIPBOARD_MESSAGE', {
        content: 'citizen id',
      }),
      type: 'success',
    });
  };

  const theme = useTheme();

  return (
    <AppWrapper>
      <AppTitle app={detailApp} />
      <AppContent>
        <AGDetailCategory title="General Information">
          <AGDetailItemIconAction
            label="Citizen ID"
            labelSecondary={myCID}
            actionLabel={t('GENERIC.WRITE_TO_CLIPBOARD_TOOLTIP', {
              content: 'citizen id',
            })}
            icon={<Badge />}
            actionIcon={<FileCopy />}
            theme={theme}
            handleAction={handleCopyStateID}
          />
          <AGDetailItemIconAction
            label={t('SETTINGS.PHONE_NUMBER')}
            labelSecondary={myNumber}
            actionLabel={t('GENERIC.WRITE_TO_CLIPBOARD_TOOLTIP', {
              content: 'number',
            })}
            icon={<Phone />}
            actionIcon={<FileCopy />}
            theme={theme}
            handleAction={handleCopyPhoneNumber}
          />
        </AGDetailCategory>

        <AGDetailCategory title="Licenses">
          {licenses.length === 0 ? (
            <AGDetailItem label="No licences" icon={<Close />} theme={theme} />
          ) : (
            licenses.map((license) => (
              <AGDetailItem label={license} icon={<CheckCircle />} theme={theme} />
            ))
          )}
        </AGDetailCategory>
      </AppContent>
    </AppWrapper>
  );
};
