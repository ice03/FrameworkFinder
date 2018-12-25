//
//  APIService.swift
//  FrameworkFinder
//
//  Created by Admin on 18.12.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import RxSwift

protocol SearchApiService: class {
    
    var page: Int { get set }
    
    // MARK: Get Repositories by url
    func getRepos(urlString: String) -> Observable<[Repo]>
    
}
