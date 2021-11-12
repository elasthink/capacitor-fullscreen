package com.elasthink.cap.fullscreen;

import android.app.Activity;
import android.content.Context;
import android.graphics.Color;
import android.graphics.Rect;
import android.os.Build;
import android.os.IBinder;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.view.inputmethod.InputMethodManager;
import android.webkit.WebView;

import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowCompat;
import androidx.core.view.WindowInsetsCompat;
import androidx.core.view.WindowInsetsControllerCompat;

import com.getcapacitor.JSObject;
import com.getcapacitor.Logger;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.WebViewListener;
import com.getcapacitor.annotation.CapacitorPlugin;
import com.getcapacitor.util.WebColor;

import java.util.ArrayList;

@CapacitorPlugin(name = "FullScreen")
public class FullScreenPlugin extends Plugin {

    private static final String TAG = "FullScreen";

    private Rect insets = null;

    private boolean isStatusBarHidden = false;

    private boolean isNavigationBarHidden = false;

    @Override
    public void load() {
        Logger.debug(TAG, "load()");

        Window window = bridge.getActivity().getWindow();
        WindowCompat.setDecorFitsSystemWindows(window, false);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            WindowManager.LayoutParams params = window.getAttributes();
            params.layoutInDisplayCutoutMode = WindowManager.LayoutParams.LAYOUT_IN_DISPLAY_CUTOUT_MODE_SHORT_EDGES;
        }

        View decorView = window.getDecorView();
        WindowInsetsControllerCompat controller = new WindowInsetsControllerCompat(window, decorView);
        controller.setSystemBarsBehavior(WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE);

        ViewCompat.setOnApplyWindowInsetsListener(decorView, (view, windowInsets) -> {
            Logger.debug(TAG, "onApplyWindowInsetsListener()");
            fireInsetsChangeEvent("safe-area", getSafeAreaInsets(windowInsets));
            return WindowInsetsCompat.CONSUMED;
        });

