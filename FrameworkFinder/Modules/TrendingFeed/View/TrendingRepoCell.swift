//
//  TrendingRepoCell.swift
//  FrameworkFinder
//
//  Created by Admin on 16.12.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class TrendingRepoCell: UITableViewCell {
    
    @IBOutlet weak var repoImageView: UIImageView!
    @IBOutlet weak var repoNameLbl: UILabel!
    @IBOutlet weak var repoDescLbl: UILabel!
    @IBOutlet weak var numberOfForks: UILabel!
    @IBOutlet weak var languageLbl: UILabel!
    @IBOutlet weak var contributorsLbl: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var viewReadmeBtn: RoundedBorderBtn!
    
    var disposeBag = DisposeBag()
    
    var repoUrl: String!
    
    override func layoutSubviews() {
        backView.layer.cornerRadius = 15
        backView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        backView.layer.shadowOpacity = 0.25
        backView.layer.shadowRadius = 5
        backView.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    func configureCell(repo: Repo) {
        guard let url = URL(string: repo.imageUrl) else { return }
        repoImageView.kf.setImage(with: url)
        repoNameLbl.text = repo.name
        repoDescLbl.text = repo.description
        numberOfForks.text = String(describing: repo.numberOfForks)
        languageLbl.text = repo.language
        contributorsLbl.text = String(describing: repo.numberOfContributors)
        repoUrl = repo.repoUrl
        
        viewReadmeBtn.rx.tap.subscribe(onNext: {
            self.window?.rootViewController?.presentSafariVC(url: self.repoUrl)
        })
            .disposed(by: disposeBag)
    }
    
}
