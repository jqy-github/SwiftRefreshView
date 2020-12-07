//
//  UINormalRefreshHeaderView.swift
//  Live
//
//  Created by jqy on 2020/6/1.
//  Copyright © 2020 J丶QY. All rights reserved.
//

import UIKit

class UINormalRefreshHeaderView: RefreshHeaderView {
   private let stateLabel = UILabel()
   private let arrowImageView = UIImageView()
   private let refreshActivityIndicatorView = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.gray)
   override func setViews() {
        stateLabel.textAlignment = .center
        stateLabel.font = UIFont.systemFont(ofSize: 15)
        stateLabel.textColor = .gray
        self.addSubview(stateLabel)
        stateLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.centerX.equalTo(self).offset(16)
        }
        arrowImageView.image = UIImage(named: "SwiftRefreshViewResourse.bundle/arrow.png")
        self.addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints { (make) in
            make.right.equalTo(stateLabel.snp.left)
            make.centerY.equalTo(stateLabel)
            make.width.height.equalTo(32)
        }
        self.addSubview(refreshActivityIndicatorView)
        refreshActivityIndicatorView.snp.makeConstraints { (make) in
            make.center.equalTo(arrowImageView)
            make.width.height.equalTo(13)
        }
        
    }
    override func readyToRefresh() {
        super.readyToRefresh()
        stateLabel.text = "松开刷新"
        UIView.animate(withDuration: 0.25) {
            self.arrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        }
    }
    override func beginRefresh() {
        super.beginRefresh()
        self.refreshActivityIndicatorView.isHidden = false
        self.arrowImageView.isHidden = true
        self.refreshActivityIndicatorView.startAnimating()
        stateLabel.text = "刷新中..."
        self.refreshingCallAction()
    }
    override func endRefresh() {
         super.endRefresh()
         self.refreshActivityIndicatorView.stopAnimating()
         self.refreshActivityIndicatorView.isHidden = true
         self.arrowImageView.isHidden = false
         stateLabel.text = "下拉刷新"
         UIView.animate(withDuration: 0.3) {
           self.arrowImageView.transform = CGAffineTransform(rotationAngle: 0)
         }
         
    }
}
