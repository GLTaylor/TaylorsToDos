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
    private var array: [ToDo] = [] {
        didSet {
            self.delegate?.arrayToUse = array
        }
    }
    private let db: ToDosDataBaseProtocol
 
    init(database: ToDosDataBaseProtocol) {
        self.db = database
    }
    
    func start() {
        db.readAll { (data, error) in
            guard let data = data else {
                return
            }
            self.array = data
            self.delegate?.dataIsReady()
        }
    }
    
    func deleteToDo(toDoToDeleteIndex: Int) {
        self.array.remove(at: toDoToDeleteIndex)
        db.removeToDoData(byeToDoIndex: toDoToDeleteIndex)
    }
    
}

protocol ToDosViewModelDelegate {
    var arrayToUse: [ToDo] {get set}
    func dataIsReady()
}

