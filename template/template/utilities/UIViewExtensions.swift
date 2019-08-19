import Foundation
import UIKit

extension UIView {
    
    func setOnTapListener(target: Any, action: Selector) {
        self.setOnTapListener(tapNumber: 1, target: target, action: action)
    }

    func setOnDoubleTapListener(target: Any, action: Selector) {
        self.setOnTapListener(tapNumber: 2, target: target, action: action)
    }
    
    func setOnTapListener(tapNumber: Int, target: Any, action: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = tapNumber
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
    
    func setOnLongTapListener(target: Any, action: Selector) {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: action)
        self.addGestureRecognizer(longPressGesture)
    }
}
