//
//  Helpers.swift
//  iOS
//
//  Created by Felix Herrmann on 14.10.21.
//

import UIKit


// MARK: - UIPageViewController Helpers

extension UIPageViewController {
    
    var pageControl: UIPageControl? {
        return value(forKey: "_pageControl") as? UIPageControl
    }
}
