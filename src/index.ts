import { registerPlugin } from '@capacitor/core';

import type { FullScreenPlugin } from './definitions';

const FullScreen = registerPlugin<FullScreenPlugin>('FullScreen', {
  web: () => import('./web').then(m => new m.FullScreenWeb()),
});

export * from './definitions';
export { FullScreen };
