//
//  UILabelExtensions.swift
//  mobile
//
//  Created by Sami Eljabali on 8/14/19.
//  Copyright © 2019 CovertTrack. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func setUnderlined() {
        if let currentText = self.text {
            let underlineAttriString = NSAttributedString(string: currentText,
                                                          attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
            self.attributedText = underlineAttriString
            return
        }
    }
}
