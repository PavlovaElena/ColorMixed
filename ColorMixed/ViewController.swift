//
//  ViewController.swift
//  ColorMixed
//
//  Created by Елена Павлова on 28.05.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    
    @IBOutlet weak var colorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 10
        
        setColor()
        setCurrentValue()
        
    }
        
    @IBAction func changeSliderValue(_ sender: UISlider) {
        switch sender {
        case redSlider:
            redValueLabel.text = convertString(from: redSlider)
        case greenSlider:
            greenValueLabel.text = convertString(from: greenSlider)
        default:
            blueValueLabel.text = convertString(from: blueSlider)
        }
        setColor()
    }
    
    private func setColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func setCurrentValue() {
        redValueLabel.text = convertString(from: redSlider)
        greenValueLabel.text = convertString(from: greenSlider)
        blueValueLabel.text = convertString(from: blueSlider)
    }
    
    private func convertString(from slider: UISlider) -> String {
        String(format: "%0.2f", slider.value)
    }
}

