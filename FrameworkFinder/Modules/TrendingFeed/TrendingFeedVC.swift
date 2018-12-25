//
//  TrendingFeedVC.swift
//  FrameworkFinder
//
//  Created by Admin on 16.12.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class TrendingFeedVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    
    var trendingFeedViewModel: TrendingFeedVM!
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchApiService = SearchApiSrv()
        trendingFeedViewModel = TrendingFeedVM(searchApiService: searchApiService)
        configureRefreshControl()
        
        bindTrendingFeedElements()
        trendingFeedViewModel.downloadTrigger.onNext(())
    }
    
    // MARK: Configuration refresh control
    func configureRefreshControl() {
        tableView.refreshControl = refreshControl
        
        refreshControl.tintColor = #colorLiteral(red: 0.3442408442, green: 0.5524554849, blue: 0.9224796891, alpha: 1)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching hot Github Repos ♛", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.3442408442, green: 0.5524554849, blue: 0.9224796891, alpha: 1), NSAttributedString.Key.font: UIFont(name: "AvenirNext-DemiBold", size: 16)])
    }
    
    // MARK: Element bindings configuration
    func bindTrendingFeedElements() {
        trendingFeedViewModel.repos
            .bind(to: tableView.rx.items(cellIdentifier: "trendingRepoCell")) { [unowned self] (row, repo: Repo, cell: TrendingRepoCell) in
                cell.configureCell(repo: repo)
                if self.refreshControl.isRefreshing {
                    self.refreshControl.endRefreshing()
                }
            }
            .disposed(by: disposeBag)
        
        refreshControl.rx.controlEvent(.valueChanged)
            .bind(to: trendingFeedViewModel.downloadTrigger)
            .disposed(by: disposeBag)
    }
    
}
