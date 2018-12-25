//
//  TrendingFeedVM.swift
//  FrameworkFinder
//
//  Created by Admin on 19.12.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import RxSwift

class TrendingFeedVM {
    
    // MARK: Current api service
    let searchApiService: SearchApiService
    
    // MARK: Rx Bindings & DisposeBag
    var disposeBag = DisposeBag()
    let downloadTrigger = PublishSubject<Void>()
    let repos = PublishSubject<[Repo]>()
    
    init(searchApiService: SearchApiService) {
        self.searchApiService = searchApiService
        initRepos()
    }
    
    // MARK: Initialization subscription for [Repo]
    func initRepos() {
        downloadTrigger
            .subscribe(onNext: { [unowned self] in
                let urlString = trendingRepoUrl
                self.searchApiService.page += 1
                
                self.searchApiService.getRepos(urlString: urlString)
                    .observeOn(MainScheduler.instance)
                    .subscribe(onNext: { [unowned self] repos in
                        self.repos.onNext(repos)
                    })
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
    }
    
}
