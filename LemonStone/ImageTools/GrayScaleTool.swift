//
//  GrayScaleTool.swift
//  LemonStone
//
//  Created by Sitong Chen on 2018-04-08.
//  Copyright © 2018 Sitong Chen. All rights reserved.
//

import UIKit

enum GrayScaleAlgorithmType{
    case Average
    case Luminance
    case Desaturation
    case DecompositionMax
    case DecompositionMin
    case SingleColorChannelGreen
    case SingleColorChannelRed
    case SingleColorChannelBlue
    case GrayShades(Int)
}

class GrayScaleTool: BaseImageLoader {
    
    static func GrayScale(rgba : RGBA, type: GrayScaleAlgorithmType) -> RGBA{
        for i in 0..<rgba.width{
            for k in 0..<rgba.height{
                let index = k * rgba.width + i
                var pixel = rgba.pixels[index]
                let blue = Double(pixel.Blue)
                let green = Double(pixel.Green)
                let red = Double(pixel.Red)
                
                var grayValue = UInt8(0)
                switch type{
                case .Average:
                    grayValue = UInt8( (red + green + blue) / 3 )
                case .Luminance:
                    grayValue = UInt8( Int( Double(red) * 0.3 + Double(green) * 0.59 + Double(blue) * 0.11 ) )
                case .Desaturation:
                    let Max = max(red, green, blue)
                    let Min =  min(red, green, blue)
                    grayValue = UInt8( (Max + Min) / 2)
                case .DecompositionMax:
                    grayValue = UInt8( max(red, green, blue) )
                case .DecompositionMin:
                    grayValue = UInt8( min(red, green, blue) )
                case .SingleColorChannelRed:
                    grayValue = UInt8( red )
                case .SingleColorChannelBlue:
                    grayValue = UInt8( blue )
                case .SingleColorChannelGreen:
                    grayValue = UInt8( green )
                case .GrayShades(let numberOfShades):
                    let conversionFactor: Double = 255 / ( Double(numberOfShades) - 1)
                    let averageValue = (red + green + blue) / 3
                    grayValue = UInt8( ((Double(averageValue) / Double(conversionFactor)) + 0.5) * conversionFactor )
                }
                
                pixel.Blue = grayValue
                pixel.Red = grayValue
                pixel.Green = grayValue
                rgba.pixels[index] = pixel
            }
        }
        return rgba
    }
    
    static func GreenFilter(rgba : RGBA) -> RGBA{
        for i in 0..<rgba.width{
            for k in 0..<rgba.height{
                let index = k * rgba.width + i
                var pixel = rgba.pixels[index]
                pixel.Blue = 0
                pixel.Red = 0
                rgba.pixels[index] = pixel
            }
        }
        return rgba
    }
    
    static func RedFilter(rgba : RGBA) -> RGBA{
        for i in 0..<rgba.width{
            for k in 0..<rgba.height{
                let index = k * rgba.width + i
                var pixel = rgba.pixels[index]
                pixel.Blue = 0
                pixel.Green = 0
                rgba.pixels[index] = pixel
            }
        }
        return rgba
    }

    
    static func BlueFilter(rgba : RGBA) -> RGBA{
        for i in 0..<rgba.width{
            for k in 0..<rgba.height{
                let index = k * rgba.width + i
                var pixel = rgba.pixels[index]
                pixel.Green = 0
                pixel.Red = 0
                rgba.pixels[index] = pixel
            }
        }
        return rgba
    }
}
