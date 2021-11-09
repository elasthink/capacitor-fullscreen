import { registerPlugin } from '@capacitor/core';

import type { FullScreenPlugin, InsetsEvent } from './definitions';

const FullScreen = registerPlugin<FullScreenPlugin>('FullScreen');

// Default
document.documentElement.style.setProperty('--safe-area-inset-left', 'env(safe-area-inset-left)');
document.documentElement.style.setProperty('--safe-area-inset-top', 'env(safe-area-inset-top)');
document.documentElement.style.setProperty('--safe-area-inset-right', 'env(safe-area-inset-right)');
document.documentElement.style.setProperty('--safe-area-inset-bottom', 'env(safe-area-inset-bottom)');

// TEST !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
document.documentElement.style.setProperty('--safe-area-inset-top', '36px');
document.documentElement.style.setProperty('--safe-area-inset-bottom', '24px');
// TEST !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

document.addEventListener('insetschange', {
  handleEvent(event: InsetsEvent): void {
    console.log(`insetschange: ${JSON.stringify(event.detail)}`);
    document.documentElement.style.setProperty('--safe-area-inset-left',
        `max(env(safe-area-inset-left),${event.detail.left}px)`);
    document.documentElement.style.setProperty('--safe-area-inset-top',
        `max(env(safe-area-inset-top),${event.detail.top}px)`);
    document.documentElement.style.setProperty('--safe-area-inset-right',
        `max(env(safe-area-inset-right),${event.detail.right}px)`);
    document.documentElement.style.setProperty('--safe-area-inset-bottom',
        `max(env(safe-area-inset-bottom),${event.detail.bottom}px)`);
  }
});

export * from './definitions';
export { FullScreen };
