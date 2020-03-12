//
//  CursorView.swift
//  RainbowColorPicker
//
//  Created by Li, Jackie on 3/12/20.
//

import UIKit

class CursorView: UIView {
    
    private let cursorLayer = CALayer()
    
    var cursorColor: UIColor? {
        didSet {
            cursorLayer.backgroundColor = cursorColor?.cgColor
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
    
    private func initMe() {
        let width = self.frame.size.width
        let height = self.frame.size.height
        let frame = CGRect(x: 0, y: 0, width: width, height: height)
        cursorLayer.frame = frame
        let diameter = min(width, height)
        cursorLayer.borderColor = UIColor.white.cgColor
        cursorLayer.borderWidth = 3
        cursorLayer.cornerRadius = diameter / 2.0
        self.backgroundColor = UIColor.clear
        self.layer.addSublayer(cursorLayer)
    }
}
