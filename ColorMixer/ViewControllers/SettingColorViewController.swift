//
//  SettingColorViewController.swift
//  ColorMixer
//
//  Created by Елена Павлова on 28.05.2022.
//

import UIKit

class SettingColorViewController: UIViewController {
    
    // MARK: - IB Outlets
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
    
    // MARK: - Public Properties
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
    
    // MARK: - IB Actions
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
    
    // MARK: - Private Methods
    private func arrangeSliders(by color: UIColor) {
        let ciColor = CIColor(color: color)
        
        redSlider.value = Float(ciColor.red)
        greenSlider.value = Float(ciColor.green)
        blueSlider.value = Float(ciColor.blue)
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
                redValueLabel.text = convertString(from: redSlider)
            case greenValueLabel:
                greenValueLabel.text = convertString(from: greenSlider)
            default:
                blueValueLabel.text = convertString(from: blueSlider)
            }
        }
    }
    
    private func setCurrentValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTextField:
                redTextField.text = convertString(from: redSlider)
            case greenTextField:
                greenTextField.text = convertString(from: greenSlider)
            default:
                blueTextField.text = convertString(from: blueSlider)
            }
        }
    }
    
    private func convertString(from slider: UISlider) -> String {
        String(format: "%0.2f", slider.value)
    }
    
    private func showAlert(with title: String, message: String, cleanTextField: UITextField) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            cleanTextField.text = ""
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    @objc private func didTapDone() {
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate
extension SettingColorViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        
        if let newValueFloat = Float(newValue), newValueFloat > 0 && newValueFloat < 1 {
            switch textField {
            case redTextField:
                redSlider.setValue(newValueFloat, animated: true)
                setCurrentValue(for: redValueLabel)
                setCurrentValue(for: redTextField)
            case greenTextField:
                greenSlider.setValue(newValueFloat, animated: true)
                setCurrentValue(for: greenValueLabel)
                setCurrentValue(for: greenTextField)
            default:
                blueSlider.setValue(newValueFloat, animated: true)
                setCurrentValue(for: blueValueLabel)
                setCurrentValue(for: redTextField)
                setCurrentValue(for: blueTextField)
            }
            
            setViewColor()
            return
        }
        
        showAlert(
            with: "Wrong format!",
            message: "Please enter a number from 0.00 to 1.00",
            cleanTextField: textField
        )
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        textField.inputAccessoryView = keyboardToolbar
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(didTapDone)
        )
        
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        keyboardToolbar.items = [flexBarButton, doneButton]
    }
}
