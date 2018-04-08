//
//  LSImageLibraryVC.swift
//  LemonStone
//
//  Created by Sitong Chen on 2018-04-07.
//  Copyright © 2018 Sitong Chen. All rights reserved.
//

import UIKit

class LSImageLibraryVC: UIViewController {

    /*
     UI properties
     */
    @IBOutlet weak var topTabBar: UITabBar!
    
    @IBOutlet weak var contentScrollView: UIScrollView!
    
    var localCollectionView: UICollectionView!
    
    var cloudCollectionView: UICollectionView!
    
    /*
     Data properties
     */
    let dataList = ["red.jpeg" , "purple.jpg" , "yellow.jpg" , "white.jpeg" , "rose.jpg" , "two.jpeg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func initUI() {
        self.title = "LIBRARY"
        
        // Set default selected tab bar.
        self.topTabBar.delegate = self
        self.topTabBar.selectedItem = self.topTabBar.items![0]
        
        let firstBarItem = self.topTabBar.items![0]
        firstBarItem.image = UIImage.init(named: "library_local")?.withRenderingMode(.alwaysOriginal)
        firstBarItem.selectedImage = UIImage.init(named: "library_local_selected")?.withRenderingMode(.alwaysOriginal)
        firstBarItem.imageInsets = UIEdgeInsets.init(top: 6, left: 0, bottom: -6, right: 0)
        
        let secondBarItem = self.topTabBar.items![1]

        secondBarItem.image = UIImage.init(named: "library_cloud")?.withRenderingMode(.alwaysOriginal)
        secondBarItem.selectedImage = UIImage.init(named: "library_cloud_selected")?.withRenderingMode(.alwaysOriginal)
        secondBarItem.imageInsets = UIEdgeInsets.init(top: 6, left: 0, bottom: -6, right: 0)


        
        // Set the content size of scroll view.
        let Content_Height = SCREEN_HEIGHT - self.topTabBar.frame.height * 2 - (self.navigationController?.navigationBar.frame.height)! - STATUSBAR_HEIGHT
        self.contentScrollView.contentSize = CGSize.init(width: SCREEN_WIDTH * 2, height: Content_Height)
        self.contentScrollView.delegate = self
        
        // configure collection view
        let Item_Width = SCREEN_WIDTH / 4 - 3
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.itemSize = CGSize.init(width: Item_Width, height: Item_Width)
        flowLayout.minimumInteritemSpacing = 3
        flowLayout.minimumLineSpacing = 3
        flowLayout.sectionInset = UIEdgeInsets.init(top: 2, left: 2, bottom: 0, right: 0)
        flowLayout.headerReferenceSize = CGSize.init(width: 0, height: 0)
        
        
        let cellNib = UINib.init(nibName: LSLibraryCollectionCell.Identifier, bundle: nil)
        
        self.localCollectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: Content_Height), collectionViewLayout: flowLayout)
        self.localCollectionView.register(cellNib, forCellWithReuseIdentifier: LSLibraryCollectionCell.Identifier)
        self.localCollectionView.delegate = self
        self.localCollectionView.dataSource = self
        
        self.cloudCollectionView = UICollectionView.init(frame: CGRect.init(x: SCREEN_WIDTH, y: 0, width: SCREEN_WIDTH, height: Content_Height), collectionViewLayout: flowLayout)
        self.cloudCollectionView.register(cellNib, forCellWithReuseIdentifier: LSLibraryCollectionCell.Identifier)
        self.cloudCollectionView.delegate = self
        self.cloudCollectionView.dataSource = self
        
        self.localCollectionView.backgroundColor = UIColor.red
        self.cloudCollectionView.backgroundColor = UIColor.blue
        
        // Add collection views to scrollview
        self.contentScrollView.addSubview(self.localCollectionView)
        self.contentScrollView.addSubview(self.cloudCollectionView)
    }


}

extension LSImageLibraryVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    
    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LSLibraryCollectionCell.Identifier, for: indexPath) as! LSLibraryCollectionCell

        if let image = UIImage.init(named: self.dataList[indexPath.row], in: Bundle.main, compatibleWith: nil){
            cell.setImage(image: image)
        }
        
        return cell
    }
    
    // MARK : UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let Item_Width = SCREEN_WIDTH / 4 - 3
        return CGSize.init(width: Item_Width, height: Item_Width)
    }
    
}

extension LSImageLibraryVC: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
        if offset < (SCREEN_WIDTH / 2){
            self.topTabBar.selectedItem = self.topTabBar.items![0]
        }else{
            self.topTabBar.selectedItem = self.topTabBar.items![1]
        }
    }
}

extension LSImageLibraryVC : UITabBarDelegate{
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("tab bar selected.")
        UIView.animate(withDuration: 0.3) {
            if (tabBar.items!.index(of: item) == 0){
                self.contentScrollView.contentOffset = CGPoint.init(x: 0, y: 0)
            }
            else{
                self.contentScrollView.contentOffset = CGPoint.init(x: SCREEN_WIDTH, y: 0)
            }
        }

    }
}
