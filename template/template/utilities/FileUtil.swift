import Foundation

class FileUtil {

    public static func getUrl(_ fileName: String, fileExt: String) -> URL? {
        Bundle.main.url(forResource: fileName, withExtension: fileExt)
    }

    public static func readAsString(_ fileName: String, fileExt: String) -> String? {
        let path = Bundle.main.path(forResource: fileName, ofType: fileExt)
        return try? String(contentsOfFile:path!, encoding: String.Encoding.utf8)
    }

    public static func parseFileAsModel<T: Decodable>(fileName: String, fileExt: String, clazz: T.Type) -> T? {
        guard let text = readAsString(fileName, fileExt: fileExt) else { return nil }
        let jsonData: Data = text.data(using: .utf8)!
        return try? JSONDecoder().decode(clazz, from: jsonData)
    }
}
