//
//  UINormalRefreshFooterView.swift
//  Live
//
//  Created by jqy on 2020/5/29.
//  Copyright © 2020 J丶QY. All rights reserved.
//

import UIKit

class UINormalRefreshFooterView: RefreshFooterView {

    private let refreshActivityIndicatorView = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.medium)
    private let loadingView = UIView()
    private let controlButton = UIButton()
    override func setViews() {
        super.setViews()
        self.addSubview(loadingView)
        loadingView.addSubview(refreshActivityIndicatorView)
        let refreshLabel = UILabel()
        refreshLabel.text = "加载中..."
        refreshLabel.textColor = .gray
        refreshLabel.font = UIFont.systemFont(ofSize: 15)
        loadingView.addSubview(refreshLabel)
        loadingView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        refreshLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.centerX.equalTo(self).offset(10)
        }
        refreshActivityIndicatorView.snp.makeConstraints { (make) in
            make.right.equalTo(refreshLabel.snp.left).offset(-8)
            make.centerY.equalTo(refreshLabel)
            make.width.height.equalTo(13)
        }
        controlButton.addTarget(self, action: #selector(beginRefresh), for: UIControl.Event.touchUpInside)
        controlButton.setTitleColor(.gray, for: UIControl.State.normal)
        controlButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(controlButton)
        controlButton.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    @objc override func beginRefresh() {
        super.beginRefresh()
        self.controlButton.isHidden = true
        refreshActivityIndicatorView.startAnimating()
        self.loadingView.isHidden = false
        self.refreshingCallAction()
    }
    
    override func endRefresh() {
        super.endRefresh()
        refreshActivityIndicatorView.stopAnimating()
        self.loadingView.isHidden = true
        controlButton.setTitle("点击或上拉加载更多", for: UIControl.State.normal)
        self.controlButton.isEnabled = true
        self.controlButton.isHidden = false
    }
    
    override func setRefreshStateIsNoMoreData() {
        super.setRefreshStateIsNoMoreData()
        self.loadingView.isHidden = true
        self.controlButton.isEnabled = false
        self.controlButton.setTitle("没有更多数据了", for: UIControl.State.normal)
        self.controlButton.isHidden = false
    }
}
