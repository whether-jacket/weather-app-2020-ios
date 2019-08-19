import Foundation
import UIKit

struct Intents {
    
    public static func dialPhoneNumber(_ number: String) {
        let url = URL(string: "tel://\(number)")!
        if (UIApplication.shared.canOpenURL(url)) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    public static func emailTo(_ email: String) {
        if let url = URL(string: "mailto:\(email)") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    public static func openWebAddress(_ address: String) {
        guard let url = URL(string: address) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
