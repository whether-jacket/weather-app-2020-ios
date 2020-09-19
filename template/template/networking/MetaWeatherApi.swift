import Foundation
import Moya

public enum MetaWeather {
    case getWeatherForWhereOnEarthId(Int)
    case getLocationsForCitySearch(String)
}

extension MetaWeather: TargetType {
    public var baseURL: URL { return URL(string: "https://www.metaweather.com")! }
    public var path: String {
        switch self {
        case .getWeatherForWhereOnEarthId(let whereOnEarthId):
            return "/api/location/\(whereOnEarthId)"
        case .getLocationsForCitySearch:
            return "/api/location/search"
        }
    }
    public var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    public var task: Task {
        switch self {
        case .getLocationsForCitySearch(let cityName):
            return .requestParameters(
                parameters: ["query": cityName],
                encoding: URLEncoding.default
            )
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
        default:
            return "{login: id: foobar}".data(using: String.Encoding.utf8)!
        }
    }
    public var headers: [String: String]? {
        switch self {
        default:
            return nil
        }
    }
}

public func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}

extension Moya.Response {
    func mapNSArray() throws -> NSArray {
        let any = try self.mapJSON()
        guard let array = any as? NSArray else {
            throw MoyaError.jsonMapping(self)
        }
        return array
    }
}
