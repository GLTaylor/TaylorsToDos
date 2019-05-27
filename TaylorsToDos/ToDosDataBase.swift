import Foundation
import RxSwift


class ToDosDataBase: ToDosDataBaseProtocol {
    internal var rxswiftToDos = Variable<[ToDo]>([])

    func readAll(completionHandler: @escaping ([ToDo]?, Error?) -> Void) {
        var task: URLSessionTask?
        guard let path = URL(string: "https://raw.githubusercontent.com/GLTaylor/TaylorsToDos/develop/db.json") else { return }
        task?.cancel()
        task = URLSession.shared.dataTask(with: path) { data, _, error in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            let decoder = JSONDecoder()
            do {
                let toDosFromTheWeb = try decoder.decode([ToDo].self, from: data)
                self.rxswiftToDos.value = toDosFromTheWeb
                completionHandler(toDosFromTheWeb, nil)
            } catch {
                completionHandler(nil, error)
            }
        }
        task!.resume()
    }

    func addToDoToData(newToDo: ToDo) {
        rxswiftToDos.value.append(newToDo)
    }
    
    func removeToDoData(byeToDoIndex: Int) {
        rxswiftToDos.value.remove(at: byeToDoIndex)
    }
    
}

protocol ToDosDataBaseProtocol {
    var rxswiftToDos: Variable<[ToDo]> { get }

    func readAll(completionHandler: @escaping ([ToDo]?, Error?) -> Void)
    func addToDoToData(newToDo: ToDo)
    func removeToDoData(byeToDoIndex: Int)
    
}
