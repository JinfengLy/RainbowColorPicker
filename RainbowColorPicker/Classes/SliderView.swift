//
//  SliderView.swift
//  RainbowColorPicker
//
//  Created by Li, Jackie on 3/12/20.
//

import UIKit

public protocol SliderViewProtocol: class {
    func sliderValueChanged(to value: CGFloat)
}

class SliderView: UIView {

    private let sliderLayer = CAGradientLayer()
    private var cursor: CursorView?
    private var sliderValue: CGFloat = 0.5
    public var delegate: SliderViewProtocol?
    
    var degree: Double? {
        didSet {
            updateSliderColor()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initMe()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initMe()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = self.frame.size.width
        let height = self.frame.size.height
        let sliderFrame = CGRect(x: 0, y: 0, width: width, height: height)
        self.sliderLayer.cornerRadius = height / 2.0
        self.sliderLayer.frame = sliderFrame
        self.cursor?.center = CGPoint(x: width / 2, y: height / 2)
    }
    
    private func initMe() {
        self.sliderLayer.startPoint = CGPoint(x: 0, y: 0.5)
        self.sliderLayer.endPoint = CGPoint(x: 1, y: 0.5)
        self.sliderLayer.borderColor = UIColor.lightGray.cgColor
        self.sliderLayer.borderWidth = 0
        self.layer.addSublayer(self.sliderLayer)
        self.backgroundColor = UIColor.clear
        self.cursor = CursorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        self.addSubview(self.cursor!)
        let pan = UIPanGestureRecognizer(target: self, action:#selector(panEvent))
        self.addGestureRecognizer(pan)
    }
    
    @objc private func panEvent(gesture: UIPanGestureRecognizer) {
        guard let cursor = self.cursor else { return }
        let point = gesture.location(in: self)
        let width = self.frame.size.width
        let cursor_x = max(0, point.x > width ? width : point.x)
        cursor.center = CGPoint(x: cursor_x, y: cursor.center.y)
        let value = cursor_x / width
        self.sliderValue = value
        updateSliderColor()
        self.delegate?.sliderValueChanged(to: value)
    }
    
    private func updateSliderColor() {
        guard let degree = self.degree else { return }
        let hue = CGFloat(degree / 360.0)
        let dark = UIColor(hue: hue, saturation: 1.0, brightness: 0.2, alpha: 1.0)
        let regular = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        let light = UIColor(hue: hue, saturation: 0.2, brightness: 1.0, alpha: 1.0)
        self.sliderLayer.colors = [dark.cgColor, regular.cgColor, light.cgColor]
        self.cursor?.cursorColor = UIColor.color(hue: hue, sliderValue: self.sliderValue)
    }

}
