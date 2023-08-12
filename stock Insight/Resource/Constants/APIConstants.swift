import Foundation

struct APIConstants{
    static let baseURL = "https://watch.ngrok.app"
    
    
    static var userId: Int = UserDefaults.standard.integer(forKey: "userId") {
        willSet(newUserId) {
            userInfoURL = usersURL + "/\(newUserId)"
        }
    }
    
    //MARK: User
    
    static let usersURL = baseURL + "/users"
    
    //회원가입(post)
    static let signUpURL = baseURL + "/register"
    
    //로그인(post)
    static let signInURL = baseURL + "/loginProc"
    
    // 회원 조회(get), 회원 탈퇴(delete) url
    static var userInfoURL = usersURL + "/\(userId)" {
        willSet(newUserInfoURL) {
            passwordURL = newUserInfoURL + "/password"
        }
    }
    
    // 비밀번호 변경(put), 확인(post) url
    static var passwordURL = userInfoURL + "/password"
    

}
