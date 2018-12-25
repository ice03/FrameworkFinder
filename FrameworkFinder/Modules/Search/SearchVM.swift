//
//  SearchVM.swift
//  FrameworkFinder
//
//  Created by Admin on 18.12.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import RxSwift

class SearchVM {
    
    // MARK: Current api service
    let searchApiService: SearchApiService
    
    // MARK: Rx Bindings & DisposeBag
    var disposeBag = DisposeBag()
    let searchText = BehaviorSubject<String>(value: "")
    let repos = PublishSubject<[Repo]>()
    
    init(searchApiService: SearchApiService) {
        self.searchApiService = searchApiService
        initRepos()
    }
    
    // MARK: Initialization subscription for [Repo]
    func initRepos() {
        searchText
            .map {
                $0.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
            }
            .subscribe(onNext: { [unowned self] query in
                if query == "" {
                    self.repos.onNext([])
                } else {
                    let urlString = searchUrl + query + starsDescendingSegment
                    
                    self.searchApiService.getRepos(urlString: urlString)
                        .observeOn(MainScheduler.instance)
                        .subscribe(onNext: { [unowned self] repos in
                            self.repos.onNext(repos)
                        })
                        .disposed(by: self.disposeBag)
                }
            })
            .disposed(by: disposeBag)
    }
    
}
