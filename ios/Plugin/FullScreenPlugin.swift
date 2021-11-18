import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(FullScreenPlugin)
public class FullScreenPlugin: CAPPlugin, UIScrollViewDelegate {
    
    static var homeIndicatorHidden = false
    
    private var safeAreaInsets: UIEdgeInsets = UIEdgeInsets.zero
    
    private var keyboardInsets: UIEdgeInsets = UIEdgeInsets.zero
    
    private var keyboardVisible = false
    
       
    override public func load() {
        CAPLog.print("Loading FullScreenPlugin...")
        super.load()
        initKeyboard();
        
    }
    
    func viewSafeAreaInsetsDidChange() {
        if let insets = bridge?.webView?.safeAreaInsets {
            safeAreaInsets = insets
            notifyInsets("safe-area", insets: insets);
        }
    }
    
    @objc private func initKeyboard() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardDidHide(notification:)),
            name: UIResponder.keyboardDidHideNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardDidChangeFrame(notification:)),
            name: UIResponder.keyboardDidChangeFrameNotification,
            object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        print("keyboardWillShow");
        keyboardVisible = true
        if let bounds = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            // NOTE: Assuming that the keyboard is always glued to the bottom.
            keyboardInsets.bottom = bounds.height
            notifyListeners("keyboardshow", data: sendInsets(keyboardInsets));
            notifyInsets("keyboard", insets: keyboardInsets)
        }
    }
    	
    @objc private func keyboardDidHide(notification: Notification) {
        print("keyboardDidHide");
        keyboardVisible = false
        keyboardInsets.bottom = 0
        notifyListeners("keyboardhide", data: sendInsets(keyboardInsets));
        notifyInsets("keyboard", insets: keyboardInsets)
    }
    
    @objc private func keyboardDidChangeFrame(notification: Notification) {
        print("keyboardDidChangeFrame");
        if let bounds = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            // NOTE: Assuming that the keyboard is always glued to the bottom.
            keyboardInsets.bottom = bounds.height
            notifyInsets("keyboard", insets: keyboardInsets)
        }
    }
    
    private func notifyInsets(_ type: String, insets: UIEdgeInsets) {
        notifyListeners("insets", data: [
            "type": type,
            "insets": sendInsets(insets)
        ])
    }
    
    private func sendInsets(_ insets: UIEdgeInsets) -> [String: Any] {
        return [
            "top": Int(round(insets.top)),
            "right": Int(round(insets.right)),
            "bottom": Int(round(insets.bottom)),
            "left": Int(round(insets.left))
        ]
    }
    
    /* SAFE-AREA
     * ============================================================================================================== */

    @objc func getSafeAreaInsets(_ call: CAPPluginCall) {
        call.resolve(sendInsets(safeAreaInsets));
    }
    
    
    /* STATUS-BAR
     * ============================================================================================================== */
    
    @objc func showStatusBar(_ call: CAPPluginCall) {
        bridge?.statusBarVisible = true;
        call.resolve();
    }
    
    @objc func hideStatusBar(_ call: CAPPluginCall) {
        bridge?.statusBarVisible = false;
        call.resolve();
    }
    
    @objc func setStatusBarColor(_ call: CAPPluginCall) {
        call.unimplemented("Not implemented on iOS")
    }
    
    @objc func setStatusBarStyle(_ call: CAPPluginCall) {
        let style = call.getString("style")
        if #available(iOS 13.0, *), style == "light" {
            bridge?.statusBarStyle = .darkContent
        } else if style == "dark" {
            bridge?.statusBarStyle = .lightContent
        } else {
            bridge?.statusBarStyle = .default
        }
    }
    
    @objc func isStatusBarVisible(_ call: CAPPluginCall) {
        if let visible = bridge?.statusBarVisible {
            call.resolve([
                "visible": visible
            ]);
        } else {
            call.reject("Unable to check visibility of the status bar.")
        }
    }
    
    
    /* NAVIGATION-BAR (Home Indicator on on iOS)
     * ============================================================================================================== */
    // More info:
    // https://medium.com/@nathangitter/reverse-engineering-the-iphone-x-home-indicator-color-a4c112f84d34
    // https://programmingwithswift.com/hide-home-indicator-with-swift/
    
    @objc func showNavigationBar(_ call: CAPPluginCall) {
        FullScreenPlugin.homeIndicatorHidden = false
        DispatchQueue.main.async {
            self.bridge?.viewController!.setNeedsUpdateOfHomeIndicatorAutoHidden()
        }
        call.resolve()
    }
    
    @objc func hideNavigationBar(_ call: CAPPluginCall) {
        FullScreenPlugin.homeIndicatorHidden = true
        DispatchQueue.main.async {
            self.bridge?.viewController!.setNeedsUpdateOfHomeIndicatorAutoHidden()
        }
        call.resolve()
    }
    
    @objc func setNavigationBarColor(_ call: CAPPluginCall) {
        call.unimplemented("Not yet implemented!")
    }
    
    @objc func setNavigationBarStyle(_ call: CAPPluginCall) {
        call.unimplemented("Not yet implemented!")
    }
    
    @objc func isNavigationBarVisible(_ call: CAPPluginCall) {
        call.unimplemented("Not yet implemented!")
    }
    
    
    /* KEYBOARD
     * ============================================================================================================== */
    
    @objc func showKeyboard(_ call: CAPPluginCall) {
        call.unavailable("Not implemented on iOS.")
    }
    
    @objc func hideKeyboard(_ call: CAPPluginCall) {
        call.unavailable("Not implemented on iOS.")
    }
    
    @objc func isKeyboardVisible(_ call: CAPPluginCall) {
        call.resolve([
            "visible": keyboardVisible
        ])
    }
    
    @objc func getKeyboardInsets(_ call: CAPPluginCall) {
        call.resolve(sendInsets(keyboardInsets));
    }
    
    @objc func toggleAccessoryBar(_ call: CAPPluginCall) {
        let enabled: Bool? = call.getBool("enabled")
        if enabled == nil {
            call.reject("Parameter \"enabled\" is required.");
        }
        bridge?.webView?.disableInputAccessoryView(!enabled!)
        call.resolve();
    }
    
    @objc func toggleScroll(_ call: CAPPluginCall) {
        let enabled: Bool? = call.getBool("enabled")
        if enabled == nil {
            call.reject("Parameter \"enabled\" is required.");
        }
        DispatchQueue.main.async {
            if let view: UIScrollView = self.bridge?.webView?.scrollView {
                if enabled! {
                    view.isScrollEnabled = true
                    view.delegate = nil
                } else {
                    view.isScrollEnabled = false
                    view.delegate = self
                }
            }
        }
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset = CGPoint.zero
    }

}

