//
//  RainbowColorPickerView.swift
//  RainbowColorPicker
//
//  Created by Li, Jackie on 3/12/20.
//

import UIKit

public protocol RainbowColorPickerViewProtocol: class {
    func colorDidReceive(_ color: UIColor)
}

public class RainbowColorPickerView: UIView {
    let circleMargin: CGFloat = 50.0
    let ballOriginDegree = 270.0
    var ballCurrentDegree = 270.0
    var circleRadius: Double = 0
    
    var ball: CursorView!
    var innerCircle: UIView!
    var sliderView: SliderView!
    
    // between 0 and 1
    var sliderValue: CGFloat = 0.5
    
    public weak var delegate: RainbowColorPickerViewProtocol?
    
    override public func draw(_ rect: CGRect) {
        var circlePath = UIBezierPath()
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        circlePath.move(to: CGPoint(x: center.x + CGFloat(self.circleRadius), y: center.y))
        for i in stride(from: 0, to: 361.0, by: 1) {
            let radians = i * Double.pi / 180
            let x = Double(center.x) + self.circleRadius * cos(radians)
            let y = Double(center.y) + self.circleRadius * sin(radians)
            circlePath.addLine(to: CGPoint(x: x, y: y))
            circlePath.lineWidth = 5
            let color = UIColor(hue: CGFloat(i/360.0), saturation: 1.0, brightness: 1.0, alpha: 1.0)
            color.setStroke()
            circlePath.stroke()
            circlePath = UIBezierPath()
            circlePath.move(to: CGPoint(x: x, y: y))
            
            if i == ballOriginDegree {
                self.ball.center = CGPoint(x: x, y: y)
                self.ball.cursorColor = color
                self.sliderView.degree = i
                updateInnerCircleColor()
            }
        }
    }
    
    @objc func dragBallEvent(gesture: UIPanGestureRecognizer) {
        let point = gesture.location(in: self)
        let earthX = Double(point.x)
        let earthY = Double(point.y)
        let midViewXDouble = Double(self.bounds.size.width/2)
        let midViewYDouble = Double(self.bounds.size.height/2)
        let angleX = (earthX - midViewXDouble)
        let angleY = (earthY - midViewYDouble)
        let angle = atan2(angleY, angleX)
        let earthX2 = midViewXDouble + cos(angle) * self.circleRadius
        let earthY2 = midViewYDouble + sin(angle) * self.circleRadius
        self.ball.center = CGPoint(x: earthX2,y: earthY2)
        var degree = 180.0 * angle / Double.pi
        degree = degree < 0 ? 360 + degree : degree
        self.ballCurrentDegree = degree
        let color = UIColor(hue: CGFloat(degree/360.0), saturation: 1.0, brightness: 1.0, alpha: 1.0)
        self.ball.cursorColor = color
        self.sliderView.degree = degree
        updateInnerCircleColor()
        notifyColorUpdate()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initMe()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initMe()
    }
    
    private func initMe() {
        let length = min(self.frame.width, self.frame.height)
        self.circleRadius = Double(length - circleMargin) / 2.0
        initBall()
        initInnderCircle()
        initSlider()
    }
    
    private func initBall() {
        self.ball = CursorView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        self.addSubview(self.ball)
        let dragBall = UIPanGestureRecognizer(target: self, action:#selector(dragBallEvent))
        self.ball.addGestureRecognizer(dragBall)
    }
    
    private func initInnderCircle() {
        let width = self.frame.size.width
        let height = self.frame.size.height
        let diameter = CGFloat(self.circleRadius * 2 / 5)
        self.innerCircle = UIView(frame: CGRect(x: 0, y: 0, width: diameter, height: diameter))
        self.innerCircle.backgroundColor = .clear
        self.innerCircle.layer.cornerRadius = diameter / 2.0
        self.innerCircle.layer.borderWidth = 3
        self.innerCircle.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        self.innerCircle.center = CGPoint(x: width / 2.0, y: height / 2.0)
        self.addSubview(self.innerCircle)
    }
    
    private func initSlider() {
        self.sliderView = SliderView(frame: CGRect(x: 0, y: 0, width: self.circleRadius, height: 10))
        self.sliderView.delegate = self
        self.sliderView.center = CGPoint(x: self.frame.width/2, y: self.frame.height/2 + self.innerCircle.frame.height)
        self.addSubview(self.sliderView)
    }
    
    private func updateInnerCircleColor() {
        let color = UIColor.color(hue: CGFloat(self.ballCurrentDegree/360.0), sliderValue: self.sliderValue)
        self.innerCircle.backgroundColor = color
    }
    
    // this is the final color !!!!
    private func notifyColorUpdate() {
        let color = UIColor.color(hue: CGFloat(self.ballCurrentDegree/360.0), sliderValue: self.sliderValue)
        self.delegate?.colorDidReceive(color)
    }
    
}

extension RainbowColorPickerView: SliderViewProtocol {
    
    public func sliderValueChanged(to value: CGFloat) {
        self.sliderValue = value
        updateInnerCircleColor()
        notifyColorUpdate()
    }

}

extension UIColor {
    
    class func color(hue: CGFloat, sliderValue: CGFloat) -> UIColor {
        var brightness: CGFloat = 1
        var saturation: CGFloat = 1
        
        if sliderValue <= 0.5 {
            brightness = sliderValue * 2.0
        } else {
            saturation = 2 - sliderValue * 2.0
        }
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
    }
    
}
