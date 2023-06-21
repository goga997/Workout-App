//
//  SliderView.swift
//  TrainingApp
//
//  Created by Grigore on 18.06.2023.
//

import UIKit

protocol SliderViewProtoc: AnyObject {
    func changeValue(type: SliderTypes, value: Int)
}

class SliderView: UIView {
    
    private let nameLabel = UILabel(text: "Name",
                                    font: .robotoMedium18(),
                                    textColor: .specialGray)
    
    private let numberLabel = UILabel(text: "0",
                                      font: .robotoMedium24(),
                                      textColor: .specialGray)
    
    private lazy var slider = GreenSlider()
    
    private var stackView = UIStackView()
    
    //logic properties ->
    public var sliderType: SliderTypes?
    
    weak var delegate: SliderViewProtoc?
    
    public var isActive: Bool = true {
        didSet
        {
            if self.isActive {
                self.nameLabel.alpha = 1
                self.numberLabel.alpha = 1
                self.slider.alpha = 1
            } else {
                self.nameLabel.alpha = 0.5
                self.numberLabel.alpha = 0.5
                self.slider.alpha = 0.5
                self.numberLabel.text = "0"
                self.slider.value = 0
            }
        }
    }
    
    //MARK: - INITIALIZATION + setupViews
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(name: String, minValue: Float, maxValue: Float, type: SliderTypes) {
        self.init(frame: .zero)
        self.nameLabel.text = name
        self.slider.minimumValue = minValue
        self.slider.maximumValue = maxValue
        self.sliderType = type
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        
        let labelsStackView = UIStackView(arrangedSubviews: [nameLabel, numberLabel],
                                          axis: .horizontal,
                                          spacing: 10)
        labelsStackView.distribution = .equalSpacing
        stackView = UIStackView(arrangedSubviews: [labelsStackView, slider],
                                axis: .vertical,
                                spacing: 10)
        addSubview(stackView)
    }
    
    //Slider functionality
    @objc private func sliderValueChanged() {
        let intSliderValue = Int(slider.value)
        numberLabel.text = sliderType == .timer ? intSliderValue.getTimeFromSeconds() : "\(intSliderValue)"
        //        if sliderTypes == .timer {
        //            numberLabel.text = intSliderValue.getTimeFromSeconds()
        //        } else {
        //            numberLabel.text = "\(intSliderValue)"
        //        }
        
        guard let type = sliderType else {return}
        delegate?.changeValue(type: type, value: intSliderValue)
    }
    
    public func modifySliderWhenSaved() { //function get called from RepsOrTimerView
        numberLabel.text = "0"
        slider.value = 0
        isActive = true
    }
}

//MARK: - Set Constraints

extension SliderView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
}
 
