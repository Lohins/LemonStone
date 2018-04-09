//
//  BaseImageLoader.swift
//  LemonStone
//
//  Created by Sitong Chen on 2018-04-08.
//  Copyright © 2018 Sitong Chen. All rights reserved.
//

import UIKit

enum LSImageError: Error{
    case getPixelFail
    
}


class BaseImageLoader: NSObject {
    
    var image: UIImage
    
    init(image: UIImage)  {
        self.image = image
        super.init()
        
    }
    
    func getPixels() throws  {
        guard let cgImageRef = self.image.cgImage else{
            throw LSImageError.getPixelFail
        }
        
        let image_width = cgImageRef.width
        let image_height = cgImageRef.height
        
        
        
    }
}
