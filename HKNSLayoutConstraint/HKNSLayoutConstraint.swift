//
//  HKNSLayoutConstraint.swift
//  HK Enhanced NSLayoutConstraint
//

///  MIT License
///
///  Copyright (c) 2020 Harrison Kong
///
///  Permission is hereby granted, free of charge, to any person obtaining a copy
///  of this software and associated documentation files (the "Software"), to deal
///  in the Software without restriction, including without limitation the rights
///  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell/
///  copies of the Software, and to permit persons to whom the Software is
///  furnished to do so, subject to the following conditions:
///
///  The above copyright notice and this permission notice shall be included in all
///  copies or substantial portions of the Software.
///
///  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
///  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
///  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
///  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
///  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
///  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
///  SOFTWARE.

//  Version: 1.0.0
//
//  Version History
//  -----------------------------------------------------------------
//  1.0.0     2020/02/17 initial release
//
//  Dependencies
//  -----------------------------------------------------------------
//  HKDeviceUtilities
//  HKUIViewLengthCalculationBasis

import UIKit
import HKDeviceUtilities
import HKUIViewLengthCalculationBasis

public enum HKNSLayoutConstraintSecondItem {
    case notAnItem
    case deviceScreen
    case uiItem(UIView?)
}

public class HKNSLayoutConstraint: NSLayoutConstraint {
    
    // MARK: - IB Inspectables
    // MARK: -
    
    @IBInspectable public var altMultiplier : CGFloat
    @IBInspectable public var alt2ndItem : Int {
        didSet {
            if alt2ndItem < 0 { alt2ndItem = 0 }
            if alt2ndItem > 2 { alt2ndItem = 2 }
            
            switch alt2ndItem {
                
            case 0:
                altSecondItem = .notAnItem
            case 1:
                altSecondItem = .deviceScreen
            case 2:
                altSecondItem = .uiItem(nil)
            default:
                altSecondItem = .deviceScreen
            }
        }
    }
    
    @IBInspectable public var altCalcBasis : Int {
        didSet {
            if altCalcBasis < 1 { altCalcBasis = 1 }
            if altCalcBasis > 5 { altCalcBasis = 5 }
            
            switch altCalcBasis {
                
            case 1 :
                altCalculationBasis = .width
            case 2 :
                altCalculationBasis = .height
            case 3 :
                altCalculationBasis = .shorterEdge
            case 4 :
                altCalculationBasis = .longerEdge
            case 5 :
                altCalculationBasis = .constant
            default:
                altCalculationBasis = .constant
            }
        }
    }
    
    // MARK: - Properties
    // MARK: -
    
    public var altSecondItem : HKNSLayoutConstraintSecondItem = .deviceScreen
    public var altCalculationBasis : UIView.LengthCalculationBasis = .height
    
    // MARK: - Initializers
    // MARK: -
    
    override public init() {
        
        altMultiplier = 1.0
        alt2ndItem    = 0        // default to "Not an item"
        altCalcBasis  = 5        // default to .constant
        
        super.init()
        updateLayout()
    }
    
    public convenience init(item: Any, attribute: NSLayoutConstraint.Attribute, relatedBy: NSLayoutConstraint.Relation, toItem: Any?, attribute secondAttribute: NSLayoutConstraint.Attribute, multiplier: CGFloat, constant: CGFloat, altSecondItem: HKNSLayoutConstraintSecondItem, altCalculationBasis: UIView.LengthCalculationBasis, altMultiplier: CGFloat) {
        
        self.init(item: item, attribute: attribute, relatedBy: relatedBy, toItem: toItem, attribute: secondAttribute, multiplier: multiplier, constant: constant)
        
        self.altMultiplier = altMultiplier
        self.altCalculationBasis = altCalculationBasis
        self.altSecondItem = altSecondItem
    }

