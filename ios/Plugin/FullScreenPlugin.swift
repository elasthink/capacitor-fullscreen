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
    
    static func refreshInsets(bridge: CAPBridgeProtocol) {
        let insets: UIEdgeInsets = bridge.webView!.safeAreaInsets;
        let top: Int = Int(round(insets.top));
        let left: Int = Int(round(insets.left));
        let bottom: Int = Int(round(insets.bottom));
        let right: Int = Int(round(insets.right));
        let data: String = "{ \"detail\": { \"top\": \(top), \"left\": \(left), \"bottom\": \(bottom), \"right\": \(right) } }";
        CAPLog.print("viewSafeAreaInsetsDidChange(top: \(top), left: \(left), bottom: \(bottom), right: \(right))");
        bridge.triggerJSEvent(eventName: "insetschange", target: "document", data: data);
    }
    
    override public func load() {
        CAPLog.print("Loading FullScreenPlugin...");
        super.load();
        // UIResponder.keyboardWillShowNotification
        // class ViewController: UIViewController
        FullScreenPlugin.refreshInsets(bridge: bridge!);
    }

    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        call.resolve([
            "value": implementation.echo(value)
        ])
    }
    
    
}

extension CAPBridgeViewController {
    
    override public func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange();
        FullScreenPlugin.refreshInsets(bridge: bridge!);
    }
    
}
