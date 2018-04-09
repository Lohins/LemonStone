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
        
    var cloudCollectionView: UICollectionView!
    
    /*
     Data properties
     */
    
    let photoManager = LSLocalPhotoManager.init()

    let dataList = ["red.jpeg" , "purple.jpg" , "yellow.jpg" , "white.jpeg" , "rose.jpg" , "two.jpeg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.initUI()
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
        let localFlowLayout = UICollectionViewFlowLayout.init()
        localFlowLayout.itemSize = CGSize.init(width: Item_Width, height: Item_Width)
        localFlowLayout.minimumInteritemSpacing = 3
        localFlowLayout.minimumLineSpacing = 3
        localFlowLayout.sectionInset = UIEdgeInsets.init(top: 2, left: 2, bottom: 0, right: 0)
        localFlowLayout.headerReferenceSize = CGSize.init(width: 0, height: 0)
        

        let LocalCellNib = UINib.init(nibName: LSLibraryCollectionLocalCell.Identifier, bundle: nil)
        let CloudCellNib = UINib.init(nibName: LSLibraryCollectionCloudCell.Identifier, bundle: nil)

        
        let localCollectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: Content_Height), collectionViewLayout: localFlowLayout)
        localCollectionView.register(LocalCellNib, forCellWithReuseIdentifier: LSLibraryCollectionLocalCell.Identifier)
        self.photoManager.localCollectionView = localCollectionView
        self.photoManager.request()
        
        
        let cloudFlowLayout = UICollectionViewFlowLayout.init()
        cloudFlowLayout.itemSize = CGSize.init(width: Item_Width, height: Item_Width)
        cloudFlowLayout.minimumInteritemSpacing = 3
        cloudFlowLayout.minimumLineSpacing = 3
        cloudFlowLayout.sectionInset = UIEdgeInsets.init(top: 2, left: 2, bottom: 0, right: 0)
        cloudFlowLayout.headerReferenceSize = CGSize.init(width: 0, height: 0)
        
        
        self.cloudCollectionView = UICollectionView.init(frame: CGRect.init(x: SCREEN_WIDTH, y: 0, width: SCREEN_WIDTH, height: Content_Height), collectionViewLayout: cloudFlowLayout)
        self.cloudCollectionView.register(CloudCellNib, forCellWithReuseIdentifier: LSLibraryCollectionCloudCell.Identifier)
        self.cloudCollectionView.delegate = self
        self.cloudCollectionView.dataSource = self
        
        self.cloudCollectionView.backgroundColor = UIColor.blue
        
        // Add collection views to scrollview
        self.contentScrollView.addSubview(localCollectionView)
        self.contentScrollView.addSubview(self.cloudCollectionView)
    }

    
    @IBAction func testAction(_ sender: Any) {
        let testVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LSImageTestVCViewController")
        let nav = UINavigationController.init(rootViewController: testVC)
        self.navigationController?.present(nav, animated: true, completion: nil)
    }
    

}

extension LSImageLibraryVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    
    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LSLibraryCollectionCloudCell.Identifier, for: indexPath) as! LSLibraryCollectionCloudCell

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
