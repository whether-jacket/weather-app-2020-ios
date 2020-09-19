import Foundation
import Moya
import RxSwift

protocol MetaWeatherRepoInterface {
    func getWeatherForWhereOnEarthId(whereOnEarthId: Int) -> Observable<WeatherForLocationResponse>
}

struct MetaWeatherRepo : MetaWeatherRepoInterface {
    let apiClient: MoyaProvider<MetaWeather>
    
//    init(apiClient: MoyaProvider<MetaWeather> = MoyaProvider<MetaWeather>()) {
    init(apiClient: MoyaProvider<MetaWeather> = metaWeatherProvider) {
        self.apiClient = apiClient
    }
    
    func getWeatherForWhereOnEarthId(whereOnEarthId: Int) -> Observable<WeatherForLocationResponse> {
        return apiClient.rx
            .request(.getWeatherForWhereOnEarthId(whereOnEarthId))
            .map(WeatherForLocationResponse.self)
            .asObservable()
    }
}
