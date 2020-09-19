import Alamofire
import Foundation
import Moya
import RxSwift

private let REQUEST_TIME_OUT_SECONDS: Double = 20

class DefaultAlamofireSession: Alamofire.Session {
    static let shared: DefaultAlamofireSession = {
        let configuration = URLSessionConfiguration.default.apply {
            $0.headers = .default
            $0.timeoutIntervalForRequest = REQUEST_TIME_OUT_SECONDS
            $0.timeoutIntervalForResource = REQUEST_TIME_OUT_SECONDS
            $0.requestCachePolicy = .useProtocolCachePolicy
        }
        return DefaultAlamofireSession(configuration: configuration)
    }()
}

let metaWeatherProvider = MoyaProvider<MetaWeather>(
    session: DefaultAlamofireSession.shared
)
