//
//  DashboardController.swift
//  LagosDevs-ios
//
//  Created by tech on 21/01/2022.
//

import Foundation
import UIKit

class DashboardController : UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, ControllerDelegate{
    
    var itemList :[ItemsDto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        
        initViews()
        initData()
    }
    
    func initViews(){
        view.addSubview(collectionView)
        
        view.addConstraint(NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 80))
        view.addConstraint(NSLayoutConstraint(item: collectionView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 20))
        view.addConstraint(NSLayoutConstraint(item: collectionView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -20))
        view.addConstraint(NSLayoutConstraint(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -50))
    }
    
    func initData(){
        showProgress()
        let localData = LocalDb().getLocalItemsData()
        if localData.count > 0{
            self.hideProgress()
            self.itemList = localData
            self.collectionView.reloadData()
        }else{
            //shows empty state then fetch from server
            ApiService().fetchUsersAsync(){
                (result, data, error) in
                self.hideProgress()
                if result{
                    self.itemList = LocalDb().getLocalItemsData()
                    if self.itemList.count > 0{
                        self.collectionView.reloadData()
                    }else{
                        //show empty state
                        print("Empty state")
                    }
                    
                }else{
                    //This is expected to show empty state or displays error from the backend
                    print("No data available")
                }
                
            }
        }
        
        
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
        collectionView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        return collectionView
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return itemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! UserCell
        cell.item = itemList[indexPath.item]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //top, left, bottom, right
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    //
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = UserDetailsController()
//        vc.userProfile = itemList[indexPath.item]
//        self.navigationController?.pushViewController(vc, animated: true)
    }
}