extension CAPBridgeViewController {
    
    override public func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        // TODO: Revisar la localización del plugin, ¿podemos fiarnos de que el nombre siempre va a ser "FullScreen"?
        if let plugin = bridge?.plugin(withName: "FullScreen") as? FullScreenPlugin {
            plugin.viewSafeAreaInsetsDidChange()
        }
    }

    override public var prefersHomeIndicatorAutoHidden:Bool {
        return FullScreenPlugin.homeIndicatorHidden
    }
    
}

extension WKWebView {
    
    struct inputAccessoryViewState {
        static var disabled: Bool? = false
    }
    
    @objc var inputAccessoryViewAlt: UIView? {
        return nil
    }
    
    @objc func disableInputAccessoryView(_ disabled: Bool) {
        let selfClass: AnyClass! = object_getClass(self)
        if disabled != inputAccessoryViewState.disabled,
                let currMethod = class_getInstanceMethod(selfClass, #selector(getter: inputAccessoryView)),
                let backMethod = class_getInstanceMethod(selfClass, #selector(getter: inputAccessoryViewAlt)) {
            method_exchangeImplementations(currMethod, backMethod)
            inputAccessoryViewState.disabled = disabled
        }
    }
    
}



//
//fileprivate final class InputAccessoryHackHelper: NSObject {
//    @objc var inputAccessoryView: AnyObject? { return nil }
//}
//
//extension WKWebView {
//    func hack_removeInputAccessory() {
//        guard let target = scrollView.subviews.first(where: {
//            String(describing: type(of: $0)).hasPrefix("WKContent")
//        }), let superclass = target.superclass else {
//            return
//        }
//
//        let noInputAccessoryViewClassName = "\(superclass)_NoInputAccessoryView"
//        var newClass: AnyClass? = NSClassFromString(noInputAccessoryViewClassName)
//
//        if newClass == nil, let targetClass = object_getClass(target), let classNameCString = noInputAccessoryViewClassName.cString(using: .ascii) {
//            newClass = objc_allocateClassPair(targetClass, classNameCString, 0)
//
//            if let newClass = newClass {
//                objc_registerClassPair(newClass)
//            }
//        }
//
//        guard let noInputAccessoryClass = newClass, let originalMethod = class_getInstanceMethod(InputAccessoryHackHelper.self, #selector(getter: InputAccessoryHackHelper.inputAccessoryView)) else {
//            return
//        }
//        class_addMethod(noInputAccessoryClass.self, #selector(getter: InputAccessoryHackHelper.inputAccessoryView), method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
//        object_setClass(target, noInputAccessoryClass)
//    }
//}
//
