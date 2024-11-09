//
//  APIManager.swift
//  POP
//
//  Created by Manyuchi, Carrington C on 2024/11/09.
//

import Foundation


class APIManager: UserService {
  
  static let shared = APIManager()
  
  private init() {}
  
  func fetchUser(completion: @escaping (Result<User, Error>) -> Void) {
    
    let url = URL(string: "https://reqres.in/api/users/2")!
    
    URLSession.shared.dataTask(with: url) { data, res, error in
      guard let data = data else { return }
      DispatchQueue.main.async {
        if let user = try? JSONDecoder().decode(UserResponse.self, from: data).data {
          completion(.success(user))
        } else {
          completion(.failure(NSError()))
        }
      }
    }.resume()
  }
  
}
