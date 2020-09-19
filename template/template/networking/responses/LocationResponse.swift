import Foundation

struct LocationResponse: Codable {
    let cityTitle: String
    let locationType: String
    let woeid: Int
    let lattLong: String

    enum CodingKeys: String, CodingKey {
        case cityTitle = "title"
        case locationType = "location_type"
        case woeid
        case lattLong = "latt_long"
    }
}
