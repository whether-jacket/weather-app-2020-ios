import Foundation
import Moya

public enum MetaWeather {
    case getWeatherForWhereOnEarthId(Int)
//    case getLocationsForCitySearch(String)
}

extension MetaWeather: TargetType {
    public var baseURL: URL { return URL(string: "https://www.metaweather.com")! }
    public var path: String {
        switch self {
        case .getWeatherForWhereOnEarthId(let whereOnEarthId):
            return "/api/location/\(whereOnEarthId)"
//        case .getLocationsForCitySearch(let cityName):
//            return "/api/location/search"
        }
    }
    public var method: Moya.Method {
        return .get
    }
    public var task: Task {
        switch self {
//        case .getLocationsForCitySearch:
//            return .requestParameters(
//                parameters: ["query"],
//                encoding: URLEncoding.default
//            )
        default:
            return .requestPlain
        }
    }
    public var validationType: ValidationType {
        switch self {
        case .getWeatherForWhereOnEarthId:
            return .successCodes
        default:
            return .none
        }
    }
    public var sampleData: Data {
        switch self {
        case .getWeatherForWhereOnEarthId:
            return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
//        case .getLocationsForCitySearch(let cityName):
//            return "{\"login\": \"\(name)\", \"id\": 100}".data(using: String.Encoding.utf8)!
        }
    }
    public var headers: [String: String]? {
        return nil
    }
}

public func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}

// MARK: - Response Handlers

extension Moya.Response {
    func mapNSArray() throws -> NSArray {
        let any = try self.mapJSON()
        guard let array = any as? NSArray else {
            throw MoyaError.jsonMapping(self)
        }
        return array
    }
}
