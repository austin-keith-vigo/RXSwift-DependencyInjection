//
//  TitleDescriptionTableViewCell.swift
//  RxSwift+DependencyInjection
//
//  Created by Vigo, Austin on 9/23/21.
//

import UIKit

class TitleDescriptionTableViewCell: UITableViewCell {
    
    static let cellId: String = "TitleDescriptionTableViewCell"
    
    var title: String!
    var descr: String!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descrLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }
    
    func setup(title: String, descr: String) {
        self.title = title
        self.descr = descr
        
        self.titleLabel.text = title
        self.descrLabel.text = descr
    }
}
