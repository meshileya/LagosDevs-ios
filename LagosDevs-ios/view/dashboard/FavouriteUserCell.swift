//
//  FavouriteUserCell.swift
//  LagosDevs-ios
//
//  Created by tech on 21/01/2022.
//

import Foundation
import Foundation
import UIKit

class FavouriteUserCell : UICollectionViewCell {
    
    var enlargeImageTapAction : (()->())?
    
    @objc func onEnlargeImageCall() {
        enlargeImageTapAction?()
    }
    
    var item: FavouritesDto? {
        didSet {
            if let model = item{
                nameLabel.text = model.name.capitalized
                addImageView.isHidden = true
                borderLineView.isHidden = false
                let url = URL(string: model.avatarurl)
                userProfileImageView.kf.setImage(with: url, placeholder: UIImage(named: "ic_avatar"))
            }
        }
    }
    
    lazy var userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_placeholder")
        imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.layer.cornerRadius = 30
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var borderLineView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.systemYellow.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 35
        view.heightAnchor.constraint(equalToConstant: 70).isActive = true
        view.widthAnchor.constraint(equalToConstant: 70).isActive = true
        return view
    }()
    
    lazy var rotatingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_rotate")
        imageView.widthAnchor.constraint(equalToConstant: 10).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var addImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_Add")
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.sizeToFit()
        return label
    }()
    
    lazy var customView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.addSubview(borderLineView)
        view.addSubview(userProfileImageView)
        view.addSubview(nameLabel)
        view.addSubview(rotatingImageView)
        view.addSubview(addImageView)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraint(NSLayoutConstraint(item: rotatingImageView, attribute: .top, relatedBy: .equal, toItem: userProfileImageView, attribute: .top, multiplier: 1, constant: -5))
        view.addConstraint(NSLayoutConstraint(item: rotatingImageView, attribute: .right, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: -2))
        
        view.addConstraint(NSLayoutConstraint(item: borderLineView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: borderLineView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: userProfileImageView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: userProfileImageView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: addImageView, attribute: .bottom, relatedBy: .equal, toItem: userProfileImageView, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: addImageView, attribute: .right, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 2))
        
        view.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: userProfileImageView, attribute: .bottom, multiplier: 1, constant: 3))
        view.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeView (){
        addSubview(customView)
        addConstraint(NSLayoutConstraint(item: customView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: customView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: customView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 10))
        addConstraint(NSLayoutConstraint(item: customView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -10))
        
    }
}
