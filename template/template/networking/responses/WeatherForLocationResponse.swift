import Foundation

struct WeatherForLocationResponse: Codable {
    let consolidatedWeather: [ConsolidatedWeatherResponse]
    let time: String
    let sunrise: String
    let sunset: String
    let timezoneName: String
    let parent: RegionResponse
    let sources: [Source]
    let title: String
    let locationType: String
    let woeid: Int
    let lattLong, timezone: String

    enum CodingKeys: String, CodingKey {
        case consolidatedWeather = "consolidated_weather"
        case time
        case sunrise = "sun_rise"
        case sunset = "sun_set"
        case timezoneName = "timezone_name"
        case parent, sources, title
        case locationType = "location_type"
        case woeid
        case lattLong = "latt_long"
        case timezone
    }
}

struct Source: Codable {
    let title, slug: String
    let url: String
    let crawlRate: Int

    enum CodingKeys: String, CodingKey {
        case title, slug, url
        case crawlRate = "crawl_rate"
    }
}
