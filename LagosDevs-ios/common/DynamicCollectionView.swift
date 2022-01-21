//
//  DynamicCollectionView.swift
//  LagosDevs-ios
//
//  Created by tech on 21/01/2022.
//

import Foundation
import UIKit

class DynamicCollectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize : CGSize {
        let size = self.contentSize
        return size
    }
}
