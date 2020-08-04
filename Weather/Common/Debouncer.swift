//
//  CustomDebouncer.swift
//  ComponentSwift
//
//  Created by Thanh Pham on 4/22/20.
//

import Foundation

public class Debouncer: NSObject {
    public var callback: (() -> ())?
    
    var delay: TimeInterval
    weak var timer: Timer?

    public init(delay: TimeInterval, callback: (() -> ())? = nil) {
        self.delay = delay
        self.callback = callback
    }

    public func call() {
        timer?.invalidate()
        let nextTimer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(fireNow), userInfo: nil, repeats: false)
        timer = nextTimer
    }

    @objc public func fireNow() {
        self.callback?()
    }
}
