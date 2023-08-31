import Foundation
import UIKit

// MARK: - User

struct User: Codable {
    var user_id: String
    var pw: String
    var name: String
    var refresh_token: String
    var access_token: String
}

class UserManager {
    static let shared = UserManager()
    
    private var user: User?
    
    // 이미지를 서버에 저장하기 전에 넣어놓는 변수
    private var prevSaveImage: UIImage?
    
    private init() {
        // Private initializer to prevent external instantiation
    }
    
    func setUser(_ newUser: User) {
        user = newUser
    }
    
    func getUser() -> User? {
        return user
    }
    
    func getPreSaveImage() -> UIImage?{
        return prevSaveImage
    }
    
    func setUserPrevSaveImage(image:UIImage){
        prevSaveImage = image
    }
    
    func setUserName(name : String){
        user?.name = name
    }
}
