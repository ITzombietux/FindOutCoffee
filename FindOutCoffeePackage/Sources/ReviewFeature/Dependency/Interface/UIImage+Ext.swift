//
//  UIImage+Ext.swift
//  
//
//  Created by 10004 on 2023/08/17.
//

import Foundation
import UIKit.UIImage

extension UIImage {
    var data: Data? {
        if let data = self.jpegData(compressionQuality: 1.0) {
            return data
        } else {
            return nil
        }
    }
}

extension Data {
    var image: UIImage? {
        if let image = UIImage(data: self) {
            return image
        } else {
            return nil
        }
    }
}
