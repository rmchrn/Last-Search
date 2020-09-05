//
//  UIImageView+extension.swift
//  Last Search
//
//  Created by Ramcharan Reddy Gaddam on 05/09/20.
//  Copyright © 2020 Ramcharan. All rights reserved.
//

import UIKit
import SDWebImage

/*
 the below extension decouples the third party framework used. here we can easily change any other framework or our own framework. so that we don't need to change in every place where we needed to download and set image
 */
extension UIImageView {
    func setRemoteImage(url: URL?) {
        self.sd_setImage(with: url)
    }
}
