import Foundation
import UIKit
import CoreLocation

public extension UIDevice {
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else {
                return identifier
            }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":                return "iPhone X"
        case "iPhone11,8":                              return "iPhone XR"
        case "iPhone11,2":                              return "iPhone XS"
        case "iPhone11,6", "iPhone11,4":                return "iPhone XS Max"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad6,11", "iPad6,12":                    return "iPad 5"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4":                      return "iPad Pro 9.7 inch"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro 12.9 inch"
        case "iPad7,1", "iPad7,2":                      return "iPad Pro 12.9 inch (2nd generation)"
        case "iPad7,3", "iPad7,4":                      return "iPad Pro 10.5 inch"
        case "AppleTV5,3":                              return "Apple TV (4rd generation)"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
}

open class Phone {

    /*
     * Phone Attributes
     */

    // The name of personal device, like "Batuhan's iPhone"
    static public var name: String {
        return UIDevice.current.name
    }

    // The name of running OS in the device, such as iOS, tvOS and much more.
    static public var systemName: String {
        return UIDevice.current.systemName
    }

    // The version of running OS in the device. (e.g. 9.0, 10.0.)
    static public var systemVersion: String {
        return UIDevice.current.systemVersion
    }

    static public var model: String {
        return UIDevice.current.model
    }

    static public var determinedModel: String {
        return UIDevice.current.modelName
    }

    static public var uuid: String {
        return UIDevice.current.identifierForVendor!.uuidString
    }

    static public var isRetina: Bool {
        return UIScreen.main.scale > 1.0
    }

    static public var isSimulator: Bool {
        return determinedModel == "Simulator"
    }

    static public var isiPhone: Bool {
        return determinedModel.contains("iPhone")
    }

    static public var isiPad: Bool {
        return determinedModel.contains("iPad")
    }

    static public var isiPod: Bool {
        return determinedModel.contains("iPod")
    }

    static public var isTV: Bool {
        return determinedModel.contains("TV")
    }

    static public var screenBounds: CGRect {
        return UIScreen.main.bounds
    }

    /*
     * Battery
     */
    static public var batteryState: UIDevice.BatteryState {
        return UIDevice.current.batteryState
    }

    static public var batteryLevel: Int {
        return Int(UIDevice.current.batteryLevel * 100)
    }

    /*
     * Locale
     */
    static public var regionCode: String {
        return Locale.current.regionCode!
    }

    static public var languageCode: String {
        return Locale.current.languageCode!
    }

    /*
     * BLE
     */
    static public var hasBleDevice: Bool {
        return CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self)
    }
}
