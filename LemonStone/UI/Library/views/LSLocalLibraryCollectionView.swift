//
//  LSLocalLibraryCollectionView.swift
//  LemonStone
//
//  Created by Sitong Chen on 2018-04-07.
//  Copyright © 2018 Sitong Chen. All rights reserved.
//

import UIKit

class LSLocalLibraryCollectionView: UICollectionView {
    

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        print("Go to the init collection")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
