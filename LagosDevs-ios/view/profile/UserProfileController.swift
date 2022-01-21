//
//  UserProfileController.swift
//  LagosDevs-ios
//
//  Created by tech on 21/01/2022.
//

import Foundation
import UIKit

class UserProfileController : UIViewController{
    
    var selectedUserInfo : UserInfoDto?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initViews()
        initData()
    }
    
    func initViews(){
        view.addSubview(textLabel)
        view.addSubview(profileImageView)
        
        profileImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        profileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        
        
        textLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 40).isActive = true
        textLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor).isActive = true
        textLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
    }
    
    func initData(){
        print("USER INFO \(selectedUserInfo.debugDescription)")
        guard let userInfo = selectedUserInfo else {return}
        
        let url = URL(string: userInfo.avatarUrl ?? "")
        profileImageView.kf.setImage(with: url, placeholder: UIImage(named: "ic_avatar"))
        
        textLabel.text = "Name: \(userInfo.name ?? "N/A")\nCompany: \(userInfo.company ?? "N/A")\nBlog: \(userInfo.blog ?? "N/A")\nFollowers: \(userInfo.followers ?? 0)\nFollowing: \(userInfo.following  ?? 0)"
    }
    
    let textLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.sizeToFit()
        return label
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_avatar")
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
}
