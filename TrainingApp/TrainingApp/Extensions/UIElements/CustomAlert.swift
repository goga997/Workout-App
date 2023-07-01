//
//  CustomAlert.swift
//  TrainingApp
//
//  Created by Grigore on 01.07.2023.
//

import UIKit

class CustomAlert {
    
    private let transparentBackView: UIView = {
       let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()
    
    private let alertView: UIView = {
       let view = UIView()
        view.backgroundColor = .specialBackground
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let scrollView = UIScrollView()
        
    private var mainView: UIView?
    
    private let setsTextField = BrownTextField()
    private let repsTextField = BrownTextField()
    
    func presentCustomAlert(viewController: UIViewController, repsOrTimer: String, completion: @escaping (String, String) -> Void) {
        guard let parrentView = viewController.view else { return }
        mainView = parrentView
        
        scrollView.frame = parrentView.frame
        parrentView.addSubview(scrollView)
        
        transparentBackView.frame = parrentView.frame
        scrollView.addSubview(transparentBackView)
        
        alertView.frame = CGRect(x: 40, y: -420, width: parrentView.frame.width - 80, height: 420)
        scrollView.addSubview(alertView)
        
        //Image
        let sportsmanImage = UIImageView(frame: CGRect(
            x: (alertView.frame.width - alertView.frame.height * 0.4) / 2,
            y: 30,
            width: alertView.frame.height * 0.4,
            height: alertView.frame.height * 0.4))
        sportsmanImage.image = UIImage(named: "sportsmanAlert")
        sportsmanImage.contentMode = .scaleAspectFit
        alertView.addSubview(sportsmanImage)
        
        //Labels
        let editingLabel = UILabel(text: "Editing", font: .robotoMedium22(), textColor: .specialBlack)
        editingLabel.frame = CGRect(x: 10, y: alertView.frame.height * 0.4 + 50, width: alertView.frame.width - 20, height: 25)
        editingLabel.textAlignment = .center
        editingLabel.translatesAutoresizingMaskIntoConstraints = true
        alertView.addSubview(editingLabel)
        
        let setsLabel = UILabel(text: "Sets")
        setsLabel.translatesAutoresizingMaskIntoConstraints = true
        setsLabel.frame = CGRect(x: 30, y: editingLabel.frame.maxY + 10, width: alertView.frame.width - 60, height: 20)
        alertView.addSubview(setsLabel)
        
        //TXFields
        setsTextField.frame = CGRect(x: 20, y: setsLabel.frame.maxY, width: alertView.frame.width - 40, height: 30)
        setsTextField.translatesAutoresizingMaskIntoConstraints = true
        setsTextField.keyboardType = .numberPad
        alertView.addSubview(setsTextField)
        
        let repsLabel = UILabel(text: "Reps")
        repsLabel.translatesAutoresizingMaskIntoConstraints = true
        repsLabel.frame = CGRect(x: 30, y: setsTextField.frame.maxY, width: alertView.frame.width - 60, height: 20)
        alertView.addSubview(repsLabel)
        
        repsTextField.frame = CGRect(x: 20, y: repsLabel.frame.maxY, width: alertView.frame.width - 40, height: 30)
        repsTextField.translatesAutoresizingMaskIntoConstraints = true
        repsTextField.keyboardType = .numberPad
        alertView.addSubview(repsTextField)
        
        //Button
        let okButton = GreenButton(text: "OK")
        okButton.frame = CGRect(x: 50, y: repsTextField.frame.maxY + 15, width: alertView.frame.width - 100, height: 35)
        okButton.translatesAutoresizingMaskIntoConstraints = true
        okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        alertView.addSubview(okButton)
        
        
        //Animation
        UIView.animate(withDuration: 0.3) {
            self.transparentBackView.alpha = 0.5
        } completion: { done in
            if done {
                UIView.animate(withDuration: 0.3) {
                    self.alertView.center = parrentView.center
                }
            }
        }

    }
    
    @objc private func okButtonTapped() {
        guard let setsNumber = setsTextField.text, let repsNumber = repsTextField.text else { return }
        guard let targetView = mainView else { return }
        
        UIView.animate(withDuration: 0.3) {
            self.alertView.frame = CGRect(x: 40, y: targetView.frame.height, width: targetView.frame.width - 80, height: 420)
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.transparentBackView.alpha = 0
            } completion: { done in
                if done {
                    self.alertView.removeFromSuperview()
                    self.transparentBackView.removeFromSuperview()
                    self.scrollView.removeFromSuperview()
                }
            }

        }

    }
}


