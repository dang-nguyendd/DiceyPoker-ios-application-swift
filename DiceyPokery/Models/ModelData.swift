import Foundation

//Set player to userDefault
func setUserDefault(user: User){
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(user) {
        let defaults = UserDefaults.standard
        defaults.set(encoded, forKey: user.name)
    }
}

//Check if player exists from userDefault/ if not create one
func checkUserDefault(checkUser: String) -> User{
    var finalUser = User.init(namePlayer: checkUser)
    if let user = UserDefaults.standard.object(forKey: checkUser) as? Data {
        let decoder = JSONDecoder()
        if let loadedUser = try? decoder.decode(User.self, from: user) {
            finalUser = loadedUser
            finalUser.isPlayer = true
        }
    } else {
        var defaultUser = User.init(namePlayer: checkUser)
        defaultUser.isPlayer = true
        setUserDefault(user: defaultUser)
        finalUser = defaultUser
        
    }
    return finalUser
}

//Read player from userDefault
func readUserDefault(checkUser: String) -> User{
    var finalUser = User.init(namePlayer: checkUser)
    if let user = UserDefaults.standard.object(forKey: checkUser) as? Data {
        let decoder = JSONDecoder()
        if let loadedUser = try? decoder.decode(User.self, from: user) {
            finalUser = loadedUser
            finalUser.isPlayer = true
        }
    }
    return finalUser
}
