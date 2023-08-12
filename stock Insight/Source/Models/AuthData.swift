import Foundation

// MARK: - SignUpData

struct AuthData: Codable {
    let user: User
    let token: String
}

// MARK: - User

struct User: Codable {
    let id: Int
    let email, password, passwordSalt: String
    let isAlarmSet: Bool
    let isDeleted: Bool
    let alarmTime: String?
    let tempPassword: String
    let tempPasswordCreatedAt: String?
    let tempPasswordIssueCount: Int
    let createdAt, updatedAt: String
    let deletedAt: String?
}
