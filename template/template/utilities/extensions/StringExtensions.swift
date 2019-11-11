import Foundation

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

}
