package com.elasthink.cap.fullscreen;

import android.graphics.Color;
import android.graphics.Rect;
import android.os.Build;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
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

        window.setStatusBarColor(Color.TRANSPARENT);
        window.setNavigationBarColor(Color.TRANSPARENT);
    }

    @Override
    protected void handleOnStart() {
        super.handleOnStart();

//        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.P) {
//            Logger.info(TAG, String.format("Requires at least %d+.", Build.VERSION_CODES.P));
//            return;
//        }

        // Density
        final float density = bridge.getActivity().getResources().getDisplayMetrics().density;

        // OnApplyWindowInsets
        ViewCompat.setOnApplyWindowInsetsListener(bridge.getWebView(), (view, windowInsets) -> {
            Logger.debug(TAG, "onApplyWindowInsetsListener()");

            ArrayList<Insets> insetsList = new ArrayList();
            if (!isStatusBarHidden) {
                // NO FUNCIONA: windowInsets.isVisible(WindowInsetsCompat.Type.statusBars())
                insetsList.add(windowInsets.getInsets(WindowInsetsCompat.Type.statusBars()));
            }
            if (!isNavigationBarHidden) {
                // NO FUNCIONA: windowInsets.isVisible(WindowInsetsCompat.Type.navigationBars())
                insetsList.add(windowInsets.getInsets(WindowInsetsCompat.Type.navigationBars()));
            }
            insetsList.add(windowInsets.getInsets(WindowInsetsCompat.Type.displayCutout()));

            Rect insets = new Rect(0, 0, 0, 0);
            for (Insets ins : insetsList) {
                insets.left     = Math.max(insets.left,     ins.left);
                insets.top      = Math.max(insets.top,      ins.top);
                insets.right    = Math.max(insets.right,    ins.right);
                insets.bottom   = Math.max(insets.bottom,   ins.bottom);
            }
            insets.left     = Math.round(insets.left    / density);
            insets.top      = Math.round(insets.top     / density);
            insets.right    = Math.round(insets.right   / density);
            insets.bottom   = Math.round(insets.bottom  / density);
            if (!insets.equals(this.insets)) {
                Logger.debug(TAG, String.format("Insets: (%d, %d, %d, %d)",
                        insets.left, insets.top, insets.right, insets.bottom));
                this.insets = insets;
                updateInsets();
            }
            return WindowInsetsCompat.CONSUMED;
        });

        // onPageLoaded
        bridge.addWebViewListener(new WebViewListener() {
            @Override
            public void onPageLoaded(WebView webView) {
                Logger.debug(TAG, "onPageLoaded()");
                super.onPageLoaded(webView);
                if (FullScreenPlugin.this.insets != null) {
                    updateInsets();
                }
            }
        });

    }

    private void updateInsets() {
        JSObject event = new JSObject();
        JSObject detail = new JSObject();
        detail.put("left", this.insets.left);
        detail.put("top", this.insets.top);
        detail.put("right", this.insets.right);
        detail.put("bottom", this.insets.bottom);
        event.put("detail", detail);
        bridge.triggerJSEvent("insetschange", "document", event.toString());
    }

    @PluginMethod
    public void toggleStatusBar(PluginCall call) {
        boolean show = call.getBoolean("show");
        Logger.debug(TAG, "toggleStatusBar(" + show + ")");
        bridge.executeOnMainThread(() -> {
            WindowInsetsControllerCompat controller = getController();
            if (show) {
                controller.show(WindowInsetsCompat.Type.statusBars());
            } else {
                controller.hide(WindowInsetsCompat.Type.statusBars());
            }
            call.resolve();
        });
        isStatusBarHidden = !show;
    }

    @PluginMethod
    public void setStatusBarColor(PluginCall call) {
        final String color = call.getString("color");
        if (color == null) {
            call.reject("Color must be provided.");
            return;
        }
        bridge.executeOnMainThread(() -> {
            try {
                final int c = WebColor.parseColor(color.toUpperCase());
                bridge.getActivity().getWindow().setStatusBarColor(c);
                call.resolve();
            } catch (IllegalArgumentException ex) {
                call.reject("Invalid color provided. Must be a hex string (ex: #ff0000");
            }
        });
    }

    @PluginMethod
    public void setStatusBarStyle(PluginCall call) {
        final String style = call.getString("style"); // dark/light
        if (style == null) {
            call.reject("Style must be provided");
            return;
        }
        bridge.executeOnMainThread(() -> {
            try {
                this.getController().setAppearanceLightStatusBars("light".equals(style));
                call.resolve();
            } catch (IllegalArgumentException ex) {
                call.reject("Invalid color provided. Must be a hex string (ex: #ff0000");
            }
        });
    }

    @PluginMethod
    public void toggleNavigationBar(PluginCall call) {
        boolean show = call.getBoolean("show");
        Logger.debug(TAG, "toggleNavigationBar(" + show + ")");
        bridge.executeOnMainThread(() -> {
            WindowInsetsControllerCompat controller = this.getController();
            if (show) {
                controller.show(WindowInsetsCompat.Type.navigationBars());
            } else {
                controller.hide(WindowInsetsCompat.Type.navigationBars());
            }
            call.resolve();
        });
        isNavigationBarHidden = !show;
    }

    @PluginMethod
    public void setNavigationBarColor(PluginCall call) {
        final String color = call.getString("color");
        if (color == null) {
            call.reject("Color must be provided.");
            return;
        }
        bridge.executeOnMainThread(() -> {
            try {
                final int c = WebColor.parseColor(color.toUpperCase());
                bridge.getActivity().getWindow().setNavigationBarColor(c);
                call.resolve();
            } catch (IllegalArgumentException ex) {
                call.reject("Invalid color provided. Must be a hex string (ex: #ff0000");
            }
        });
    }

    @PluginMethod
    public void setNavigationBarStyle(PluginCall call) {
        final String style = call.getString("style");
        if (style == null) {
            call.reject("Style must be provided");
            return;
        }
        bridge.executeOnMainThread(() -> {
            try {
                this.getController().setAppearanceLightNavigationBars("light".equals(style));
                call.resolve();
            } catch (IllegalArgumentException ex) {
                call.reject("Invalid color provided. Must be a hex string (ex: #ff0000");
            }
        });
    }

    private WindowInsetsControllerCompat getController() {
        Window window = bridge.getActivity().getWindow();
        return new WindowInsetsControllerCompat(window, window.getDecorView());
    }

}
