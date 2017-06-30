//
//  ListIconView.swift
//  StarterProject
//
//  Created by Srinivas, Deepak - Deepak on 6/24/17.
//
//

import UIKit

class ListIconView: UIView {

    static var icon: UIImage? = {
        ListIconView.getIcon()
    }()
    
    static fileprivate func getIcon() -> UIImage? {
        let nib = UINib(nibName: "ListIconView", bundle: nil)
        let listIconView = nib.instantiate(withOwner: self, options: nil).first as! ListIconView
        let rect = CGRect(x: 0, y: 0, width: 32, height: 32)
        listIconView.frame = rect
        
        //Generate image
        UIGraphicsBeginImageContextWithOptions(rect.size, !listIconView.isOpaque, UIScreen.main.scale)
        listIconView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    static func getView() -> ListIconView {
        let nib = UINib(nibName: "ListIconView", bundle: nil)
        let listIconView = nib.instantiate(withOwner: self, options: nil).first as! ListIconView
        let rect = CGRect(x: 0, y: 0, width: 32, height: 32)
        listIconView.frame = rect
        listIconView.isUserInteractionEnabled = true
        return listIconView
    }
}

class GridIconView: UIView {
    
    static var icon: UIImage? = {
        GridIconView.getIcon()
    }()
    
    static fileprivate func getIcon() -> UIImage? {
        let nib = UINib(nibName: "GridIconView", bundle: nil)
        let gridIconView = nib.instantiate(withOwner: self, options: nil).first as! GridIconView
        let rect = CGRect(x: 0, y: 0, width: 32, height: 32)
        gridIconView.frame = rect
        
        //Generate image
        UIGraphicsBeginImageContextWithOptions(rect.size, !gridIconView.isOpaque, UIScreen.main.scale)
        gridIconView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    static func getView() -> GridIconView {
        let nib = UINib(nibName: "GridIconView", bundle: nil)
        let gridIconView = nib.instantiate(withOwner: self, options: nil).first as! GridIconView
        let rect = CGRect(x: 0, y: 0, width: 32, height: 32)
        gridIconView.frame = rect
        gridIconView.isUserInteractionEnabled = true
        return gridIconView
    }
}

class HugeIconView: UIView {
    
    static var icon: UIImage? = {
        HugeIconView.getIcon()
    }()
    
    static fileprivate func getIcon() -> UIImage? {
        let nib = UINib(nibName: "HugeIconView", bundle: nil)
        let hugeIconView = nib.instantiate(withOwner: self, options: nil).first as! HugeIconView
        let rect = CGRect(x: 0, y: 0, width: 32, height: 32)
        hugeIconView.frame = rect
        
        //Generate image
        UIGraphicsBeginImageContextWithOptions(rect.size, !hugeIconView.isOpaque, UIScreen.main.scale)
        hugeIconView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    static func getView() -> HugeIconView {
        let nib = UINib(nibName: "HugeIconView", bundle: nil)
        let hugeIconView = nib.instantiate(withOwner: self, options: nil).first as! HugeIconView
        let rect = CGRect(x: 0, y: 0, width: 32, height: 32)
        hugeIconView.frame = rect
        hugeIconView.isUserInteractionEnabled = true
        return hugeIconView
    }
}
