import Foundation
import UIKit

enum Theme {
    case Tokyo, Illini, SeaFoam

    var isLight: Bool {
        switch self {
        case .Tokyo:
            return true
        case .Illini:
            return false
        case .SeaFoam:
            return true
        }
    }
    
    var primaryColor: UIColor {
        switch self {
        case .Tokyo:
            return PresetColors.white
        case .Illini:
            return PresetColors.darkGunmetal
        case .SeaFoam:
            return PresetColors.onyx
        }
    }

    var primaryDarkColor: UIColor {
        switch self {
        case .Tokyo:
            return PresetColors.whiteSmoke
        case .Illini:
            return PresetColors.eerieBlack
        case .SeaFoam:
            return PresetColors.raisinBlack
        }
    }

    var accentColor: UIColor {
        switch self {
        case .Tokyo:
            return PresetColors.sanguineRed
        case .Illini:
            return PresetColors.carrotOrange
        case .SeaFoam:
            return PresetColors.seaFoam
        }
    }

    var normalColor: UIColor {
        switch self {
        case .Tokyo:
            return PresetColors.onyx_87
        case .Illini:
            return PresetColors.white
        case .SeaFoam:
            return PresetColors.white
        }
    }

    var backgroundColor: UIColor {
        switch self {
        case .Tokyo:
            return PresetColors.lightGray
        case .Illini:
            return PresetColors.gunmetal
        case .SeaFoam:
            return PresetColors.lightGray
        }
    }

    var foregroundColor: UIColor {
        switch self {
        case .Tokyo:
            return PresetColors.agateBlue
        case .Illini:
            return PresetColors.putty
        case .SeaFoam:
            return PresetColors.onyx
        }
    }

    var dividerColor: UIColor {
        switch self {
        case .Tokyo:
            return PresetColors.gray_38
        case .Illini:
            return PresetColors.eggshell_38
        case .SeaFoam:
            return PresetColors.lightGray_54
        }
    }

    var textLinkColor: UIColor {
        switch self {
        case .Tokyo:
            return PresetColors.agateBlue
        case .Illini:
            return PresetColors.winterBlue
        case .SeaFoam:
            return PresetColors.lakeBlue
        }
    }

    var textLinkInverseColor: UIColor {
        switch self {
        case .Tokyo:
            return PresetColors.winterBlue
        case .Illini:
            return PresetColors.lakeBlue
        case .SeaFoam:
            return PresetColors.lightGray
        }
    }

    var inputErrorColor: UIColor {
        switch self {
        case .Tokyo:
            return PresetColors.red
        case .Illini:
            return PresetColors.medium_violet_red
        case .SeaFoam:
            return PresetColors.salmon
        }
    }

    var inputActiveHintColor: UIColor {
        switch self {
        case .Tokyo:
            return Theme.Tokyo.accentColor
        case .Illini:
            return Theme.Illini.accentColor
        case .SeaFoam:
            return Theme.SeaFoam.accentColor
        }
    }

    var inputInactiveHintColor: UIColor {
        switch self {
        case .Tokyo:
            return Theme.Tokyo.foregroundColor
        case .Illini:
            return Theme.Illini.foregroundColor
        case .SeaFoam:
            return Theme.SeaFoam.foregroundColor
        }
    }
}

