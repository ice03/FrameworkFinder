//
//  SearchVC.swift
//  FrameworkFinder
//
//  Created by Admin on 16.12.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchField: RoundedBorderTxtField!
    
    var searchViewModel: SearchVM!
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchApiService = SearchApiSrv()
        searchViewModel = SearchVM(searchApiService: searchApiService)
        bindSearchElements()
    }
    
    // MARK: Element bindings configuration
    func bindSearchElements() {
        searchField.rx.text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .bind(to: searchViewModel.searchText)
            .disposed(by: disposeBag)
        
        searchViewModel.repos
            .bind(to: tableView.rx.items(cellIdentifier: "searchCell")) { (row, repo: Repo, cell: SearchCell) in
                cell.configureCell(repo: repo)
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Repo.self)
            .subscribe(onNext: { [unowned self] in
                self.presentSafariVC(url: $0.repoUrl)
            })
            .disposed(by: disposeBag)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
