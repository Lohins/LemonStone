//
//  LSLibraryCollectionCell.swift
//  LemonStone
//
//  Created by Sitong Chen on 2018-04-07.
//  Copyright © 2018 Sitong Chen. All rights reserved.
//

import UIKit

class LSLibraryCollectionCloudCell: UICollectionViewCell {
    
    static let Identifier = "LSLibraryCollectionCloudCell"

    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setImage(image: UIImage)  {
        self.imageView.image = image
    }

}
