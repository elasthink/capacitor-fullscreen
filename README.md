# capacitor-fullscreen

Capacitor plugin to control full screen mode on Android and iOS devices.

## Install

```bash
npm install capacitor-fullscreen
npx cap sync
```

## API

<docgen-index>

* [`toggle(...)`](#toggle)
* [`getInsets(...)`](#getinsets)
* [`isVisible(...)`](#isvisible)
* [`setColor(...)`](#setcolor)
* [`setStyle(...)`](#setstyle)
* [`toggleScroll(...)`](#togglescroll)
* [Interfaces](#interfaces)
* [Enums](#enums)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### toggle(...)

```typescript
toggle(options: InsetsOptions) => any
```

| Param         | Type                                                    |
| ------------- | ------------------------------------------------------- |
| **`options`** | <code><a href="#insetsoptions">InsetsOptions</a></code> |

**Returns:** <code>any</code>

--------------------


### getInsets(...)

```typescript
getInsets(options: InsetsOptions) => any
```

| Param         | Type                                                    |
| ------------- | ------------------------------------------------------- |
| **`options`** | <code><a href="#insetsoptions">InsetsOptions</a></code> |

**Returns:** <code>any</code>

--------------------


### isVisible(...)

```typescript
isVisible(options: InsetsOptions) => any
```

| Param         | Type                                                    |
| ------------- | ------------------------------------------------------- |
| **`options`** | <code><a href="#insetsoptions">InsetsOptions</a></code> |

**Returns:** <code>any</code>

--------------------


### setColor(...)

```typescript
setColor(options: ColorOptions) => any
```

| Param         | Type                                                  |
| ------------- | ----------------------------------------------------- |
| **`options`** | <code><a href="#coloroptions">ColorOptions</a></code> |

**Returns:** <code>any</code>

--------------------


### setStyle(...)

```typescript
setStyle(options: StyleOptions) => any
```

| Param         | Type                                                  |
| ------------- | ----------------------------------------------------- |
| **`options`** | <code><a href="#styleoptions">StyleOptions</a></code> |

**Returns:** <code>any</code>

--------------------


### toggleScroll(...)

```typescript
toggleScroll(options: ScrollOptions) => any
```

| Param         | Type                                                    |
| ------------- | ------------------------------------------------------- |
| **`options`** | <code><a href="#scrolloptions">ScrollOptions</a></code> |

**Returns:** <code>any</code>

--------------------


### Interfaces


#### InsetsOptions

| Prop       | Type                                  |
| ---------- | ------------------------------------- |
| **`type`** | <code><a href="#type">Type</a></code> |


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


#### ScrollOptions

| Prop           | Type                 |
| -------------- | -------------------- |
| **`disabled`** | <code>boolean</code> |


### Enums


#### Type

| Members             | Value                         |
| ------------------- | ----------------------------- |
| **`SafeArea`**      | <code>"safe-area"</code>      |
| **`StatusBar`**     | <code>"status-bar"</code>     |
| **`NavigationBar`** | <code>"navigation-bar"</code> |
| **`Keyboard`**      | <code>"keyboard"</code>       |
| **`AccessoryBar`**  | <code>"accessory-bar"</code>  |


#### Style

| Members     | Value                |
| ----------- | -------------------- |
| **`Dark`**  | <code>'dark'</code>  |
| **`Light`** | <code>'light'</code> |

</docgen-api>
