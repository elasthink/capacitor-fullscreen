import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(FullScreenPlugin)
public class FullScreenPlugin: CAPPlugin {
    
    private let insets:UIEdgeInsets = UIEdgeInsets.zero;
    
    private let implementation = FullScreen();
    
    static func fireInsetsChangeEvent(bridge: CAPBridgeProtocol) {
        let eventData: String = "{\"detail\":{\"type\":\"safe-area\",\"insets\":\(getSafeAreaInsets(bridge: bridge))}}";
        CAPLog.print("viewSafeAreaInsetsDidChange(\(eventData))");
        bridge.triggerJSEvent(eventName: "insetschange", target: "document", data: eventData);
    }
    
    static func getSafeAreaInsets(bridge: CAPBridgeProtocol) -> String {
        let insets: UIEdgeInsets = bridge.webView!.safeAreaInsets;
        let top: Int = Int(round(insets.top));
        let left: Int = Int(round(insets.left));
        let bottom: Int = Int(round(insets.bottom));
        let right: Int = Int(round(insets.right));
        return "{\"top\":\(top),\"left\":\(left),\"bottom\":\(bottom),\"right\": \(right)}";
    }
    
    override public func load() {
        CAPLog.print("Loading FullScreenPlugin...");
        super.load();
    }

    @objc func toggle(_ call: CAPPluginCall) {
        let type: String? = call.getString("type")
        if type == nil {
            call.reject("Parameter \"type\" is required.")
        }
        let show: Bool? = call.getBool("show");
        if show == nil {
            call.reject("Parameter \"show\" is required.")
        }
        if type == "status-bar" {
            bridge?.statusBarVisible = show!
        } else if type == "navigation-bar" {
            bridge?.viewController?.navigationController?.setNavigationBarHidden(show!, animated: true)
        } else if type == "accessory-bar" {
            if show! {
                // ...
            } else {
                // ...
            }
        } else {
            call.unavailable("Not available.")
            return;
        }
        call.resolve()
    }
    
    @objc func getInsets(_ call: CAPPluginCall) {
        let type: String? = call.getString("type")
        if type == nil {
            call.reject("Parameter \"type\" is required.")
        }
        if type == "safe-area" {
            let insets: UIEdgeInsets = bridge!.webView!.safeAreaInsets;
            call.resolve([
                "top": Int(round(insets.top)),
                "left": Int(round(insets.left)),
                "bottom": Int(round(insets.bottom)),
                "right": Int(round(insets.right))
            ]);
            return;
        } else {
            call.unavailable("Not available.")
        }
        call.resolve();
    }
    
    @objc func isVisible(_ call: CAPPluginCall) {
        call.resolve();
    }
    
    @objc func setColor(_ call: CAPPluginCall) {
        call.resolve();
    }
    
    @objc func setStyle(_ call: CAPPluginCall) {
        call.resolve();
    }
    
    @objc func toggleScroll(_ call: CAPPluginCall) {
        call.resolve();
    }
        
}

extension CAPBridgeViewController {
    
    override public func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange();
        FullScreenPlugin.fireInsetsChangeEvent(bridge: bridge!);
    }
    
}

extension WKWebView {
    
    public override var inputAccessoryView: UIView? {
        return nil; // self.inputAccessoryView;
    }
}
