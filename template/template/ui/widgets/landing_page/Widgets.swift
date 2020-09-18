import Foundation

enum Widgets: CaseIterable {
    case SWITCH
    case LABEL
    case PROGRESS

    var title: String {
        get {
            switch self {
            case .SWITCH: return Strings.Switch
            case .LABEL: return Strings.Label
            case .PROGRESS: return Strings.Progress
            }
        }
    }

    var image: String {
        get {
            switch self {
            case .SWITCH: return ""
            case .LABEL: return ""
            case .PROGRESS: return ""
            }
        }
    }
}