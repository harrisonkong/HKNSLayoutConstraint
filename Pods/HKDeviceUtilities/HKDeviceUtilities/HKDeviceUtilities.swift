//
//  HKDeviceUtilities.swift
//  HK Utilities for UIDevice
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
//  1.0.0     - 2020/02/04 initial release

import UIKit

// Note: It is advised that you call these methods after a slight delay
// when responding to the UIDevice.orientationDidChangeNotification
// notification so that the width and height have a chance to update
//
// Example:
//
//   DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
//
//       let screenWidth = hkScreenWidth()
//       let screenHeight = hkScreenHeight()
//       // other code
//   }

public func hkIsLandscape() -> Bool {
    
    switch UIDevice.current.orientation {
        
    case .portrait, .portraitUpsideDown :
        return false
    case .landscapeLeft, .landscapeRight :
        return true
    default :
        let w = UIScreen.main.bounds.width
        let h = UIScreen.main.bounds.height
        return h < w
    }
}

public func hkIsPortrait() -> Bool {
    
    switch UIDevice.current.orientation {
        
    case .portrait, .portraitUpsideDown :
        return true
    case .landscapeRight, .landscapeLeft:
        return false
    default :
        let w = UIScreen.main.bounds.width
        let h = UIScreen.main.bounds.height
        return h > w
    }
}

public func hkScreenHeight() -> CGFloat {
    return UIScreen.main.bounds.height
}

public func hkScreenLongerEdge() -> CGFloat {
    let w = UIScreen.main.bounds.width
    let h = UIScreen.main.bounds.height
    return max(w, h)
}

public func hkScreenShorterEdge() -> CGFloat {
    let w = UIScreen.main.bounds.width
    let h = UIScreen.main.bounds.height
    return min(w, h)
}

public func hkScreenSize() -> CGSize {
    return CGSize(width: hkScreenWidth(), height: hkScreenHeight())
}

public func hkScreenWidth() -> CGFloat {
    return UIScreen.main.bounds.width
}

