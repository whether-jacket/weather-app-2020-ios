import Foundation
import SwifterSwift
import SwiftDate

extension String {

    var isMsftDate: Bool  { return self.contains("/Date(") }

    func parseMsftDate() -> DateInRegion? {
        guard let longString = self.subString(startAfterChar: "(", endBeforeChar: ")") else { return nil }
        guard let timeInMilliSeconds = longString.int else { return nil }
        return DateInRegion(milliseconds: timeInMilliSeconds, region: SwiftDate.defaultRegion)
    }

    func parseDate() -> DateInRegion? {
        if self.isMsftDate { return self.parseMsftDate() }
        return self.toDate()
    }

}
