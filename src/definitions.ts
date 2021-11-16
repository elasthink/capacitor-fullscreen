export enum Style {
  Dark = 'dark',
  Light = 'light'
}

export enum InsetsType {
  SafeArea = "safe-area",
  Keyboard = "keyboard"
}

export interface Insets {
  top : number,
  right : number,
  bottom : number,
  left : number
}

export interface InsetsEvent {
  type: InsetsType,
  insets: Insets
}

export interface ColorOptions {
  color: string
}

export interface StyleOptions {
  style: Style
}

export interface ToggleOptions {
  enabled: boolean
}

export interface FullScreenPlugin {

  /* SAFE-AREA
   * ================================================================================================================ */

  getSafeAreaInsets(): Promise<Insets>


  /* STATUS-BAR
   * ================================================================================================================ */

  showStatusBar(): Promise<void>

  hideStatusBar(): Promise<void>

  setStatusBarColor(options: ColorOptions): Promise<void>

  setStatusBarStyle(options: StyleOptions): Promise<void>

  isStatusBarVisible(): Promise<boolean>


  /* NAVIGATION-BAR
   * ================================================================================================================ */

  showNavigationBar(): Promise<void>

  hideNavigationBar(): Promise<void>

  setNavigationBarColor(options: ColorOptions): Promise<void>

  setNavigationBarStyle(options: StyleOptions): Promise<void>

  isNavigationBarVisible(): Promise<boolean>


  /* KEYBOARD
   * ================================================================================================================ */

  showKeyboard(): Promise<void>

  hideKeyboard(): Promise<void>

  isKeyboardVisible(): Promise<boolean>

  getKeyboardInsets(): Promise<Insets>

  toggleAccessoryBar(options: ToggleOptions): Promise<void>

  toggleScroll(options: ToggleOptions): Promise<void>


  /* EVENTS
   * ================================================================================================================ */

  addListener(eventName: 'insets', listener: (event: InsetsEvent) => void): Promise<void>

  addListener(eventName: 'keyboardshow', listener: (insets: Insets) => void): Promise<void>

  addListener(eventName: 'keyboardhide', listener: () => void): Promise<void>

}