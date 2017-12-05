import Foundation

struct Settings: Codable {
    struct Color: Codable {
        let red: CGFloat
        let green: CGFloat
        let blue: CGFloat
        let alpha: CGFloat
        
        var nsColor: NSColor {
            return NSColor(red: red, green: green, blue: blue, alpha: alpha)
        }
    }
    
    struct Channel: Codable {
        let name: String
        let controller: Int
        let channel: Int
        let color: Color
    }
    
    let channels: [Channel]
    
    static func load() throws -> Settings {
        guard let url: URL = Bundle.main.url(forResource: "Settings", withExtension: "json") else {
            fatalError("Error: unable to locate settings file")
        }
        let jsonData: Data = try Data(contentsOf: url)
        let jsonDecoder: JSONDecoder = JSONDecoder()
        return try jsonDecoder.decode(Settings.self, from: jsonData)
    }
}
