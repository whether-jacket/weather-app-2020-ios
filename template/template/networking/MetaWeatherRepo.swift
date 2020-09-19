import Foundation
import Moya
import RxSwift

protocol MetaWeatherRepoInterface {
    func getWeatherForWhereOnEarthId(whereOnEarthId: Int) -> Observable<WeatherForLocationResponse>
    func getLocationsForCitySearch(cityName: String) -> Observable<Array<LocationResponse>>
}

struct MetaWeatherRepo : MetaWeatherRepoInterface {
    let apiClient: MoyaProvider<MetaWeather>

    init(apiClient: MoyaProvider<MetaWeather> = metaWeatherProvider) {
        self.apiClient = apiClient
    }
    
    func getWeatherForWhereOnEarthId(whereOnEarthId: Int) -> Observable<WeatherForLocationResponse> {
        return apiClient.rx
            .request(.getWeatherForWhereOnEarthId(whereOnEarthId))
            .map(WeatherForLocationResponse.self)
            .asObservable()
    }
    
    func getLocationsForCitySearch(cityName: String) -> Observable<Array<LocationResponse>> {
        return apiClient.rx
            .request(.getLocationsForCitySearch(cityName))
            .map(Array<LocationResponse>.self)
            .asObservable()
    }
}
