import Foundation
import RxSwift
import RxCocoa


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

class ToDosViewModel: ToDosViewModelType {
    weak var delegate: ToDosViewModelDelegate?
    var cellIdentifier: String
    var array: [ToDo] = [] {
        didSet {
            self.delegate?.arrayToUse = array
        }
    }
    let bag = DisposeBag()
    var db: ToDosDataBaseProtocol

    init(database: ToDosDataBaseProtocol) {
        self.db = database
        cellIdentifier = "CellData"
    }
    
    func start() {
        db.rxswiftToDos.asObservable().subscribe(onNext: {[weak self] todos in
            self?.array = todos
        }).disposed(by: bag)
        self.delegate?.dataIsReady()
    }
    
    func deleteToDo(toDoToDeleteIndex: Int) {
        self.array.remove(at: toDoToDeleteIndex)
        db.removeToDoData(byeToDoIndex: toDoToDeleteIndex)
    }
    
}


