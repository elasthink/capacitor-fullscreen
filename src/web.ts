import { WebPlugin } from '@capacitor/core';

import type { FullScreenPlugin } from './definitions';

export class FullScreenWeb extends WebPlugin implements FullScreenPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
