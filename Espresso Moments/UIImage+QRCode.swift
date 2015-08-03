//
//  UIImage+QRCode.swift
//  Espresso Moments
//
//  Created by WiLL on 8/3/15.
//  Copyright (c) 2015 Harvard. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func qrCodeImageForString(string: String!, size: CGSize) -> UIImage? {
        // Create QR Code Image
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter.setValue(string.dataUsingEncoding(NSUTF8StringEncoding,
            allowLossyConversion: false), forKey: "inputMessage")
        filter.setValue("H", forKey: "inputCorrectionLevel")
        let outputImage = filter.outputImage
        
        // Resize Image
        let cgImage = CIContext(options: nil).createCGImage(outputImage,
            fromRect: outputImage.extent())
        let scale = UIScreen.mainScreen().scale
        
        UIGraphicsBeginImageContext(CGSizeMake(size.width * scale, size.height))
        let context = UIGraphicsGetCurrentContext()
        CGContextSetInterpolationQuality(context, kCGInterpolationNone)
        CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage)
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let result = UIImage(CGImage: resizedImage.CGImage, scale: scale,
            orientation: UIImageOrientation.DownMirrored)
        return result
    }
    
}
