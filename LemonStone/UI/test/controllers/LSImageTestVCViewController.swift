//
//  LSImageTestVCViewController.swift
//  LemonStone
//
//  Created by Sitong Chen on 2018-04-08.
//  Copyright © 2018 Sitong Chen. All rights reserved.
//

import UIKit

class LSImageTestVCViewController: UIViewController {

    @IBOutlet weak var contentScrollView: UIScrollView!
    let firstImageView = UIImageView.init()
    let secondImageView = UIImageView.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        // Do any additional setup after loading the view.
    }

    func initUI()  {
        self.title = "IMAGE TEST"
        
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.white
        let button = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        button.setTitle("Back", for: .normal)
        button.addTarget(self, action: #selector(viewDismiss), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: button)
        
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
//        self.scroll
        
        // Set the content size of scroll view.
        let Content_Height = SCREEN_HEIGHT - STATUSBAR_HEIGHT - (self.navigationController?.navigationBar.frame.height)!
        self.contentScrollView.contentSize = CGSize.init(width: SCREEN_WIDTH * 2, height: Content_Height)
        
        self.firstImageView.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: Content_Height)
        self.secondImageView.frame = CGRect.init(x: SCREEN_WIDTH, y: 0, width: SCREEN_WIDTH, height: Content_Height)
        
        self.firstImageView.image = UIImage.init(named: "lena.gif", in: Bundle.main, compatibleWith: nil)
        self.secondImageView.image = UIImage.init(named: "lena.gif", in: Bundle.main, compatibleWith: nil)
        
        self.firstImageView.contentMode = .scaleAspectFit
        self.secondImageView.contentMode = .scaleAspectFit

        self.contentScrollView.addSubview(self.firstImageView)
        self.contentScrollView.addSubview(self.secondImageView)
        
        print(self.contentScrollView.contentSize)
        print(UIScreen.main.bounds)
        
        self.grayScale()
    }
    
    @objc func viewDismiss()  {
        self.navigationController?.dismiss(animated: true)
    }
    
    func grayScale() {
        guard let image = self.firstImageView.image else{
            return
        }
        
        guard var rgba = RGBA.init(image: image) else{
            return
        }
        
        rgba = GrayScaleTool.GrayScale(rgba: rgba, type: .Luminance)
        
        guard let resultImage = rgba.toUIImage() else {
            return
        }
        self.secondImageView.image = resultImage
        
    }

}
