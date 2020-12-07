//
//  RefreshExtension.swift
//  Live       
//
//  Created by jqy on 2020/5/28.
//  Copyright © 2020 J丶QY. All rights reserved.
//
import UIKit

extension UIScrollView {
    
    var headerRefreshView : RefreshHeaderView? {
        get{
            let key : UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "headerRefreshView".hashValue)
            return objc_getAssociatedObject(self, key) as? RefreshHeaderView
        }
        set{
            guard newValue == nil else {
                if headerRefreshView != newValue {
                   headerRefreshView?.removeFromSuperview()
                    self.insertSubview(newValue!, at: 0)
                    let key : UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "headerRefreshView".hashValue)
                    objc_setAssociatedObject(self, key, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
                }
                return
            }
        }
    }
    
    var footerRefreshView : RefreshFooterView? {
        get{
            let key : UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "footerRefreshView".hashValue)
            return objc_getAssociatedObject(self, key) as? RefreshFooterView
        }
        set{
            guard newValue == nil else {
                if footerRefreshView != newValue {
                   footerRefreshView?.removeFromSuperview()
                    self.insertSubview(newValue!, at: 0)
                    let key : UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "footerRefreshView".hashValue)
                    objc_setAssociatedObject(self, key, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
                }
                return
            }
        }
    }
    
    var re_contentH : CGFloat {
        get{
            self.contentSize.height
        }
    }
    
    var re_contentW : CGFloat {
        get{
            self.contentSize.width
        }
    }
    
    var re_contentOffsetX : CGFloat{
        get{
            self.contentOffset.x
        }
    }
    
    var re_contentOffsetY : CGFloat{
        get{
            self.contentOffset.y
        }
    }
    
    var re_contentInsetTop : CGFloat{
        get{
            self.contentInset.top
        }
        set{
            self.contentInset.top = newValue
        }
    }
    
    var re_contentInsetBottom : CGFloat{
        get{
            self.contentInset.bottom
        }
        set{
            self.contentInset.bottom = newValue
        }
    }
    
    var re_safeAreaInsetsTop: CGFloat {
        if #available(iOS 11.0, *) {
            return self.safeAreaInsets.top
        } else {
            return 0
        }
    }
    var re_safeAreaInsetsBottom : CGFloat{
        if #available(iOS 11.0, *) {
           return self.safeAreaInsets.bottom
        } else {
            return 0
        }
    }
    
    
}

extension UIView {
    var re_left : CGFloat {
        get {
            return self.frame.origin.x
        }
        set{
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    var re_top : CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    var re_right : CGFloat {
        get {
            return self.frame.maxX
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue - self.re_width
            self.frame = frame
        }
    }
    
    var re_bottom : CGFloat {
        get {
            return self.frame.maxY
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue - self.re_height
            self.frame = frame
        }
    }
    
    var re_width : CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    var re_height : CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    var re_centerX : CGFloat{
        get{
            return self.center.x
        }
        set{
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
    }
    
    var re_centerY : CGFloat{
        get{
            return self.center.y
        }
        set{
            self.center = CGPoint(x: self.center.x, y: newValue)
        }
    }
    
}
