//
//  WBLogger.swift
//  WBLogger
//
//  Created by wenbo22 on 2024/1/8.
//

import OSLog

@objc class WBLogger: NSObject {
    static let `default` = WBLogger()
    
    let logger = Logger(subsystem: "wb", category: "log")
    
    @objc class func sharedLogger() -> WBLogger {
        return WBLogger.default
    }
    
    @objc class func warning(_ msg: String) {
        sharedLogger().logger.warning("\(msg)")
    }
}
