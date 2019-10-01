import Foundation
import UIKit

enum TextAppearances {
    case Body, Subhead, Title, Large

    func getFont() -> UIFont {
        switch self {
        case .Body:
            return UIFont.systemFont(ofSize: TextSizes.body.cgFloat)
        case .Subhead:
            return UIFont.systemFont(ofSize: TextSizes.subhead.cgFloat)
        case .Title:
            return UIFont.boldSystemFont(ofSize: TextSizes.title.cgFloat)
        case .Large:
            return UIFont.boldSystemFont(ofSize: TextSizes.large.cgFloat)
        }
    }
}

extension UILabel {
    func setTextAppearance(_ appearance: TextAppearances) {
        self.font = appearance.getFont()
    }

    convenience init(textAppearance: TextAppearances) {
        self.init()
        self.setTextAppearance(textAppearance)
    }
}

extension UITableViewCell {
    func setTextAppearance(_ appearance: TextAppearances) {
        self.textLabel?.setTextAppearance(appearance)
    }
}
