import {registerPlugin} from '@capacitor/core';

import type { FullScreenPlugin, Insets, InsetsEvent } from './definitions';

import { Type, Style } from './definitions';

const FullScreen = registerPlugin<FullScreenPlugin>('FullScreen');

// Init
for (const t of [Type.SafeArea, Type.Keyboard]) {
  FullScreen.getInsets({ type: t }).then(insets => {
    if (insets) {
      updateInsets(t, insets);
    }
  });
}

// Event: insetschange
window.addEventListener('insetschange', {
  handleEvent(event: InsetsEvent): void {
    updateInsets(event.detail.type, event.detail.insets);
  }
});

function updateInsets(type: Type, insets: Insets): void {
  console.log(`Updating insets (${type}): ${JSON.stringify(insets)}`);
  let prefix;
  if (type === Type.SafeArea) {
    prefix = 'safe';
  } else if (type === Type.Keyboard) {
    prefix = 'keyb';
  } else {
    return;
  }
  updateInsetsVars(prefix, insets);
}

function updateInsetsVars(prefix: string, insets: Insets): void {
  let style = document.documentElement.style;
  style.setProperty(`--${prefix}-ins-top`, `${insets.top}px`);
  style.setProperty(`--${prefix}-ins-right`, `${insets.right}px`);
  style.setProperty(`--${prefix}-ins-bottom`, `${insets.bottom}px`);
  style.setProperty(`--${prefix}-ins-left`, `${insets.left}px`);
}

FullScreen.Type = Type;
FullScreen.Style = Style;

export { FullScreen };
