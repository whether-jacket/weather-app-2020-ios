import Foundation
import UIKit

class BorderedButton: UIButton {
    private static let BORDER_WIDTH = 1.cgFloat
    private static let FADE_ANIMATION_DURATION = 0.4
    private static let FADE_ALPHA = 0.2.cgFloat

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderColor = tintColor.cgColor
        layer.borderWidth = BorderedButton.BORDER_WIDTH
        layer.cornerRadius = CornerRadius.xs.cgFloat
        contentEdgeInsets = UIEdgeInsets(top: VerticalSpacings.xs.cgFloat,
                                         left: HorizontalSpacings.m.cgFloat,
                                         bottom: VerticalSpacings.xs.cgFloat,
                                         right: HorizontalSpacings.m.cgFloat)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override func tintColorDidChange() {
        super.tintColorDidChange()
        layer.borderColor = tintColor.cgColor
    }

    override var isHighlighted: Bool {
        didSet {
            let fadedColor = tintColor.withAlphaComponent(BorderedButton.FADE_ALPHA).cgColor
            if isHighlighted {
                layer.borderColor = fadedColor
                return
            }
            layer.borderColor = tintColor.cgColor
            CABasicAnimation(keyPath: "borderColor").apply {
                $0.fromValue = fadedColor
                $0.toValue = tintColor.cgColor
                $0.duration = BorderedButton.FADE_ANIMATION_DURATION
                layer.add($0, forKey: "")
            }
        }
    }
}
