import {registerPlugin} from '@capacitor/core';

import type { FullScreenPlugin, Insets, InsetsEvent } from './definitions';

import { Type, Style } from './definitions';

const FullScreen = registerPlugin<FullScreenPlugin>('FullScreen');

window.addEventListener('DOMContentLoaded', async () => {
  for (const t of [Type.SafeArea, Type.Keyboard]) {
    const insets = await FullScreen.getInsets({ type: t });
    if (insets) {
      updateInsets(t, insets);
    }
  }
});

window.addEventListener('insetschange', {
  handleEvent(event: InsetsEvent): void {
    console.log(`insetschange: ${JSON.stringify(event.detail)}`);
    updateInsets(event.detail.type, event.detail.insets);
  }
});

function updateInsets(type: Type, insets: Insets): void {
  if (type === Type.SafeArea) {
    updateInsetsVars('safe', insets);
  } else if (type === Type.Keyboard) {
    updateInsetsVars('keyb', insets);
  }
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
