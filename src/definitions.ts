export interface ToggleOptions {
  show: boolean;
}

export interface ColorOptions {
  color: string;
}

export interface StyleOptions {
  style: Style;
}

export enum Style {
  Dark = 'DARK',
  Light = 'LIGHT',
  Default = 'DEFAULT'
}

export interface FullScreenPlugin {
  toggleStatusBar(options: ToggleOptions): Promise<void>
  setStatusBarColor(options: ColorOptions): Promise<void>
  setStatusBarStyle(options: StyleOptions): Promise<void>
  toggleNavigationBar(options: ToggleOptions): Promise<void>
  setNavigationBarColor(options: ColorOptions): Promise<void>
  setNavigationBarStyle(options: StyleOptions): Promise<void>
}


