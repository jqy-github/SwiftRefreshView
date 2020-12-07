//
//  RefreshFooterView.swift
//  Live
//
//  Created by jqy on 2020/5/28.
//  Copyright © 2020 J丶QY. All rights reserved.
//

import UIKit

class RefreshFooterView: RefreshCommonView {
     
    override func scrollDidChangContentOffset(_ change: [NSKeyValueChangeKey : Any]?){
        super.scrollDidChangContentOffset(change)
        
        let oldPoint = change?[NSKeyValueChangeKey(rawValue: "old")] as! CGPoint
        let newPoint = change?[NSKeyValueChangeKey(rawValue: "new")] as! CGPoint
        if newPoint.y <= oldPoint.y {return}
        
        let realScrollViewContentH = self.scrollView!.re_safeAreaInsetsTop + self.scrollView!.re_contentInsetTop + self.scrollView!.re_contentH + self.scrollView!.re_contentInsetBottom + self.scrollView!.re_safeAreaInsetsBottom
        let realScrollViewContentOffsetY = self.scrollView!.re_contentOffsetY + self.scrollView!.re_safeAreaInsetsTop + self.scrollView!.re_contentInsetTop
        if realScrollViewContentH > self.scrollView!.re_height{
            if realScrollViewContentOffsetY > realScrollViewContentH - self.scrollView!.re_height{
                if self.state == .normal {
                    self.beginRefresh()
                }
            }
        }else{
            if realScrollViewContentOffsetY > 10.0 {
                if self.state == .normal {
                    self.beginRefresh()
                }
            }
        }
        
    }
    override func scrollDidChangContentSize(_ change: [NSKeyValueChangeKey : Any]?){
        super.scrollDidChangContentSize(change)
        self.re_top = self.scrollView!.contentSize.height //+ self.scrollViewDefaultContentInsetBottom
        self.scrollView!.re_contentInsetBottom = self.re_height + self.scrollViewDefaultContentInsetBottom
    }
    func setRefreshStateIsNoMoreData() {
        self.state = .noMoreData
    }

}
