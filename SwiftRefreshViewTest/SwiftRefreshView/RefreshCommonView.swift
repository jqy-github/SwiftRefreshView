//
//  RefreshCommonView.swift
//  Live
//
//  Created by jqy on 2020/5/28.
//  Copyright © 2020 J丶QY. All rights reserved.
//

import UIKit
let ObserverContentOffsetKeyPath = "contentOffset"
let ObserverContentSizeKeyPath = "contentSize"

enum RefreshState {
    case normal
    case ready
    case refreshing
    case noMoreData
}

class RefreshCommonView: UIView {

    private  weak var target : AnyObject?
    private  var action : Selector?
    weak var scrollView : UIScrollView?
    var refreshCall : (()->())?
    var state = RefreshState.normal
    var scrollViewDefaultContentInsetTop : CGFloat = 0
    var scrollViewDefaultContentInsetBottom : CGFloat = 0
    
    init(refreshCallBack:@escaping ()->Void) {
        super.init(frame: CGRect.zero)
        self.refreshCall = refreshCallBack
        self.setViews()
        self.endRefresh()
    }
    init(addTarget target: AnyObject, action: Selector){
        super .init(frame: CGRect.zero)
        self.target = target
        self.action = action
        self.setViews()
        self.endRefresh()
    }
    func setViews(){}
    override func willMove(toSuperview newSuperview: UIView?) {
        superview?.willMove(toSuperview: newSuperview)
        if let _ = (newSuperview as? UIScrollView) {
            self.removeObserver()
            self.scrollView = newSuperview as? UIScrollView
            self.scrollView?.alwaysBounceVertical = true
            self.addObserver()
            self.re_left = 0
            self.re_height = 60
            self.scrollViewDefaultContentInsetTop = self.scrollView!.re_contentInsetTop
            self.scrollViewDefaultContentInsetBottom = self.scrollView!.re_contentInsetBottom
        }
    }
    override func layoutSubviews() {
        self.re_width = self.scrollView!.re_width
        self.reViewLayout()
    }
    func reViewLayout(){}
    func addObserver(){
        self.scrollView?.addObserver(self, forKeyPath: ObserverContentOffsetKeyPath, options: [.new,.old], context: nil)
        self.scrollView?.addObserver(self, forKeyPath: ObserverContentSizeKeyPath, options: [.new,.old], context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == ObserverContentOffsetKeyPath {
            self.scrollDidChangContentOffset(change)
        }else if keyPath == ObserverContentSizeKeyPath{
            self.scrollDidChangContentSize(change)
        }
    }
    func scrollDidChangContentOffset(_ change: [NSKeyValueChangeKey : Any]?){}
    func scrollDidChangContentSize(_ change: [NSKeyValueChangeKey : Any]?){}
    func removeObserver()  {
        self.scrollView?.removeObserver(self, forKeyPath: ObserverContentOffsetKeyPath)
        self.scrollView?.removeObserver(self, forKeyPath: ObserverContentSizeKeyPath)
    }
    func beginRefresh() {
        self.state = .refreshing
    }
    func endRefresh() {
        self.state = .normal
    }
    func refreshingCallAction() {
       guard self.target == nil || self.action == nil else {
            self.target!.perform(self.action!, with: nil, afterDelay: 0)
            return
       }
       guard self.refreshCall == nil else {
            self.refreshCall!()
            return
        }
    }
    deinit {
        self.removeObserver()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
