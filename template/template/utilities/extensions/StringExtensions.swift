import Foundation
import UIKit

extension String {

    func isNotEmpty() -> Bool  {
        return !self.isEmpty
    }

    func subString(startAfterChar: Character, endBeforeChar: Character) -> String? {
        guard let startIndex = firstIndex(of: startAfterChar) else { return nil }
        guard let endIndex = firstIndex(of: endBeforeChar) else { return nil }
        let range: Range<Index> = self.index(after: startIndex)..<endIndex
        return self.substring(with: range)
    }

    func subString(startAfterChar: Character) -> String? {
        guard let startIndex = firstIndex(of: startAfterChar) else { return nil }
        let range: Range<Index> = self.index(after: startIndex)..<endIndex
        return self.substring(with: range)
    }
    
    func asUnderlined() -> NSAttributedString {
        let textRange = NSMakeRange(0, self.count)
        let attributedText = NSMutableAttributedString(string: self)
        attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange)
        return attributedText
    }
    
    func withLetterSpacing(of value: Float) -> NSAttributedString {
        NSAttributedString(string: self, attributes: [.kern: value])
    }
}
