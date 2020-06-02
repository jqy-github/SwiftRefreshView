//
//  RefreshHeaderView.swift
//  Live
//
//  Created by jqy on 2020/6/1.
//  Copyright © 2020 J丶QY. All rights reserved.
//

import UIKit

class RefreshHeaderView: RefreshCommonView {
    override func reViewLayout() {
        super.reViewLayout()
        self.re_top = -self.re_height - self.scrollViewDefaultContentInsetTop
    }
    override func scrollDidChangContentOffset(_ change: [NSKeyValueChangeKey : Any]?) {
        super.scrollDidChangContentOffset(change)
        if self.scrollView?.isDragging == true {
           let realScrollViewContentOffsetY = self.scrollView!.re_contentOffsetY + self.scrollView!.safeAreaInsets.top + self.scrollView!.re_contentInsetTop
              if realScrollViewContentOffsetY <  -self.re_height {
                 if self.state == .normal {
                    self.readyToRefresh()
                 }
              }else{
                if self.state == .ready {
                    self.endRefresh()
                }
              }
           }else{
            if self.state == .ready {
                self.beginRefresh()
            }
        }
    }
    func readyToRefresh() {
        self.state = .ready
    }
    override func beginRefresh() {
        super.beginRefresh()
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3) {
                self.scrollView?.re_contentInsetTop = self.re_height + self.scrollViewDefaultContentInsetTop
                self.scrollView!.setContentOffset(CGPoint(x: 0, y:  -self.scrollView!.safeAreaInsets.top - self.scrollView!.re_contentInsetTop), animated: false)
            }
        }
    }
    override func endRefresh() {
        if self.state == .refreshing {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3) {
                    self.scrollView?.re_contentInsetTop = self.scrollViewDefaultContentInsetTop
                    self.scrollView!.setContentOffset(CGPoint(x: 0, y:  -self.scrollView!.safeAreaInsets.top - self.scrollView!.re_contentInsetTop), animated: false)
                }
            }
        }
        super.endRefresh()
    }
    
}
