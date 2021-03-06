//
//  MindStoreDetailController.swift
//  ifanr
//
//  Created by 梁亦明 on 16/8/6.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit

class MindStoreDetailController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.view.addSubview(tableView)
        self.view.addSubview(headerBack)
        setupLayout()
        
        getNormalData()
    }
    
    convenience init(headerModel: MindStoreModel) {
        self.init()
        self.headerModel = headerModel
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    //MARK: --------------------------- Private Methods --------------------------
    private func getNormalData() {
        isRefreshing = true
        
        let group = dispatch_group_create()
        dispatch_group_enter(group)
        
//        IFanrService.shareInstance.getMindStoreVotedData(headerModel.id, successHandle: { [unowned self](voteModelArray) in
//            self.voteModelArray = voteModelArray
//            }, errorHandle: <#T##((Error) -> Void)?##((Error) -> Void)?##(Error) -> Void#>)
//        
//        page = 1
//        dispatch_group_enter(group)
//        IFanrService.shareInstance.getLatestLayout(APIConstant.Home_latest(page), successHandle: { [unowned self](layoutArray) in
//            self.latestCellLayout.removeAll()
//            layoutArray.forEach {
//                self.latestCellLayout.append($0)
//            }
//            dispatch_group_leave(group)
//            }, errorHandle: { (error) in
//                print(error)
//                self.pullToRefresh.endRefresh()
//                self.latestDataError = error
//        })
//        
//        dispatch_group_notify(group, dispatch_get_main_queue()) {
//            if self.hotDataError == nil && self.latestDataError == nil {
//                self.tableHeaderView.modelArray = self.headerModelArray
//                self.tableView.reloadData()
//                // 请求成功让page+1
//                self.page+=1
//            } else {
//                // 这里处理网络出现问题
//                self.pullToRefresh.endRefresh()
//            }
//            
//            self.isRefreshing = false
//            self.pullToRefresh.endRefresh()
//        }
    }

    private func setupLayout() {
        headerBack.snp_makeConstraints { (make) in
            make.left.top.right.equalTo(self.view)
            make.height.equalTo(50)
        }
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    //MARK: --------------------------- Getter and Setter --------------------------
    private var headerModel: MindStoreModel!
    private var voteModelArray = [MindStoreVoteModel]()
    private var commentModelArray = [MindStoreVoteModel]()
    
    private var offset = 1
    private var isRefreshing: Bool = true
    /// 上拉加载更多触发零界点
    var happenY: CGFloat = UIConstant.SCREEN_HEIGHT+20
    var differY: CGFloat = 0

    /// 顶部返回栏
    private lazy var headerBack: HeaderBackView = {
        let headerBack: HeaderBackView = HeaderBackView(title: "MindStore")
        headerBack.delegate = self
        return headerBack
    }()
    
    /// tableview
    private lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.separatorStyle = .None
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionFooterHeight = 50
        tableView.tableFooterView = self.pullToRefreshFootView()
        tableView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        return tableView
    }()
}

extension MindStoreDetailController {
    private func pullToRefreshFootView() -> UIView {
        
        let activityView = ActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 25, height: 25) )
        activityView.color = UIConstant.UI_COLOR_GrayTheme
        activityView.center = CGPoint(x: self.view.center.x, y: 25)
        activityView.startAnimation()
        let footView = UIView()
        footView.origin = CGPointZero
        footView.size = CGSize(width: 50, height: 50)
        footView.addSubview(activityView)
        return footView
    }
}

extension MindStoreDetailController: HeaderViewDelegate {
    func backButtonDidClick() {
        self.navigationController?.popViewControllerAnimated(true)
    }
}

extension MindStoreDetailController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = MindStoreTableViewCell.cellWithTableView(tableView)
        cell.model = headerModel
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return MindStoreTableViewCell.estimateCellHeight(headerModel.title!, tagline: headerModel.tagline)
    }
}