import App from './src/App';
import { AppIcon, NotificationIcon } from './icon';

const defaultLanguage = 'en';
const localizedAppName = {
  en: 'Racing',
  sv: 'RacerBoi',
};

interface Settings {
  language: 'en';
}

export const path = '/racing';

export default (settings: Settings) => ({
  id: 'RACING',
  path,
  nameLocale: localizedAppName[settings?.language ?? defaultLanguage],
  color: '#fff',
  backgroundColor: '#e65100',
  icon: AppIcon,
  notificationIcon: NotificationIcon,
  app: App,
});
