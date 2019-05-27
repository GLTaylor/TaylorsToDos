import Foundation
import UIKit
import RxSwift
import RxCocoa


class MakeNewToDoViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var toDoTextField: UITextField!
    @IBOutlet var completedSwitch: UISwitch!
    @IBOutlet var addButton: UIButton!

    private let bag = DisposeBag()
 
    var viewModel: MakeNewToDoViewModelType!
    var mainToDosDatabase: ToDosDataBase? {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        return delegate?.allToDosDataBase
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MakeNewToDoViewModel(database: mainToDosDatabase ?? ToDosDataBase())
        bindInputs()
        bindOutputs()
    }

    func bindInputs() {
        toDoTextField.rx.text
            .bind(to: viewModel.textInput)
            .disposed(by: bag)

         completedSwitch.rx.isOn
            .bind(to: viewModel.isOnInput)
            .disposed(by: bag)

        addButton.rx.tap
            .bind(to: viewModel.buttonTappedInput)
            .disposed(by: bag)
    }


    func bindOutputs() {
        viewModel.isButtonEnabled
            .drive(onNext: { isEnabled in
            self.addButton.isEnabled = isEnabled
        }).disposed(by: bag)

        viewModel.toDoWasMade
            .drive(onNext: {_ in
            self.navigationController?.popViewController(animated: true)
        }).disposed(by: bag)
    }

}


