//
//  ViewControllerRootView.swift
//  TestMessenger
//
//  Created by Vladimir Budniy on 11.06.17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation
import UIKit

public protocol ViewControllerRootView {
    
    associatedtype RootViewType
    
    var rootView: RootViewType { get }
}

public extension ViewControllerRootView where Self : UIViewController {
    
    var rootView: RootViewType {
        return self.view as! RootViewType
    }
}
