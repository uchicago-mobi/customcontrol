//
//  DualSlider.swift
//  CustomControl
//
//  Created by Chelsea Troy on 5/7/19.
//  Copyright © 2019 Chelsea Troy. All rights reserved.
//

import UIKit

class DualSlider: UIControl {
    var minimumValue = 0.0
    var maximumValue = 1.0
    var lowerValue = 0.2
    var upperValue = 0.8
    
    var previousLocation = CGPoint()
    
    let inactiveLayer = CALayer()
    let activatedLayer = CALayer()
    let lowerThumbLayer = DualSliderThumbLayer()
    let upperThumbLayer = DualSliderThumbLayer()
        
    var thumbWidth: CGFloat {
        return CGFloat(bounds.height)
    }
    
    override var frame: CGRect {
        didSet {
            updateLayerFrames()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        lowerThumbLayer.dualSlider = self
        upperThumbLayer.dualSlider = self
        
        layer.cornerRadius = 10
        
        inactiveLayer.backgroundColor = UIColor.black.cgColor
        layer.addSublayer(inactiveLayer)
        
        activatedLayer.backgroundColor = UIColor.green.cgColor
        layer.addSublayer(activatedLayer)
        
        lowerThumbLayer.backgroundColor = UIColor.white.cgColor
        lowerThumbLayer.cornerRadius = 4
        lowerThumbLayer.borderWidth = 1
        lowerThumbLayer.borderColor = UIColor.black.cgColor
        layer.addSublayer(lowerThumbLayer)
        
        upperThumbLayer.backgroundColor = UIColor.white.cgColor
        upperThumbLayer.cornerRadius = 4
        upperThumbLayer.borderWidth = 1
        upperThumbLayer.borderColor = UIColor.black.cgColor
        layer.addSublayer(upperThumbLayer)
        
        updateLayerFrames()
    }

    func updateLayerFrames() {
        inactiveLayer.frame = CGRect(
            x: 0,
            y: bounds.height / 3,
            width: bounds.width,
            height: bounds.height / 3
        )
        
        activatedLayer.frame = CGRect(
            x: bounds.width * CGFloat(lowerValue),
            y: bounds.height / 3,
            width: bounds.width * CGFloat(upperValue - lowerValue),
            height: bounds.height / 3
        )
        activatedLayer.setNeedsDisplay()
        
        let lowerThumbCenter = CGFloat(positionForValue(value: lowerValue))
        lowerThumbLayer.frame = CGRect(
            x: lowerThumbCenter - thumbWidth / 2.0,
            y: 0.0,
            width: thumbWidth,
            height: thumbWidth
        )
        lowerThumbLayer.setNeedsDisplay()
        
        let upperThumbCenter = CGFloat(positionForValue(value: upperValue))
        upperThumbLayer.frame = CGRect(x: upperThumbCenter - thumbWidth / 2.0, y: 0.0,
                                       width: thumbWidth, height: thumbWidth)
        upperThumbLayer.setNeedsDisplay()
    }
    
    func positionForValue(value: Double) -> Double {
        return Double(bounds.width - thumbWidth) * (value - minimumValue) /
            (maximumValue - minimumValue) + Double(thumbWidth / 2.0)
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        previousLocation = touch.location(in: self)
        
        if lowerThumbLayer.frame.contains(previousLocation) {
            lowerThumbLayer.highlighted = true
        } else if upperThumbLayer.frame.contains(previousLocation) {
            upperThumbLayer.highlighted = true
        }
        
        return lowerThumbLayer.highlighted || upperThumbLayer.highlighted
    }
    
    func boundValue(value: Double, toLowerValue lowerValue: Double, upperValue: Double) -> Double {
        return min(max(value, lowerValue), upperValue)
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        
        // 1. Determine by how much the user has dragged
        let deltaLocation = Double(location.x - previousLocation.x)
        let deltaValue = (maximumValue - minimumValue) * deltaLocation / Double(bounds.width - thumbWidth)
        
        previousLocation = location
        
        // 2. Update the values
        if lowerThumbLayer.highlighted {
            lowerValue += deltaValue
            lowerValue = boundValue(value: lowerValue, toLowerValue: minimumValue, upperValue: upperValue)
        } else if upperThumbLayer.highlighted {
            upperValue += deltaValue
            upperValue = boundValue(value: upperValue, toLowerValue: lowerValue, upperValue: maximumValue)
        }
        
        // 3. Update the UI
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        updateLayerFrames()
        
        CATransaction.commit()
        
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        lowerThumbLayer.highlighted = false
        upperThumbLayer.highlighted = false
    }

}