    public convenience init(item: Any, attribute: NSLayoutConstraint.Attribute, altSecondItem: HKNSLayoutConstraintSecondItem, altCalculationBasis: UIView.LengthCalculationBasis, altMultiplier: CGFloat) {
        
        // multiplier should default to:
        //
        // 1.0 for X and Y anchors
        // we do want the original calculation in addition to the constant
        // that we calculate
        //
        // 0.001 for dimensions because if the users do not
        // provide one we assume they only want the constant that we
        // calculate
        
        var multiplierToUse : CGFloat = 1.0
        
        switch attribute {
            
        case .width, .height:
            multiplierToUse = 0.001
        default:
            break
        }
            
        self.init(item: item, attribute: attribute, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: multiplierToUse, constant: 0)

        self.altMultiplier = altMultiplier
        self.altCalculationBasis = altCalculationBasis
        self.altSecondItem = altSecondItem
    }

    public convenience init(item: Any, attribute: NSLayoutConstraint.Attribute, altSecondItem: HKNSLayoutConstraintSecondItem, altCalculationBasis: UIView.LengthCalculationBasis, constant: CGFloat) {
        
        // multiplier should be:
        //
        // 1.0 for X and Y anchors
        // we do want the original calculation in addition to the constant
        // that we calculate
        //
        // 0.001 for dimensions because if the users do not
        // provide one we assume they only want the constant that we
        // calculate
        
        var multiplierToUse : CGFloat = 1.0
        
        switch attribute {
            
        case .width, .height:
            multiplierToUse = 0.001
        default:
            break
        }
            
        self.init(item: item, attribute: attribute, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: multiplierToUse, constant: constant)

        self.altMultiplier = 1.0
        self.altCalculationBasis = altCalculationBasis
        self.altSecondItem = altSecondItem
    }
    
    // MARK: - Public Methods
    // MARK: -
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        updateLayout()
    }
    
    // this method is to be called from viewWillLayoutSubviews() of the view
    // constroller so that the constant can be calculated after the device
    // is rotated
    
    public func viewWillLayoutSubviews() {
        updateLayout()
    }
    
    // MARK: - Private Methods
    // MARK: -
    
    @objc private func updateLayout() {

        switch altSecondItem {
            
        case .notAnItem:
            // do nothing
            return
            
        case .deviceScreen:
            
            // a short delay is needed here for any rotation to take place
            // and the screen's width and height to update correctly

            DispatchQueue.main.async { // After(deadline: .now() + 0.2) {

                var base : CGFloat = 0.0
                
                switch self.altCalculationBasis {
                    
                case .width:
                    base = hkScreenWidth()
                    self.constant = base * self.altMultiplier
                case .height:
                    base = hkScreenHeight()
                    self.constant = base * self.altMultiplier
                case .shorterEdge:
                    base = hkScreenShorterEdge()
                    self.constant = base * self.altMultiplier
                case .longerEdge:
                    base = hkScreenLongerEdge()
                    self.constant = base * self.altMultiplier
                case .constant:
                    // no calculation needed, use constant as it
                    break
                }

            }
            
        case .uiItem(view: let viewToUse):
            
            // a short delay is needed here for any rotation to take place
            // and the view's width and height to update correctly
            
            DispatchQueue.main.async { // After(deadline: .now() + 0.35) {
            
                guard let viewToUse = viewToUse else { return }

                var base : CGFloat = 0.0
                let viewToUseHeight = viewToUse.frame.height
                let viewToUseWidth = viewToUse.frame.width

                switch self.altCalculationBasis {

                case .width:
                    base = viewToUseWidth
                    self.constant = base * self.altMultiplier
                case .height:
                    base = viewToUseHeight
                    self.constant = base * self.altMultiplier
                case .shorterEdge:
                    base = min(viewToUseHeight, viewToUseWidth)
                    self.constant = base * self.altMultiplier
                case .longerEdge:
                    base = max(viewToUseHeight,viewToUseWidth)
                    self.constant = base * self.altMultiplier
                case .constant:
                    // no calculation needed, use constant as it
                    break
                }
            }
            
        }
    }
    
}
