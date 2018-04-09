//
//  LSLocalPhotoManager.swift
//  LemonStone
//
//  Created by Sitong Chen on 2018-04-07.
//  Copyright © 2018 Sitong Chen. All rights reserved.
//


import Photos
import UIKit

class LSLocalPhotoManager: NSObject {
    
    var photoArray: [PHAsset] = []
    let Cell_Width = SCREEN_WIDTH / 4 - 3

    var localCollectionView: UICollectionView!

    override init() {
        super.init()
        
    }

    func request()  {
        localCollectionView.delegate = self
        localCollectionView.dataSource = self
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status{
            case .authorized:
                print("Done")
                let fetchOptions = PHFetchOptions()
                let allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
                print(allPhotos.count)
                allPhotos.enumerateObjects({ (asset, index, pointer) in
                    self.photoArray.append(asset)
                })
                print(allPhotos)
                DispatchQueue.main.async {
                    self.localCollectionView.reloadData()
                }
            case .denied, .restricted:
                print("denied")
            case .notDetermined:
                print("notDetermined")
            }
        }
    }
}

extension LSLocalPhotoManager: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
//        if (self.photoArray.count > 25){
//            return 25
//        }
        return self.photoArray.count
    }
    
    
    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LSLibraryCollectionLocalCell.Identifier, for: indexPath) as! LSLibraryCollectionLocalCell
        
        cell.backgroundColor = UIColor.cyan
        
        let asset = self.photoArray[indexPath.row]
        PHImageManager.default().requestImage(for: asset, targetSize: CGSize.init(width: Cell_Width, height: Cell_Width), contentMode: .aspectFill, options: nil) { (image, data) in
            if let image = image{
                cell.setImage(image: image)
            }
        }
        return cell
    }
    
    // MARK : UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: Cell_Width, height: Cell_Width)
    }
    
}

