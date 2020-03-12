# RainbowColorPicker

[![Version](https://img.shields.io/cocoapods/v/RainbowColorPicker.svg?style=flat)](https://cocoapods.org/pods/RainbowColorPicker)
[![License](https://img.shields.io/cocoapods/l/RainbowColorPicker.svg?style=flat)](https://cocoapods.org/pods/RainbowColorPicker)
[![Platform](https://img.shields.io/cocoapods/p/RainbowColorPicker.svg?style=flat)](https://cocoapods.org/pods/RainbowColorPicker)

***RainbowColorPicker*** is a lightweight color picker for iOS developers.  

<img src="https://github.com/JinfengLy/RainbowColorPicker/blob/master/sample.gif"/>

## Requirements
- iOS 12.x~
- Swift 5.0

## How to use it

#### Podfile

    platform :ios, '12.0'
    pod "RainbowColorPicker", "~> 0.1.1"

#### Install

    $ pod install
    
#### Usage
##### init 
    // you can also use autolayout from storyboard
    let colorPicker = RainbowColorPickerView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
    colorPicker.backgroundColor = UIColor.clear
    colorPicker.delegate = self
    colorPicker.center = self.view.center
    self.view.addSubview(colorPicker)
##### Adpot Protocol
    extension ViewController: RainbowColorPickerViewProtocol {
        func colorDidReceive(_ color: UIColor) {
            // this is the color that user picked
            print("color:", color)
        }
    }
## Author

Jinfeng(Jackie) Li, jackielycs@gmail.com

## License

RainbowColorPicker is available under the MIT license. See the LICENSE file for more info.