        // TODO: Tomar colores por defecto por la configuración del plugin así como el estilo?
        window.setStatusBarColor(Color.TRANSPARENT);
        window.setNavigationBarColor(Color.TRANSPARENT);
    }

    @PluginMethod
    public void toggle(PluginCall call) {
        final String type = call.getString("type");
        if (type == null) {
            call.reject("Parameter \"type\" is required.");
            return;
        }
        final Boolean show = call.getBoolean("show");
        if (show == null) {
            call.reject("Parameter \"show\" is required.");
            return;
        }
        bridge.executeOnMainThread(() -> {
            final WindowInsetsControllerCompat controller = getController();
            if ("status-bar".equals(type)) {
                if (show) {
                    controller.show(WindowInsetsCompat.Type.statusBars());
                } else {
                    controller.hide(WindowInsetsCompat.Type.statusBars());
                }
                isStatusBarHidden = !show;
            } else if ("navigation-bar".equals(type)) {
                if (show) {
                    controller.show(WindowInsetsCompat.Type.navigationBars());
                } else {
                    controller.hide(WindowInsetsCompat.Type.navigationBars());
                }
                isNavigationBarHidden = !show;

            } else if ("keyboard".equals(type)) {
                final Activity activity = getActivity();
                final View decorView = activity.getWindow().getDecorView();
                final InputMethodManager imm = (InputMethodManager) activity.getSystemService(Context.INPUT_METHOD_SERVICE);
                if (show) {
                    imm.showSoftInput(decorView, InputMethodManager.SHOW_IMPLICIT); // SHOW_FORCED?
                } else {
                    imm.hideSoftInputFromWindow(decorView.getWindowToken(), InputMethodManager.HIDE_IMPLICIT_ONLY);
                }
            } else if ("accessory-bar".equals(type)) {
                call.unimplemented("Not implemented on Android.");
                return;
            }
            call.resolve();
        });
    }

    @PluginMethod
    public void getInsets(PluginCall call) {
        final String type = call.getString("type");
        if (type == null) {
            call.reject("Parameter \"type\" is required.");
            return;
        }
        final WindowInsetsCompat windowInsets = getWindowInsets();
        Insets insets = null;
        if ("safe-area".equals(type)) {
            insets = getSafeAreaInsets(windowInsets);
        } else if ("status-bar".equals(type)) {
            insets = windowInsets.getInsets(WindowInsetsCompat.Type.statusBars());
        } else if ("navigation-bar".equals(type)) {
            insets = windowInsets.getInsets(WindowInsetsCompat.Type.navigationBars());
        } else if ("keyboard".equals(type)) {
            insets = windowInsets.getInsets(WindowInsetsCompat.Type.ime());
        } else if ("accessory-bar".equals(type)) {
            call.unimplemented("Not implemented on Android.");
            return;
        }
        call.resolve(insetsToJSObject(insets));
    }

    private Insets getSafeAreaInsets(WindowInsetsCompat windowInsets) {
        Insets insets = windowInsets.getInsets(WindowInsetsCompat.Type.displayCutout());
        if (!isStatusBarHidden) {
            // NO FUNCIONA: windowInsets.isVisible(WindowInsetsCompat.Type.statusBars())
            insets = Insets.add(insets, windowInsets.getInsets(WindowInsetsCompat.Type.statusBars()));
        }
        if (!isNavigationBarHidden) {
            // NO FUNCIONA: windowInsets.isVisible(WindowInsetsCompat.Type.navigationBars())
            insets = Insets.add(insets, windowInsets.getInsets(WindowInsetsCompat.Type.navigationBars()));
        }
        return insets;
    }

    @PluginMethod
    public void isVisible(PluginCall call) {
        final String type = call.getString("type");
        if (type == null) {
            call.reject("Parameter \"type\" is required.");
            return;
        }
        final JSObject data = new JSObject();
        if ("status-bar".equals(type)) {
            data.put("visible", !isStatusBarHidden);
        } else if ("navigation-bar".equals(type)) {
            data.put("visible", !isNavigationBarHidden);
        } else if ("keyboard".equals(type)) {
            call.unimplemented("Not yet implemented!");
            return;
        } else {
            call.unimplemented("Not supported.");
            return;
        }
        call.resolve(data);
    }

    @PluginMethod
    public void setColor(PluginCall call) {
        final String type = call.getString("type");
        if (type == null) {
            call.reject("Parameter \"type\" is required.");
            return;
        }
        final String color = call.getString("color");
        if (color == null) {
            call.reject("Parameter \"color\" is required.");
            return;
        }
        bridge.executeOnMainThread(() -> {
            try {
                final Window window = bridge.getActivity().getWindow();
                final int c = WebColor.parseColor(color.toUpperCase());
                if ("status-bar".equals(type)) {
                    window.setStatusBarColor(c);
                } else if ("navigation-bar".equals(type)) {
                    window.setNavigationBarColor(c);
                } else {
                    call.unimplemented("Not supported.");
                    return;
                }
                call.resolve();
            } catch (IllegalArgumentException ex) {
                call.reject("Invalid color format");
            }
        });
    }

    @PluginMethod
    public void setStyle(PluginCall call) {
        final String type = call.getString("type");
        if (type == null) {
            call.reject("Parameter \"type\" is required.");
            return;
        }
        final String style = call.getString("style");
        if (style == null) {
            call.reject("Parameter \"style\" is required.");
            return;
        }
        bridge.executeOnMainThread(() -> {
            final WindowInsetsControllerCompat controller = getController();
            if ("status-bar".equals(type)) {
                controller.setAppearanceLightStatusBars("light".equals(style));
            } else if ("navigation-bar".equals(type)) {
                controller.setAppearanceLightNavigationBars("light".equals(style));
            } else {
                call.unimplemented("Not supported.");
                return;
            }
            call.resolve();
        });
    }

    @PluginMethod
    public void toggleScroll(PluginCall call) {
        call.unimplemented("Not yet implemented.");
    }

    private void fireInsetsChangeEvent(String type, Insets insets) {
        JSObject eventObj = new JSObject();
        JSObject detailObj = new JSObject();
        detailObj.put("type", type);
        detailObj.put("insets", insetsToJSObject(insets));
        eventObj.put("detail", detailObj);
        bridge.triggerJSEvent("insetschange", "window", eventObj.toString());
    }

    private JSObject insetsToJSObject(Insets insets) {
        final float density = getDensity();
        final JSObject obj = new JSObject();
        obj.put("left", Math.round(insets.left / density));
        obj.put("top", Math.round(insets.top / density));
        obj.put("right", Math.round(insets.right / density));
        obj.put("bottom", Math.round(insets.bottom / density));
        return obj;
    }

    private float getDensity() {
        return bridge.getActivity().getResources().getDisplayMetrics().density;
    }

    private WindowInsetsCompat getWindowInsets() {
        Activity activity = bridge.getActivity();
        View decorView = activity.getWindow().getDecorView();
        return WindowInsetsCompat.toWindowInsetsCompat(decorView.getRootWindowInsets());
    }

    private WindowInsetsControllerCompat getController() {
        Window window = bridge.getActivity().getWindow();
        return new WindowInsetsControllerCompat(window, window.getDecorView());
    }

}
