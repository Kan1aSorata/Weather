//
//  UIColor.swift
//  Weather
//
//  Created by 贺峰煜 on 2020/12/2.
//

extension UIColor {
    class func colorWithHexStringSw (hex:String)-> UIColor {
        
        func hex2dec(num:String) -> Float {
            let str = num.uppercaseString
            var sum:Float = 0
            for i in str.utf8 {
                sum = sum * 16 + Float(i) - 48 // 0-9 从48开始
                if i >= 65 {                 // A-Z 从65开始，但有初始值10，所以应该是减去55
                    sum -= 7
                }
            }
            return sum
        }
        
        var hexString = hex
        
        if (hexString.hasPrefix("#")) {
            hexString = (hexString as NSString).substringFromIndex(1)
        }
        
        let index = hexString.startIndex.advancedBy(2)
        let index2 = hexString.startIndex.advancedBy(4)
        let range = Range(index ..< index2)
        
        let s1:String = hexString.substringToIndex(index)
        let s2:String = hexString.substringWithRange(range)
        let s3 = hexString.substringFromIndex(index2)
        
        return UIColor(red:CGFloat(hex2dec(s1))/255.0, green:CGFloat(hex2dec(s2)) / 255.0, blue:CGFloat(hex2dec(s3)) / 255.0, alpha:1)
    }
