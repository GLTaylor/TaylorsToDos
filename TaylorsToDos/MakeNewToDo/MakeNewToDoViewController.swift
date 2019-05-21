import Foundation
import UIKit
import RxSwift
// make textfield an observable and activate button based on it
// make list itself and observable?

class MakeNewToDoViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var toDoTextField: UITextField!
    @IBOutlet var completedSwitch: UISwitch!
    @IBOutlet var addButton: UIButton!

    let bag = DisposeBag()
    
 
    var viewModel: MakeNewToDoViewModel!
    var mainToDosDatabase: ToDosDataBase? {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        return delegate?.allToDosDataBase
    }
    
    override func viewDidLoad() {
         super.viewDidLoad()
            toDoTextField.delegate = self
            addButton.isUserInteractionEnabled = false
         viewModel = MakeNewToDoViewModel(database: mainToDosDatabase ?? ToDosDataBase())
    }
    
    @IBAction func addThisToDo(_sender: UIButton) {
        let text = toDoTextField.text
        let completed = completedSwitch.isOn
        viewModel.addNewToDo(textOfToDo: text!, completedState: completed)
        navigationController?.popViewController(animated: true)

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = (toDoTextField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if !text.isEmpty{
            addButton.isUserInteractionEnabled = true
        } else {
            addButton.isUserInteractionEnabled = false
        }
        return true
    }
    
}

// put viewModels in prepareForSegue, not initializing inside the ViewController 
