// Will return whether the current environment is in a regular browser
// and not CEF
export const isEnvBrowser = (): boolean => !(window as any).invokeNative

// Basic no operation function
export const noop = () => {}

let options: Intl.DateTimeFormatOptions = {
    timeZone: 'America/Los_Angeles',
    year: '2-digit',
    month: '2-digit',
    day: '2-digit',
    hour: '2-digit',
    minute: '2-digit',
    second: '2-digit',
    hour12: true,
};

export const dateFormatter = (date: Date, override?: any) => {return (new Intl.DateTimeFormat([], {...options, ...override}).format(date))};