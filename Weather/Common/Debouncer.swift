//
//  CustomDebouncer.swift
//  ComponentSwift
//
//  Created by Thanh Pham on 4/22/20.
//

import Foundation

public class Debouncer: NSObject {
    
    public var workItem: DispatchWorkItem?
    private var delay: TimeInterval

    public init(delay: TimeInterval) {
        self.delay = delay
    }
    
    public func run(action: @escaping () -> Void) {
        workItem?.cancel()
        workItem = DispatchWorkItem(block: action)
        
        if let workItem = workItem {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: workItem)
        }
    }
}

