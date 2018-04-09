//
//  LSPixel.swift
//  LemonStone
//
//  Created by Sitong Chen on 2018-04-08.
//  Copyright © 2018 Sitong Chen. All rights reserved.
//

import UIKit

struct Pixel {
    var pixelValue: UInt32
    var Red: UInt8{
        get { return UInt8.init(pixelValue & 0xFF)}
        set { pixelValue = UInt32(newValue) | (pixelValue & 0xFFFFFF00)
}
    }
    var Green: UInt8{
        get { return UInt8.init((pixelValue >> 8) & 0xFF)}
        set { pixelValue = (UInt32(newValue) << 8) | (pixelValue & 0xFFFF00FF)}
    }
    var Blue: UInt8{
        get { return UInt8.init((pixelValue >> 16) & 0xFF)}
        set { pixelValue = (UInt32(newValue) << 16) | (pixelValue & 0xFF00FFFF)}
    }
    var Alpha: UInt8{
        get { return UInt8.init((pixelValue >> 24) & 0xFF)}
        set { pixelValue = (UInt32(newValue) << 24) | (self.pixelValue & 0x00FFFFFF)}
    }
}
