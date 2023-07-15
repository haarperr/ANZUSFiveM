import App from './src/App';
import { AppIcon } from './icon';

const defaultLanguage = 'en';
const localizedAppName = {
  en: 'Dark Web',
};

interface Settings {
  language: 'en';
}

export const path = '/darkweb';
export default (settings: Settings) => ({
  id: 'DARKWEB',
  path,
  nameLocale: localizedAppName[settings?.language ?? defaultLanguage],
  color: '#fff',
  backgroundColor: '#333',
  icon: AppIcon,
  app: App,
  notificationIcon: AppIcon,
});
