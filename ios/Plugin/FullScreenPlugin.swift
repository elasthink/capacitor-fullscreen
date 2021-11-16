import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(FullScreenPlugin)
public class FullScreenPlugin: CAPPlugin, UIScrollViewDelegate {
    
    private var safeAreaInsets: UIEdgeInsets = UIEdgeInsets.zero
    
    private var keyboardHeight: CGFloat = 0
    
    private var keyboardVisible = false
    
    private var accessoryBarDisabled = false
       
    override public func load() {
        CAPLog.print("Loading FullScreenPlugin...")
        super.load()
        initKeyboard();
    }
    
    func viewSafeAreaInsetsDidChange() {
        if let ins = bridge?.webView?.safeAreaInsets {
            safeAreaInsets = ins
            notifySafeAreaInsetsChange(insets: ins);
        }
    }
    
    private func notifySafeAreaInsetsChange(insets: UIEdgeInsets) {
        notifyListeners("insets", data: [
            "type": "safe-area",
            "insets": [
                "top": Int(round(insets.top)),
                "right": Int(round(insets.right)),
                "bottom": Int(round(insets.bottom)),
                "left": Int(round(insets.left))
            ]
        ]);
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
            keyboardHeight = bounds.height
            notifyKeyboardInsetsChange(height: keyboardHeight)
        }
        if accessoryBarDisabled {
            bridge?.webView?.inputAccessoryView?.removeFromSuperview()
        }
    }
    
    @objc private func keyboardDidHide(notification: Notification) {
        print("keyboardDidHide");
        keyboardVisible = false
        keyboardHeight = 0
        notifyKeyboardInsetsChange(height: keyboardHeight)
    }
    
    @objc private func keyboardDidChangeFrame(notification: Notification) {
        print("keyboardDidChangeFrame");
        if let bounds = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            // NOTE: Assuming that the keyboard is always glued to the bottom.
            keyboardHeight = bounds.height
            notifyKeyboardInsetsChange(height: keyboardHeight)
        }
    }
    
    private func notifyKeyboardInsetsChange(height: CGFloat) {
        notifyListeners("insets", data: [
            "type": "keyboard",
            "insets": [
                "bottom": Int(round(height))
            ]
        ]);
    }

    
    /* SAFE-AREA
     * ============================================================================================================== */

    @objc func getSafeAreaInsets(_ call: CAPPluginCall) {
        call.resolve([
            "top": Int(round(safeAreaInsets.top)),
            "right": Int(round(safeAreaInsets.right)),
            "bottom": Int(round(safeAreaInsets.bottom)),
            "left": Int(round(safeAreaInsets.left))
        ]);
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
        call.unimplemented("Not yet implemented!")
    }
    
    @objc func setStatusBarStyle(_ call: CAPPluginCall) {
        call.unimplemented("Not yet implemented!")
    }
    
    @objc func isStatusBarVisible(_ call: CAPPluginCall) {
        if let visible = bridge?.statusBarVisible {
            call.resolve([
                "visible": visible
            ]);
        } else {
            call.reject("Unable to check if the status bar is visible or not.")
        }
    }
    
    
    /* NAVIGATION-BAR
     * ============================================================================================================== */
    
    @objc func showNavigationBar(_ call: CAPPluginCall) {
        if let controller = bridge?.viewController?.navigationController {
            controller.setNavigationBarHidden(true, animated: true)
            call.resolve()
        } else {
            call.reject("Unable to show navigation bar")
        }
    }
    
    @objc func hideNavigationBar(_ call: CAPPluginCall) {
        if let controller = bridge?.viewController?.navigationController {
            controller.setNavigationBarHidden(false, animated: true)
            call.resolve()
        } else {
            call.reject("Unable to hide navigation bar")
        }
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
        call.resolve([
            "bottom": Int(round(keyboardHeight))
        ]);
    }
    
    @objc func toggleAccessoryBar(_ call: CAPPluginCall) {
        let enabled: Bool? = call.getBool("enabled")
        if enabled == nil {
            call.reject("Parameter \"enabled\" is required.");
        }
        accessoryBarDisabled = !(enabled!)
        if accessoryBarDisabled {
            DispatchQueue.main.async {
                self.bridge?.webView?.inputAccessoryView?.removeFromSuperview()
            }
        }
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
        super.viewSafeAreaInsetsDidChange();
        if let plugin = bridge?.plugin(withName: "FullScreen") as? FullScreenPlugin {
            plugin.viewSafeAreaInsetsDidChange();
        }
    }
    
}

extension UIView {
    
    var firstResponder: UIView? {
        guard !isFirstResponder else {
            return self
            
        }
        for view in subviews {
            if let firstResponder = view.firstResponder {
                return firstResponder
            }
        }
        return nil
    }
}

//extension WKWebView {
//
//    public override var inputAccessoryView: UIView? {
//        return self.inputAccessoryView
//    }
//
//}

