//
//  Repo.swift
//  FrameworkFinder
//
//  Created by Admin on 16.12.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

class Repo {
    public private(set) var imageUrl: String
    public private(set) var name: String
    public private(set) var description: String
    public private(set) var numberOfForks: Int
    public private(set) var language: String
    public private(set) var numberOfContributors: Int
    public private(set) var repoUrl: String
    
    init(imageUrl: String, name: String, description: String, numberOfForks: Int, language: String, numberOfContributors: Int, repoUrl: String) {
        self.imageUrl = imageUrl
        self.name = name
        self.description = description
        self.numberOfForks = numberOfForks
        self.language = language
        self.numberOfContributors = numberOfContributors
        self.repoUrl = repoUrl
    }
    
}
