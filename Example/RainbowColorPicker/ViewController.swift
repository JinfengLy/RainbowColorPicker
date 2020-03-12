//
//  ViewController.swift
//  RainbowColorPicker
//
//  Created by Jackie Li on 03/12/2020.
//  Copyright (c) 2020 Jackie Li. All rights reserved.
//

import UIKit
import RainbowColorPicker

class ViewController: UIViewController {

    @IBOutlet weak var colorPickerView: RainbowColorPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.colorPickerView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: RainbowColorPickerViewProtocol {
    
    func colorDidReceive(_ color: UIColor) {
        print("color:", color)
    }
    
}

