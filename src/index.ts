import { registerPlugin } from '@capacitor/core';

import type { InsetsPlugin, Rect } from './definitions';
import { InsetsType } from './definitions';

const Insets = registerPlugin<InsetsPlugin>('Insets');

// Init:
Insets.getSafeAreaInsets().then(insets => {
  updateSafeAreaInsets(insets);
});

Insets.getKeyboardInsets().then(insets => {
  updateKeyboardInsets(insets);
});

// Event: "insetschange"
Insets.addListener('insets', event => {
  console.log(`[insets] ${event.type}: ${JSON.stringify(event.insets)}`);
  if (InsetsType.SafeArea === event.type) {
    updateSafeAreaInsets(event.insets);
  } else if (InsetsType.Keyboard === event.type) {
    updateKeyboardInsets(event.insets);
  }
});

function updateSafeAreaInsets(insets: Rect): void {
  const prefix = 'safe';
  const style = document.documentElement.style;
  style.setProperty(`--${prefix}-ins-top`, `${insets.top}px`);
  style.setProperty(`--${prefix}-ins-right`, `${insets.right}px`);
  style.setProperty(`--${prefix}-ins-bottom`, `${insets.bottom}px`);
  style.setProperty(`--${prefix}-ins-left`, `${insets.left}px`);
}

function updateKeyboardInsets(insets: Rect): void {
  const prefix = 'keyb';
  const style = document.documentElement.style;
  style.setProperty(`--${prefix}-ins-bottom`, `${insets.bottom}px`);
}

export { Insets };
