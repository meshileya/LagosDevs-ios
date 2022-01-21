//
//  UserCell.swift
//  LagosDevs-ios
//
//  Created by tech on 21/01/2022.
//

import Foundation
import UIKit
import Kingfisher

class UserCell : UICollectionViewCell {
    
    var likesTapAction : (()->())?
    
    var openProfileTapAction : ((ItemsFavouriteDto)->())?
    
    @objc func onOpenProfileCall() {
        guard let user = userInfo else {
            return
        }
        openProfileTapAction?(user)
    }
    
    var userInfo: ItemsFavouriteDto? {
        didSet {
            if let model = userInfo {
                let item = model.item
                let url = URL(string: item.avatarurl)
                textLabel.text = item.name
                //uses the default avatar ic_avatar if url is nil
                profileImageView.kf.setImage(with: url, placeholder: UIImage(named: "ic_avatar"))
                
                if model.isFavourite{
                    favouriteImageView.image = UIImage(named: "ic_favourite_selected")
                }else{
                    favouriteImageView.image = UIImage(named: "ic_favourite_not_selected")
                }
            }
            
        }
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
    
    let favouriteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_favourite_not_selected")
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
        favouriteImageView.isUserInteractionEnabled = true
        favouriteImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onOpenProfileCall)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeView (){
        sizeToFit()
        //Custom cell holder
        backgroundColor = .white
        layer.cornerRadius = 8
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.2, height: 2.0);
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 5.0
        //Adds views to cell
        addSubview(textLabel)
        addSubview(profileImageView)
        addSubview(favouriteImageView)
        
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        favouriteImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        favouriteImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        
        textLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 10).isActive = true
        textLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        textLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
    }
    
}
