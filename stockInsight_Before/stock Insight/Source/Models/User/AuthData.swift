import Foundation

// MARK: - User

struct User: Codable {
    var user_id: String
    var pw: String
    var name: String
    var refresh_token: String
    var access_token: String
}
