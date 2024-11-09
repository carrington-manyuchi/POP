//
//  UserView.swift
//  POP
//
//  Created by Manyuchi, Carrington C on 2024/11/09.
//

import Foundation

protocol UserView: AnyObject {
    func updateView(imageUrl: String, email: String)
}
