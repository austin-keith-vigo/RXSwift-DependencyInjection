//
//  RootViewController.swift
//  RxSwift+DependencyInjection
//
//  Created by Vigo, Austin on 9/23/21.
//

import UIKit

class RootViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let cellId = TitleDescriptionTableViewCell.cellId
    
    var booksVM: BooksViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        
        self.booksVM = BooksViewModel()
        self.booksVM.data.bind { _ in
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        booksVM?.fetchData()
    }
}

extension RootViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let booksVM = self.booksVM else { return 0 }
        return booksVM.data.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TitleDescriptionTableViewCell
        
        if let book = booksVM.data.value?[indexPath.row] {
            cell.setup(title: book.title, descr: book.author)
        } else {
            cell.setup(title: "", descr: "")
        }
        
        return cell
    }
}
