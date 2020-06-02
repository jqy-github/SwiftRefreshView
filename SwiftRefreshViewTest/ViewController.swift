//
//  ViewController.swift
//  SwiftRefreshViewTest
//
//  Created by jqy on 2020/6/2.
//  Copyright © 2020 J丶QY. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDataSource{
   
    var count = 0
    let mainTableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.dataSource = self;
        mainTableView.tableFooterView = UIView()
        self.view = mainTableView
        
//        mainTableView.footerRefreshView = UINormalRefreshFooterView.init(refreshCallBack: {
//            [unowned self] in
//            self.refresh()
//        })
        mainTableView.footerRefreshView = UINormalRefreshFooterView.init(addTarget: self, action: #selector(refresh))
        
        mainTableView.headerRefreshView = UINormalRefreshHeaderView.init(refreshCallBack: {
            [unowned self] in
            self.refresh()
        })
//        mainTableView.headerRefreshView = UINormalRefreshHeaderView.init(addTarget: self, action: #selector(refresh))
        
        mainTableView.headerRefreshView?.beginRefresh()
      //  mainTableView.footerRefreshView?.beginRefresh()
    }

    @objc func refresh() {
        self.perform(#selector(self.loadData), with: nil, afterDelay: 2.0)
    }
    @objc func loadData() {
        if mainTableView.headerRefreshView?.state == .refreshing {
            count = 5
        }
        if mainTableView.footerRefreshView?.state == .refreshing {
            count += 5
        }
       mainTableView.reloadData()
       self.mainTableView.footerRefreshView?.endRefresh()
       self.mainTableView.headerRefreshView?.endRefresh()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell.init()
    }
}

