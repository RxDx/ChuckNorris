//
//  UIViewControllerExtensions.swift
//  ChuckNorris
//
//  Created by Rodrigo Dumont on 11/12/18.
//  Copyright © 2018 Rodrigo Dumont. All rights reserved.
//

import UIKit

extension UIViewController {
    static func loadFromStoryboard() -> UIViewController? {
        return UIStoryboard(name: String(describing: self), bundle: Bundle.main).instantiateInitialViewController()
    }
}
