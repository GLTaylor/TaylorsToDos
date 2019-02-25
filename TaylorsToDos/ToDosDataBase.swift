//
//  ToDosDataBase.swift
//  TaylorsToDos
//
//  Created by Taylor Lindsay on 2/22/19.
//  Copyright © 2019 Taylor Lindsay at Babbel. All rights reserved.
//

import Foundation


class ToDosDataBase: ToDosDataBaseProtocol {
    internal var dataToDos: [ToDo] = [ToDo(title: "dummy", completed: false), ToDo(title: "dummy1", completed: true), ToDo(title: "dummyAgain", completed: false)]
    
    func readAll(completionHandler: @escaping ([ToDo]?, Error?) -> Void) {
        completionHandler(dataToDos, nil)
    }
    
    func addToDoToData(newToDo: ToDo) {
        dataToDos.append(newToDo)
        print("A new To do was added!")
    }
}

protocol ToDosDataBaseProtocol {
    var dataToDos: [ToDo] {get set}
    
    func readAll(completionHandler: @escaping ([ToDo]?, Error?) -> Void)
    func addToDoToData(newToDo: ToDo)
    
}
