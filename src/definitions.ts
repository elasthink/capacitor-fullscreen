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

export interface ScrollOptions {
  disabled: boolean
}

export interface FullScreenPlugin {


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

  showAccessoryBar(): Promise<void>

  hideAccessoryBar(): Promise<void>

  getKeyboardInsets(): Promise<Insets>

  toggleScroll(options: ScrollOptions): Promise<void>


  /* INSETS
   * ================================================================================================================ */

  getSafeAreaInsets(): Promise<Insets>

  addListener(eventName: 'insets', listener: (event: InsetsEvent) => void): Promise<void>

  addListener(eventName: 'keyboardshow', listener: (insets: Insets) => void): Promise<void>

  addListener(eventName: 'keyboardhide', listener: () => void): Promise<void>

}