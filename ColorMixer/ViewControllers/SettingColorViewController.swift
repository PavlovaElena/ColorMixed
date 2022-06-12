//
//  SettingColorViewController.swift
//  ColorMixer
//
//  Created by Елена Павлова on 28.05.2022.
//

import UIKit

class SettingColorViewController: UIViewController {
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    @IBOutlet weak var colorView: UIView!
    
    var currentColor: UIColor!
    
    var delegate: SettingColorViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 10
        
        arrangeSliders(by: currentColor)
        setViewColor()
        
        setCurrentValue(for: redValueLabel, greenValueLabel, blueValueLabel)
        setCurrentValue(for: redTextField, greenTextField, blueTextField)
    }
    
    @IBAction func changeSliderValue(_ sender: UISlider) {
        switch sender {
        case redSlider:
            setCurrentValue(for: redValueLabel)
            setCurrentValue(for: redTextField)
        case greenSlider:
            setCurrentValue(for: greenValueLabel)
            setCurrentValue(for: greenTextField)
        default:
            setCurrentValue(for: blueValueLabel)
            setCurrentValue(for: blueTextField)
        }
        
        setViewColor()
    }
    
    @IBAction func doneButtonPressed() {
        guard let newColor = colorView.backgroundColor else { return }
        delegate.setNewColor(with: newColor)
        dismiss(animated: true)
    }
    
    private func arrangeSliders(by color: UIColor) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        redSlider.value = Float(red)
        greenSlider.value = Float(green)
        blueSlider.value = Float(blue)
    }
    
    
    private func setViewColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func setCurrentValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redValueLabel:
                redValueLabel.text = String(format: "%0.2f", redSlider.value)
            case greenValueLabel:
                greenValueLabel.text = String(format: "%0.2f", greenSlider.value)
            default:
                blueValueLabel.text = String(format: "%0.2f", blueSlider.value)
            }
        }
    }
    
    private func setCurrentValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTextField:
                redTextField.text = String(format: "%0.2f", redSlider.value)
            case greenTextField:
                greenTextField.text = String(format: "%0.2f", greenSlider.value)
            default:
                blueTextField.text = String(format: "%0.2f", blueSlider.value)
            }
        }
    }
}
