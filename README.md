# capacitor-fullscreen

Capacitor plugin to control full screen mode on Android and iOS devices.

## Install

```bash
npm install capacitor-fullscreen
npx cap sync
```

## API

<docgen-index>

* [`getSafeAreaInsets()`](#getsafeareainsets)
* [`showStatusBar()`](#showstatusbar)
* [`hideStatusBar()`](#hidestatusbar)
* [`setStatusBarColor(...)`](#setstatusbarcolor)
* [`setStatusBarStyle(...)`](#setstatusbarstyle)
* [`isStatusBarVisible()`](#isstatusbarvisible)
* [`showNavigationBar()`](#shownavigationbar)
* [`hideNavigationBar()`](#hidenavigationbar)
* [`setNavigationBarColor(...)`](#setnavigationbarcolor)
* [`setNavigationBarStyle(...)`](#setnavigationbarstyle)
* [`isNavigationBarVisible()`](#isnavigationbarvisible)
* [`showKeyboard()`](#showkeyboard)
* [`hideKeyboard()`](#hidekeyboard)
* [`isKeyboardVisible()`](#iskeyboardvisible)
* [`getKeyboardInsets()`](#getkeyboardinsets)
* [`toggleAccessoryBar(...)`](#toggleaccessorybar)
* [`toggleScroll(...)`](#togglescroll)
* [`addListener(...)`](#addlistener)
* [`addListener(...)`](#addlistener)
* [`addListener(...)`](#addlistener)
* [Interfaces](#interfaces)
* [Enums](#enums)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### getSafeAreaInsets()

```typescript
getSafeAreaInsets() => any
```

**Returns:** <code>any</code>

--------------------


### showStatusBar()

```typescript
showStatusBar() => any
```

**Returns:** <code>any</code>

--------------------


### hideStatusBar()

```typescript
hideStatusBar() => any
```

**Returns:** <code>any</code>

--------------------


### setStatusBarColor(...)

```typescript
setStatusBarColor(options: ColorOptions) => any
```

| Param         | Type                                                  |
| ------------- | ----------------------------------------------------- |
| **`options`** | <code><a href="#coloroptions">ColorOptions</a></code> |

**Returns:** <code>any</code>

--------------------


### setStatusBarStyle(...)

```typescript
setStatusBarStyle(options: StyleOptions) => any
```

| Param         | Type                                                  |
| ------------- | ----------------------------------------------------- |
| **`options`** | <code><a href="#styleoptions">StyleOptions</a></code> |

**Returns:** <code>any</code>

--------------------


### isStatusBarVisible()

```typescript
isStatusBarVisible() => any
```

**Returns:** <code>any</code>

--------------------


### showNavigationBar()

```typescript
showNavigationBar() => any
```

**Returns:** <code>any</code>

--------------------


### hideNavigationBar()

```typescript
hideNavigationBar() => any
```

**Returns:** <code>any</code>

--------------------


### setNavigationBarColor(...)

```typescript
setNavigationBarColor(options: ColorOptions) => any
```

| Param         | Type                                                  |
| ------------- | ----------------------------------------------------- |
| **`options`** | <code><a href="#coloroptions">ColorOptions</a></code> |

**Returns:** <code>any</code>

--------------------


### setNavigationBarStyle(...)

```typescript
setNavigationBarStyle(options: StyleOptions) => any
```

| Param         | Type                                                  |
| ------------- | ----------------------------------------------------- |
| **`options`** | <code><a href="#styleoptions">StyleOptions</a></code> |

**Returns:** <code>any</code>

--------------------


### isNavigationBarVisible()

```typescript
isNavigationBarVisible() => any
```

**Returns:** <code>any</code>

--------------------


### showKeyboard()

```typescript
showKeyboard() => any
```

**Returns:** <code>any</code>

--------------------


### hideKeyboard()

```typescript
hideKeyboard() => any
```

**Returns:** <code>any</code>

--------------------


### isKeyboardVisible()

```typescript
isKeyboardVisible() => any
```

**Returns:** <code>any</code>

--------------------


### getKeyboardInsets()

```typescript
getKeyboardInsets() => any
```

**Returns:** <code>any</code>

--------------------


### toggleAccessoryBar(...)

```typescript
toggleAccessoryBar(options: ToggleOptions) => any
```

| Param         | Type                                                    |
| ------------- | ------------------------------------------------------- |
| **`options`** | <code><a href="#toggleoptions">ToggleOptions</a></code> |

**Returns:** <code>any</code>

--------------------


### toggleScroll(...)

```typescript
toggleScroll(options: ToggleOptions) => any
```

| Param         | Type                                                    |
| ------------- | ------------------------------------------------------- |
| **`options`** | <code><a href="#toggleoptions">ToggleOptions</a></code> |

**Returns:** <code>any</code>

--------------------


### addListener(...)

```typescript
addListener(eventName: 'insets', listener: (event: InsetsEvent) => void) => any
```

| Param           | Type                                                                    |
| --------------- | ----------------------------------------------------------------------- |
| **`eventName`** | <code>"insets"</code>                                                   |
| **`listener`**  | <code>(event: <a href="#insetsevent">InsetsEvent</a>) =&gt; void</code> |

**Returns:** <code>any</code>

--------------------


### addListener(...)

```typescript
addListener(eventName: 'keyboardshow', listener: (insets: Insets) => void) => any
```

| Param           | Type                                                           |
| --------------- | -------------------------------------------------------------- |
| **`eventName`** | <code>"keyboardshow"</code>                                    |
| **`listener`**  | <code>(insets: <a href="#insets">Insets</a>) =&gt; void</code> |

**Returns:** <code>any</code>

--------------------


### addListener(...)

```typescript
addListener(eventName: 'keyboardhide', listener: () => void) => any
```

| Param           | Type                        |
| --------------- | --------------------------- |
| **`eventName`** | <code>"keyboardhide"</code> |
| **`listener`**  | <code>() =&gt; void</code>  |

**Returns:** <code>any</code>

--------------------


### Interfaces


#### Insets

| Prop         | Type                |
| ------------ | ------------------- |
| **`top`**    | <code>number</code> |
| **`right`**  | <code>number</code> |
| **`bottom`** | <code>number</code> |
| **`left`**   | <code>number</code> |


#### ColorOptions

| Prop        | Type                |
| ----------- | ------------------- |
| **`color`** | <code>string</code> |


#### StyleOptions

| Prop        | Type                                    |
| ----------- | --------------------------------------- |
| **`style`** | <code><a href="#style">Style</a></code> |


#### ToggleOptions

| Prop          | Type                 |
| ------------- | -------------------- |
| **`enabled`** | <code>boolean</code> |


#### InsetsEvent

| Prop         | Type                                              |
| ------------ | ------------------------------------------------- |
| **`type`**   | <code><a href="#insetstype">InsetsType</a></code> |
| **`insets`** | <code><a href="#insets">Insets</a></code>         |


### Enums


#### Style

| Members     | Value                |
| ----------- | -------------------- |
| **`Dark`**  | <code>'dark'</code>  |
| **`Light`** | <code>'light'</code> |


#### InsetsType

| Members        | Value                    |
| -------------- | ------------------------ |
| **`SafeArea`** | <code>"safe-area"</code> |
| **`Keyboard`** | <code>"keyboard"</code>  |

</docgen-api>
