//
//  UserViewModel.swift
//  POP
//
//  Created by Manyuchi, Carrington C on 2024/11/09.
//

import UIKit


class UserViewModel {
    
    private let userService: UserService
    weak var view: UserView?
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    func fetchUser() {
        userService.fetchUser { result in
            switch result {
            case .success(let user):
                self.view?.updateView(imageUrl: user.avatar, email: user.email)
            case .failure:
                let errorImageUrl = "https://cdn1.iconfinder.com/data/icons/user-fill-icons-set/144/User003_Error-1024.jpg"
                self.view?.updateView(imageUrl: errorImageUrl, email: "No User found")
            }
        }
    }
    
    
}
