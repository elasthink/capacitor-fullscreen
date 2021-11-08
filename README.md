# capacitor-fullscreen

Capacitor plugin to control full screen mode on Android and iOS devices.

## Install

```bash
npm install capacitor-fullscreen
npx cap sync
```

## API

<docgen-index>

* [`toggleStatusBar(...)`](#togglestatusbar)
* [`setStatusBarColor(...)`](#setstatusbarcolor)
* [`setStatusBarStyle(...)`](#setstatusbarstyle)
* [`toggleNavigationBar(...)`](#togglenavigationbar)
* [`setNavigationBarColor(...)`](#setnavigationbarcolor)
* [`setNavigationBarStyle(...)`](#setnavigationbarstyle)
* [Interfaces](#interfaces)
* [Enums](#enums)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### toggleStatusBar(...)

```typescript
toggleStatusBar(options: ToggleOptions) => any
```

| Param         | Type                                                    |
| ------------- | ------------------------------------------------------- |
| **`options`** | <code><a href="#toggleoptions">ToggleOptions</a></code> |

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


### toggleNavigationBar(...)

```typescript
toggleNavigationBar(options: ToggleOptions) => any
```

| Param         | Type                                                    |
| ------------- | ------------------------------------------------------- |
| **`options`** | <code><a href="#toggleoptions">ToggleOptions</a></code> |

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


### Interfaces


#### ToggleOptions

| Prop       | Type                 |
| ---------- | -------------------- |
| **`show`** | <code>boolean</code> |


#### ColorOptions

| Prop        | Type                |
| ----------- | ------------------- |
| **`color`** | <code>string</code> |


#### StyleOptions

| Prop        | Type                                    |
| ----------- | --------------------------------------- |
| **`style`** | <code><a href="#style">Style</a></code> |


### Enums


#### Style

| Members       | Value                  |
| ------------- | ---------------------- |
| **`Dark`**    | <code>'DARK'</code>    |
| **`Light`**   | <code>'LIGHT'</code>   |
| **`Default`** | <code>'DEFAULT'</code> |

</docgen-api>
