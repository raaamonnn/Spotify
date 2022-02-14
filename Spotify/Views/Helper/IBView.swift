//
//  IBView.swift
//  StudentLoanCopilot
//
//  Created by Skylar sarabia on 10/15/20.
//  Copyright © 2020 Astro Media inc. All rights reserved.
//

import UIKit

@IBDesignable class IBView: UIView
{
    private var circularFlag = false
    
    @IBInspectable var cornerRadius: CGFloat {
        get {return layer.cornerRadius}
        set {
            layer.cornerRadius = newValue
            layer.cornerCurve = .continuous
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        get {return layer.borderWidth}
        set {layer.borderWidth = newValue}
    }
    @IBInspectable var borderColor: UIColor? {
        get {
            if layer.borderColor != nil
            {
                return UIColor(cgColor: layer.borderColor!)
            }
            return nil
        }
        set {layer.borderColor = newValue?.cgColor}
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {return layer.shadowRadius} set {layer.shadowRadius = newValue}
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        if circularFlag
        {
            self.clipsToBounds = true
            cornerRadius = self.frame.width / 2
        }
    }
    
    func applyProportionalRoundCorners()
    {
        self.circularFlag = true
    }
}
