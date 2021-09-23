//
//  BookViewModel.swift
//  Test
//
//  Created by austin vigo on 8/23/21.
//

import Foundation
import RxSwift

class BooksViewModel {
    
    var books = PublishSubject<[BookModel]>()
    
    func fetchItems() {
        do {
            if let bundlePath = Bundle.main.path(forResource: "books", ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                
                let decodedData = try JSONDecoder().decode([BookModel].self, from: jsonData)
                
                books.onNext(decodedData)
                books.onCompleted()
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
