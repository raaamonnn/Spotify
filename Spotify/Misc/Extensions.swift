//
//  Extensions.swift
//  Spotify
//
//  Created by Ramon Amini on 2/11/22.
//

import Foundation
import UIKit

extension UIView {
    var width: CGFloat {
        return frame.size.width
    }
    
    var height: CGFloat {
        return frame.size.height
    }
    
    var leading: CGFloat {
        return frame.origin.x
    }
    
    var trailing: CGFloat {
        return leading + width
    }
    
    var top: CGFloat {
        return frame.origin.y
    }
    
    var bottom: CGFloat {
        return top + height
    }
}

enum HttpMethod: String {
    case POST
    case GET
}
