//
//  APIService.swift
//  FrameworkFinder
//
//  Created by Admin on 18.12.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import RxSwift
import Kingfisher

class SearchApiSrv: SearchApiService {
    
    var page = 0
    
    private var searchRepos = [Repo]()
    
    func getRepos(urlString: String) -> Observable<[Repo]> {
        var currentUrlString = urlString
        if page != 0 {
            currentUrlString += "&page=\(page)"
        }
        guard let url = URL(string: currentUrlString) else { return Observable<[Repo]>.just([]) }
        
        return URLSession.shared.rx.data(request: URLRequest(url: url))
            .map { [unowned self] data in
                if let results = try? JSONDecoder().decode(RepoRaw.self, from: data) {
                    var urls = [URL]()
                    self.searchRepos = []
                    
                    results.items.forEach({
                        if let language = $0.language {
                            let repo = Repo(imageUrl: $0.owner.avatarURL, name: $0.name, description: $0.description, numberOfForks: $0.forksCount, language: language, numberOfContributors: 0, repoUrl: $0.htmlURL)
                            
                            urls.append(URL(string: $0.owner.avatarURL)!)
                            self.searchRepos.append(repo)
                        }
                    })
                    
                    // Prefetch all images to memory
                    ImagePrefetcher(urls: urls).start()
                    
                    // Return result
                    return self.searchRepos
                } else {
                    
                    // Return previous result
                    return self.searchRepos
                }
            }
            .catchErrorJustReturn(self.searchRepos)
    }
}
