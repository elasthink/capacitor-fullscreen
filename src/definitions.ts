export enum Style {
  Dark = 'dark',
  Light = 'light'
}

export enum Type {
  SafeArea = "safe-area",
  StatusBar = "status-bar",
  NavigationBar = "navigation-bar",
  Keyboard = "keyboard",
  AccessoryBar = "accessory-bar"
}

export interface Insets {
  top : number,
  right : number,
  bottom : number,
  left : number
}

export interface InsetsEvent extends Event {
  detail: {
    type: Type,
    insets: Insets
  }
}

export interface InsetsOptions {
  type: Type
}

export interface ColorOptions extends InsetsOptions {
  color: string
}

export interface StyleOptions extends InsetsOptions {
  style: Style
}

export interface ScrollOptions {
  disabled: boolean
}

export interface FullScreenPlugin {

  Type: any,

  Style: any,

  toggle(options: InsetsOptions): Promise<void>

  getInsets(options: InsetsOptions): Promise<Insets>

  isVisible(options: InsetsOptions): Promise<boolean>

  setColor(options: ColorOptions): Promise<boolean>

  setStyle(options: StyleOptions): Promise<boolean>

  toggleScroll(options: ScrollOptions): Promise<void>

}