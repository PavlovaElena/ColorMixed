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
        setCurrentValue(for: redValueLabel, greenValueLabel, blueValueLabel)
    }
    
    @IBAction func changeSliderValue(_ sender: UISlider) {
        switch sender {
        case redSlider: setCurrentValue(for: redValueLabel)
        case greenSlider: setCurrentValue(for: greenValueLabel)
        default: setCurrentValue(for: blueValueLabel)
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
}

