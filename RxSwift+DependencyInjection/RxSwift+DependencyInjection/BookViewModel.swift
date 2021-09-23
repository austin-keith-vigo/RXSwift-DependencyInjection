//
//  BookViewModel.swift
//  Test
//
//  Created by austin vigo on 8/23/21.
//

import Foundation

class Observable<T> {

    var value: T {
        didSet {
            listener?(value)
        }
    }

    private var listener: ((T) -> Void)?

    init(_ value: T) {
        self.value = value
    }

    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}


protocol ObservableViewModelProtocol {
    associatedtype DataType
    func fetchData()
    func setError(_ message: String?)
    var data: Observable<DataType> { get  set } //1
    var errorMessage: Observable<String?> { get set }
    var error: Observable<Bool> { get set }
}

class BooksViewModel: ObservableViewModelProtocol {
    
    
    func fetchData() {
        if let data = readLocalFile(forName: "books") {
            parse(jsonData: data)
            
        }
    }
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    private func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode([BookModel].self,
                                                       from: jsonData)
            
            self.data.value = decodedData

        } catch {
            print("decode error")
        }
    }
    
    func setError(_ message: String?) {
        print("Test")
    }
    
    var data: Observable<[BookModel]?> = Observable(nil)
    var errorMessage: Observable<String?> = Observable(nil)
    var error: Observable<Bool> = Observable(false)
    
}
