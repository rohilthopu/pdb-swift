//
//  ConstraintWrapper.swift
//  pad-db
//
//  Created by Rohil Thopu on 2/22/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit

enum VerticalAnchor {
    case top
    case bottom
}

enum HorizontalAnchor {
    case leading
    case trailing
}

extension UIView {
    
    func setTopAnchor(to location:VerticalAnchor, of view:UIView, withSpacing spacing:CGFloat) {
        switch location {
        case .top:
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: spacing).isActive = true
        case .bottom:
            self.topAnchor.constraint(equalTo: view.bottomAnchor, constant: spacing).isActive = true
        }
    }
    
    func setBottomAnchor(to location:VerticalAnchor, of view:UIView, withSpacing spacing:CGFloat) {
        switch location {
        case .top:
            self.bottomAnchor.constraint(equalTo: view.topAnchor, constant: -1 * spacing).isActive = true
        case .bottom:
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: spacing).isActive = true
        }
    }
    
    func setLeftAnchor(to location:HorizontalAnchor, of view:UIView, withSpacing spacing:CGFloat) {
        switch location {
        case .leading:
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: spacing).isActive = true
        case .trailing:
            self.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: spacing).isActive = true
        }
    }
    
    func setRightAnchor(to view:UIView, withSpacing spacing:CGFloat) {
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1 * spacing).isActive = true
    }
    
    func setTopAnchor(to location:VerticalAnchor, of view:UIView) {
        switch location {
        case .top:
            self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        case .bottom:
            self.topAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
    }
    
    func setBottomAnchor(to location:VerticalAnchor, of view:UIView) {
        switch location {
        case .top:
            self.bottomAnchor.constraint(equalTo: view.topAnchor).isActive = true
        case .bottom:
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
    }
    
    func setLeftAnchor(to location:HorizontalAnchor, of view:UIView) {
        switch location {
        case .leading:
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        case .trailing:
            self.leadingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        }
    }
    
    func setRightAnchor(to view:UIView) {
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func setCenterXAnchor(to view:UIView) {
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setCenterYAnchor(to view:UIView) {
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
