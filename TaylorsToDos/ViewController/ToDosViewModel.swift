//
//  ToDosViewModel.swift
//  TaylorsToDos
//
//  Created by Taylor Lindsay on 2/22/19.
//  Copyright © 2019 Taylor Lindsay at Babbel. All rights reserved.
//

import Foundation

class ToDosViewModel {
    var delegate: ToDosViewModelDelegate?
    var countToDos: Int = 0 
    private var array: [ToDo] = [] {
        didSet {
            self.countToDos = array.count
            self.delegate?.arrayToUse = array
        }
    }
    private let db: ToDosDataBase
 
    init(database: ToDosDataBase) {
        self.db = database
    }
    
    func start() {
        db.readAll { (data, error) in
            guard let data = data else {
                return
            }
            self.array = data
            self.delegate?.dataIsReady()
            print(self.array)
        }
    }
    
}

protocol ToDosViewModelDelegate {
    var arrayToUse: [ToDo] {get set}
    func dataIsReady()
}

