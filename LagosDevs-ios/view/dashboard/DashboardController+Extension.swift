//
//  DashboardController+Extension.swift
//  LagosDevs-ios
//
//  Created by tech on 21/01/2022.
//

import Foundation
import UIKit

extension DashboardController : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView{
            return itemList.count
        }else{
            return favouriteItemList.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView{
            let model = itemList[indexPath.item]
            let isFavourite = favouriteItemList.contains(where: {$0.id == model.id })
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! UserCell
            cell.userInfo = ItemsFavouriteDto(isFavourite: isFavourite, item: model)
            cell.openProfileTapAction = { user in
                if user.isFavourite{
                    self.showAlertWithTwoOptions(title: "Delete Favourite", message: "Are you sure you want to delete \(model.name) from Favourite list?", firstActionLabel: "OK", firstAction: { (action) in
                        
                        self.localDb.deleteLocalFavourite(id: model.id)
                        self.initData()
                        
                    }, secondAction: {
                        (action) in
                        
                    })
                }else{
                    self.showAlertWithTwoOptions(title: "Add Favourite", message: "Are you sure you want to add \(model.name) to Favourite list?", firstActionLabel: "OK", firstAction: { (action) in
                        
                        self.localDb.addToLocalFavourite(userDto: model)
                        self.initData()
                        
                    }, secondAction: {
                        (action) in
                        
                    })
                }
            }
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favouriteCellId", for: indexPath) as! FavouriteUserCell
            cell.item = favouriteItemList[indexPath.item]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView{
            return CGSize(width: self.collectionView.frame.width, height: 100)
        }else{
            return CGSize(width: 80, height: 80)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //top, left, bottom, right
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    //
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView{
            onCallUserInfo(selectedUserUrl: self.itemList[indexPath.item].url)
        }else{
            onCallUserInfo(selectedUserUrl: self.favouriteItemList[indexPath.item].url)
        }
        
    }
    
    func initData(){
        showProgress()
        let localData = localDb.getLocalItemsData()
        self.favouriteItemList = localDb.getFavouritetemsData()
        
        if self.favouriteItemList.count > 0{
            self.favouriteEmptyStateLabel.isHidden = true
            self.favouriteUserCollectionView.isHidden = false
            self.favouriteUserCollectionView.reloadData()
        }else{
            self.clearAllImageView.isHidden = true
            self.favouriteEmptyStateLabel.isHidden = false
            self.favouriteUserCollectionView.isHidden = true
        }
        
        if localData.count > 0{
            self.hideProgress()
            self.itemList = localData
            self.collectionView.reloadData()
            self.currentPageNumber = "\(LocalDb().getCurrentPage() + 1)"
        }else{
            //shows empty state then fetch from server
            fetchRemoteData(1)
        }
        
        self.clearAllImageView.isUserInteractionEnabled = true
        self.clearAllImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClearFavouritesCall)))
    }
    
    @objc func onClearFavouritesCall(){
        self.showAlertWithTwoOptions(title: "Delete all Favourites", message: "Are you sure you want to clear your favourite list?", firstActionLabel: "OK", firstAction: { (action) in
            
            self.localDb.deleteAllFavourites()
            self.initData()
            
        }, secondAction: {
            (action) in
            
        })
        
    }
    
    func onCallUserInfo(selectedUserUrl: String){
        showProgress()
        ApiService().fetchUserInfoAsync(userInfoUrl: selectedUserUrl){
            (result, data, error) in
            self.hideProgress()
            if result{
                let vc = UserProfileController()
                vc.selectedUserInfo = data
                self.present(vc, animated: true, completion: nil)
            }else{
                //This is expected to show empty state or displays error from the backend
                print("No data available")
            }
            
        }
    }
    
    func fetchRemoteData(_ currentPageNumber: Int){
        ApiService().fetchUsersAsync(pageNumber: "\(currentPageNumber)"){
            (result, data, error) in
            self.hideProgress()
            if result{
                self.itemList = self.localDb.getLocalItemsData()
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
