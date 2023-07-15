export const formatTrackTime = (time: number) => {
  const _time = time / 100;

  const minutes = Math.floor(_time / 60);
  const seconds = Math.floor(_time - minutes * 60);

  return `${minutes}m ${seconds}s`;
};
