#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

// Define the plugin using the CAP_PLUGIN Macro, and
// each method the plugin supports using the CAP_PLUGIN_METHOD macro.
CAP_PLUGIN(FullScreenPlugin, "FullScreen",
           CAP_PLUGIN_METHOD(toggle, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(getInsets, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(isVisible, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(setColor, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(setStyle, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(toggleScroll, CAPPluginReturnPromise);
)
