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
        let realScrollViewContentH = self.scrollView!.safeAreaInsets.top + self.scrollView!.re_contentInsetTop + self.scrollView!.re_contentH + self.scrollView!.re_contentInsetBottom + self.scrollView!.safeAreaInsets.bottom
        let realScrollViewContentOffsetY = self.scrollView!.re_contentOffsetY + self.scrollView!.safeAreaInsets.top + self.scrollView!.re_contentInsetTop
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
        self.re_top = self.scrollView!.contentSize.height + self.scrollViewDefaultContentInsetBottom
        self.scrollView!.re_contentInsetBottom = 60 + self.scrollViewDefaultContentInsetBottom
    }
    func setRefreshStateIsNoMoreData() {
        self.state = .noMoreData
    }

}
