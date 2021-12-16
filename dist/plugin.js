var capacitorFullScreen = (function (exports, core) {
    'use strict';

    var Style;
    (function (Style) {
        Style["Dark"] = "dark";
        Style["Light"] = "light";
        Style["Default"] = "default";
    })(Style || (Style = {}));
    var InsetsType;
    (function (InsetsType) {
        InsetsType["SafeArea"] = "safe-area";
        InsetsType["Keyboard"] = "keyboard";
    })(InsetsType || (InsetsType = {}));

    const FullScreen = core.registerPlugin('FullScreen');
    // Init:
    FullScreen.getSafeAreaInsets().then(insets => {
        updateSafeAreaInsets(insets);
    });
    FullScreen.getKeyboardInsets().then(insets => {
        updateKeyboardInsets(insets);
    });
    // Event: "insetschange"
    FullScreen.addListener('insets', event => {
        console.log(`[insets] ${event.type}: ${JSON.stringify(event.insets)}`);
        if (InsetsType.SafeArea === event.type) {
            updateSafeAreaInsets(event.insets);
        }
        else if (InsetsType.Keyboard === event.type) {
            updateKeyboardInsets(event.insets);
        }
    });
    function updateSafeAreaInsets(insets) {
        const prefix = 'safe';
        const style = document.documentElement.style;
        style.setProperty(`--${prefix}-ins-top`, `${insets.top}px`);
        style.setProperty(`--${prefix}-ins-right`, `${insets.right}px`);
        style.setProperty(`--${prefix}-ins-bottom`, `${insets.bottom}px`);
        style.setProperty(`--${prefix}-ins-left`, `${insets.left}px`);
    }
    function updateKeyboardInsets(insets) {
        const prefix = 'keyb';
        const style = document.documentElement.style;
        style.setProperty(`--${prefix}-ins-bottom`, `${insets.bottom}px`);
    }

    exports.FullScreen = FullScreen;

    Object.defineProperty(exports, '__esModule', { value: true });

    return exports;

})({}, capacitorExports);
//# sourceMappingURL=plugin.js.map
