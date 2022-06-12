//
//  MainViewController.swift
//  ColorMixer
//
//  Created by Elena Pavlova on 12.06.2022.
//

import UIKit

protocol SettingColorViewControllerDelegate {
    func setNewColor(with newColor: UIColor)
}

class MainViewController: UIViewController, SettingColorViewControllerDelegate {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingColorVC = segue.destination as? SettingColorViewController else { return }
        settingColorVC.currentColor = view.backgroundColor
        settingColorVC.delegate = self
    }

    func setNewColor(with newColor: UIColor) {
        view.backgroundColor = newColor
    }
}
