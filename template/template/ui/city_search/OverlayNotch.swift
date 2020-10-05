import Foundation
import UIKit

enum OverlayNotch: Int, CaseIterable {
    case hidden, minimum, maximum

    func getHeight(withHeight availableHeight: CGFloat) -> CGFloat {
        switch self {
        case .hidden: return 0
        case .minimum: return availableHeight * 1 / 4
        case .maximum: return availableHeight * 3 / 4
        }
    }
}
