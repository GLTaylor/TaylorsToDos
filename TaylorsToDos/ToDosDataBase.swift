import Foundation


class ToDosDataBase: ToDosDataBaseProtocol {
    private(set) var dataToDos = [ToDo]()
    
    func readAll(completionHandler: @escaping ([ToDo]?, Error?) -> Void) {
        var task: URLSessionTask?
        guard let path = URL(string: "https://jsonplaceholder.typicode.com/todos") else { return }
        task?.cancel()
        task = URLSession.shared.dataTask(with: path) { data, _, error in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            let decoder = JSONDecoder()
            do {
                let toDosFromTheWeb = try decoder.decode([ToDo].self, from: data)
                self.dataToDos = toDosFromTheWeb
                completionHandler(toDosFromTheWeb, nil)
            } catch {
                completionHandler(nil, error)
            }
        }
        task!.resume()
    }
    
    func addToDoToData(newToDo: ToDo) {
        dataToDos.append(newToDo)
        print("A new To do was added!")
    }
    
    func removeToDoData(byeToDoIndex: Int) {
        dataToDos.remove(at: byeToDoIndex)
        print("A To Do was removed")
    }
    
}

protocol ToDosDataBaseProtocol {
    var dataToDos: [ToDo] { get }
    
    func readAll(completionHandler: @escaping ([ToDo]?, Error?) -> Void)
    func addToDoToData(newToDo: ToDo)
    func removeToDoData(byeToDoIndex: Int)
    
}
