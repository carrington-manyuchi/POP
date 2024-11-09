//
//  UserService.swift
//  POP
//
//  Created by Manyuchi, Carrington C on 2024/11/09.
//

import Foundation


protocol UserService {
    func fetchUser(completion: @escaping (Result<User, Error>) -> Void)
}
