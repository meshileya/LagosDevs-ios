//
//  DashboardController.swift
//  LagosDevs-ios
//
//  Created by tech on 21/01/2022.
//

import Foundation
import UIKit

class DashboardController : UIViewController, ControllerDelegate{
    
    var itemList :[ItemsDto] = []
    var favouriteItemList :[FavouritesDto] = []
    var currentPageNumber = "1"
    var localDb = LocalDb()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        initViews()
        initData()
    }
    
    func initViews(){
        view.addSubview(generalStackView)
        view.addSubview(collectionView)
        
        //Adding constraints to views --METHOD 1
        generalStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        generalStackView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        generalStackView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        //Adding constraints to views --METHOD 2
        view.addConstraint(NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: generalStackView, attribute: .bottom, multiplier: 1, constant: 30))
        view.addConstraint(NSLayoutConstraint(item: collectionView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 20))
        view.addConstraint(NSLayoutConstraint(item: collectionView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -20))
        view.addConstraint(NSLayoutConstraint(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -50))
    }
    
    lazy var generalStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(favouriteEmptyStateLabel)
        stackView.addArrangedSubview(favouriteUserCollectionView)
        
        favouriteUserCollectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        favouriteUserCollectionView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        
        favouriteEmptyStateLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        favouriteEmptyStateLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        
        return stackView
    }()
    
    private func initRefresh()-> Void {
        
        let refreshControl = UIRefreshControl()
        let title = NSLocalizedString("Refreshing...", comment: "Pull to refresh")
        refreshControl.attributedTitle = NSAttributedString(string: title)
        refreshControl.tintColor = UIColor.lightGray
        refreshControl.addTarget(self, action: #selector(refreshOptions(sender:)),
                                 for: .valueChanged)
        self.collectionView.refreshControl = refreshControl
    }
    
    @objc private func refreshOptions(sender: UIRefreshControl) {
        refreshList()
        sender.endRefreshing()
    }
    
    private func refreshList() {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == itemList.count - 1 && LocalDb().getTotalItemsNumber() != itemList.count{  //numberofitem count
            updateNextSet()
        }
    }
    
    func updateNextSet(){
        fetchRemoteData(LocalDb().getCurrentPage() + 1)
    }
    
    lazy var collectionView : DynamicCollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 8
        flowLayout.minimumInteritemSpacing = 4
        let collectionView = DynamicCollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.register(UserCell.self, forCellWithReuseIdentifier: "cellId")
        return collectionView
    }()
    
    lazy var favouriteEmptyStateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.text = "No favourite user, proceed to add below."
        label.sizeToFit()
        return label
    }()
    
    lazy var favouriteUserCollectionView : DynamicCollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 8
        flowLayout.minimumInteritemSpacing = 4
        let collectionView = DynamicCollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.register(FavouriteUserCell.self, forCellWithReuseIdentifier: "favouriteCellId")
        return collectionView
    }()
}
