//
//  BrownTextField.swift
//  TrainingApp
//
//  Created by Grigore on 17.06.2023.
//

import UIKit

protocol BrownTextFieldProtocol: AnyObject {
    func typing(range: NSRange, replacementString: String)
    func clear()
}

class BrownTextField: UITextField {
    
    weak var brownTextFiealDelegate: BrownTextFieldProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.backgroundColor = .specialBrown
        self.layer.cornerRadius = 10
        self.textColor = .specialGray
        self.font = .robotoBold20()
        
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        self.leftViewMode = .always
        self.clearButtonMode = .always
        self.returnKeyType = .done
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension BrownTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        brownTextFiealDelegate?.typing(range: range, replacementString: string)
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        brownTextFiealDelegate?.clear()
        return true
    }
}


