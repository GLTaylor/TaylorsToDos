//
//  ToDosViewModel.swift
//  TaylorsToDos
//
//  Created by Taylor Lindsay on 2/22/19.
//  Copyright © 2019 Taylor Lindsay at Babbel. All rights reserved.
//

import Foundation

class ToDosViewModel: ToDosViewModelType {
    weak var delegate: ToDosViewModelDelegate?
    var cellIdentifier: String
    var array: [ToDo] = [] {
        didSet {
            self.delegate?.arrayToUse = array
        }
    }
    var db: ToDosDataBaseProtocol
 
    init(database: ToDosDataBaseProtocol) {
        self.db = database
        cellIdentifier = "CellData"
    }
    
    func start() {
        self.array =  db.dataToDos
        self.delegate?.dataIsReady()
    }
    
    func deleteToDo(toDoToDeleteIndex: Int) {
        self.array.remove(at: toDoToDeleteIndex)
        db.removeToDoData(byeToDoIndex: toDoToDeleteIndex)
    }
    
}

protocol ToDosViewModelDelegate: class {
    var arrayToUse: [ToDo] {get set}
    func dataIsReady()
}

protocol ToDosViewModelType: class {
    var array: [ToDo] { get set }
    var db: ToDosDataBaseProtocol { get set }
    func start()
    func deleteToDo(toDoToDeleteIndex: Int)
}
