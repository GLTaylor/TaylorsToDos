//
//  TaylorsToDosTests.swift
//  TaylorsToDosTests
//
//  Created by Taylor Lindsay on 2/21/19.
//  Copyright © 2019 Taylor Lindsay at Babbel. All rights reserved.
//

import XCTest
@testable import TaylorsToDos

class TaylorsToDosTests: XCTestCase {
    
    var sut: ToDosViewModel!
    var dataMock: ToDosDataBaseMock!

    override func setUp() {
        dataMock = ToDosDataBaseMock()
        sut = ToDosViewModel(database: dataMock)
    }

    override func tearDown() {
        sut = nil
        dataMock = nil
    }

    func testToDosAppear() {
        // given
        sut.start()
        // when app is started up
        XCTAssertTrue(dataMock.dataToDos.count == 3)
        // then threre are three to do's in the database
    }

    func testPerformanceExample() {
        // given
        let toDoFake = ToDo(title: "Fake", completed: true)
//        sut.delegate = ToDosDelegateMock()
        sut.start()
        dataMock.addToDoToData(newToDo: toDoFake)
        // when a new To Do is added
        XCTAssertTrue(dataMock.dataToDos.count == 4)
        // then to do's data is increased by one
    }

    
    func testDelete() {
        //given
        sut.start()
        sut.delegate = ToDosDelegateMock()
        // when a To Do is deleted by a user
        sut.deleteToDo(toDoToDeleteIndex: 0)
        // the list count is updated to not include the deleted to-do
        XCTAssertTrue(sut.array.count == 2)
    }
    
}

class ToDosDataBaseMock: ToDosDataBaseProtocol {
    var dataToDos: [ToDo] = [ToDo(title: "first", completed: false), ToDo(title: "second", completed: true), ToDo(title: "third", completed: false)]
    
    func readAll(completionHandler: @escaping ([ToDo]?, Error?) -> Void) {
        completionHandler(dataToDos, nil)
    }
    
    func addToDoToData(newToDo: ToDo) {
        dataToDos.append(newToDo)
    }
    
    func removeToDoData(byeToDoIndex: Int) {
        dataToDos.remove(at: byeToDoIndex)
    }
}

// Not in use: not sure if it helps.
class ToDosDelegateMock: ToDosViewModelDelegate {
    var db: ToDosDataBaseMock!
    var arrayToUse: [ToDo]
    init() {
        self.db = ToDosDataBaseMock()
        self.arrayToUse = db.dataToDos
    }
    
    
    func dataIsReady() {
        
    }
}
