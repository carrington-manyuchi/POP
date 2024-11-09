//
//  UserViewController.swift
//  POP
//
//  Created by Manyuchi, Carrington C on 2024/11/09.
//

import UIKit

class UserViewController: UIViewController {
    
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  private let emailLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
    
 private var viewModel: UserViewModel?
    
    init(viewModel: UserViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel?.view  = self
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
      viewModel?.fetchUser()
  }
  
  private func setupViews() {
    view.backgroundColor = .white
    
    view.addSubview(imageView)
    view.addSubview(emailLabel)
    
    NSLayoutConstraint.activate([
      imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      imageView.heightAnchor.constraint(equalToConstant: 100),
      imageView.widthAnchor.constraint(equalToConstant: 100),
      imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 64),
      
      emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      emailLabel.heightAnchor.constraint(equalToConstant: 56),
      emailLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4)
    ])
  }
  
  private func fetchUsers() {
      
      viewModel?.fetchUser()
  }
    
}



struct UserResponse: Decodable {
  let data: User
}

struct User: Decodable {
  let id: Int
  let email: String
  let avatar: String
}


extension UserViewController: UserView {
    func updateView(imageUrl: String, email: String) {
        let imageData = try! NSData(contentsOf: .init(string: imageUrl)!) as Data
        self.imageView.image = UIImage(data: imageData)
        self.emailLabel.text = email
    }
}
