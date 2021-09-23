//
//  RootViewController.swift
//  RxSwift+DependencyInjection
//
//  Created by Vigo, Austin on 9/23/21.
//

import UIKit
import RxSwift
import RxCocoa

class RootViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let cellId = TitleDescriptionTableViewCell.cellId
    
    private var viewModel = BooksViewModel()
    private var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        self.bindTableData()
    }
    
    func bindTableData() {
        
        //Bind items to table
        viewModel.books
            .bind(to: tableView.rx.items(cellIdentifier: cellId,  cellType: TitleDescriptionTableViewCell.self)) { row, model, cell in
                cell.setup(title: model.title, descr: model.author)
            }
            .disposed(by: bag)
        
        // fetch items
        viewModel.fetchItems()
    }
}
