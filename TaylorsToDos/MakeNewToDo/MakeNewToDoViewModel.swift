//
//  MakeNewToDoViewModel.swift
//  TaylorsToDos
//
//  Created by Taylor Lindsay on 2/25/19.
//  Copyright © 2019 Taylor Lindsay at Babbel. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

protocol MakeNewToDoViewModelType {
    // inputs
    var textInput: PublishSubject<String?> { get }
    var isOnInput: PublishSubject<Bool> { get }
    var buttonTappedInput: PublishSubject<Void> { get }
    // output
    var whatIsTheText: Driver<String?> { get }
    var isButtonEnabled: Driver<Bool> { get }
    var isTaskCompleted: Driver<Bool> { get }
    var toDoWasMade: Driver<Void> { get}
}


class MakeNewToDoViewModel: MakeNewToDoViewModelType {
    private let bag = DisposeBag()
    private let db: ToDosDataBase

    // input
    let textInput = PublishSubject<String?>()
    let isOnInput = PublishSubject<Bool>()
    let buttonTappedInput = PublishSubject<Void>()

    // output

    let whatIsTheText: Driver<String?>
    let isButtonEnabled: Driver<Bool>
    let isTaskCompleted: Driver<Bool>
    let toDoWasMade: Driver<Void>

    init(database: ToDosDataBase) {
        self.db = database
        isButtonEnabled = textInput.asObservable()
            .map({ (text) -> Bool in
            !(text?.isEmpty ?? true)})
            .startWith(false)
            .asDriver(onErrorDriveWith: .never())

        whatIsTheText = textInput.asObservable()
            .asDriver(onErrorDriveWith: .never())

        isTaskCompleted = isOnInput.asObservable()
            .startWith(false)
            .asDriver(onErrorDriveWith: .never())

        let latest = Observable.combineLatest( whatIsTheText.asObservable(),
                                               isTaskCompleted.asObservable())
        
        toDoWasMade = buttonTappedInput.withLatestFrom(latest)
            .map({[db] (text, isOn) -> Void in
                db.addToDoToData(newToDo: ToDo(title: text ?? "", completed: isOn))
            })
            .asDriver(onErrorDriveWith: .never())

    }

    var mainToDosDatabase: ToDosDataBase? {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        return delegate?.allToDosDataBase
    }

//    var toDoInQuestion: ToDo?
//    var shouldButtonBeEnabled: Observable<Bool>

//    struct Input {
//        let text: Observable<String>
//        let isCompleted: Observable<Bool>
//        let validate: ControlEvent<Void>
//    }

//    func transformInputsToItem(input: Input) {
//
////        .withLatestFrom?
//        // can I mix in a control event?
//        let todo = Observable.combineLatest(input.text, input.isCompleted)
//        input.validate.withLatestFrom(todo).subscribe(onNext: { [db] text, isOn in
//            db.addToDoToData(newToDo: ToDo(title: text, completed: isOn))
//        }).disposed(by: bag)
//
//        input.text.map { (text) -> Bool in
//            !text.isEmpty
//        }
//    }

    
//    func addNewToDo() {
//        if let newToDo = self.toDoInQuestion {
//        db.addToDoToData(newToDo: newToDo)
//        }
//    }
}
