//
//  IBButton.swift
//  StudentLoanCopilot
//
//  Created by Skylar sarabia on 10/15/20.
//  Copyright © 2020 Astro Media inc. All rights reserved.
//

import UIKit

@IBDesignable class IBButton: UIButton {
    
    //MARK: Inspectables
    
    @IBInspectable var borderColor: UIColor? = UIColor.clear {
        didSet {layer.borderColor = borderColor?.cgColor}
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {layer.borderWidth = borderWidth}
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {applyCornerRoundingLogic()}
    }
    @IBInspectable var roundTopRightCorner: Bool = true {didSet {applyCornerRoundingLogic()}}
    @IBInspectable var roundTopLeftCorner: Bool = true {didSet {applyCornerRoundingLogic()}}
    @IBInspectable var roundBotRightCorner: Bool = true {didSet {applyCornerRoundingLogic()}}
    @IBInspectable var roundBotLeftCorner: Bool = true {didSet {applyCornerRoundingLogic()}}
    @IBInspectable var highlightedTxtColor: UIColor = .black {
        didSet {setTitleColor(highlightedTxtColor, for: .highlighted)}
    }
    
    //MARK: Private Functions
    
    private func applyCornerRoundingLogic() {
        var corners = CACornerMask()
        if roundTopRightCorner {corners.insert(.layerMaxXMinYCorner)}
        if roundTopLeftCorner {corners.insert(.layerMinXMinYCorner)}
        if roundBotRightCorner {corners.insert(.layerMaxXMaxYCorner)}
        if roundBotLeftCorner {corners.insert(.layerMinXMaxYCorner)}
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = corners
        layer.cornerCurve = .continuous
    }
}
