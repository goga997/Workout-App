//
//  NameView.swift
//  TrainingApp
//
//  Created by Grigore on 15.06.2023.
//

import UIKit

class NameVIew: UIView {
    
    private let nameLabel = UILabel(text: "Name")
    
    private lazy var textField = BrownTextField()
      
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        backgroundColor = .none
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(nameLabel)
        addSubview(textField)
    }
    
    
    //get acces to the value of the textField
    public func getValueFromTextField() -> String {
        guard let text = textField.text else {return ""}
        return text
    }
    
    //deleting text after succes saving
    public func deleteValueFromTextField() {
        textField.text = ""
    }
        
    private func setConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            nameLabel.heightAnchor.constraint(equalToConstant: 15),
            
            textField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}


