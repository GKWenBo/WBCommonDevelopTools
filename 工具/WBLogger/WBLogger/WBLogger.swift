//
//  WBLogger.swift
//  WBLogger
//
//  Created by wenbo22 on 2024/1/8.
//

import OSLog

@objc class WBLogger: NSObject {
    static let `default` = WBLogger()
    
    let logger = Logger(subsystem: "wb", category: "wblogger")
    
    @objc class func sharedLogger() -> WBLogger {
        return WBLogger.default
    }
    
    
    /// 输出警告log
    /// - Parameter msg: 警告信息
    @objc class func warning(_ msg: String) {
        sharedLogger().logger.warning("\(msg)")
    }
    
    /// 实现输出错误log
    @objc class func error(_ msg: String) {
        sharedLogger().logger.error("\(msg)")
    }
    
    /// 实现输出debug log
    @objc class func debug(_ msg: String) {
        sharedLogger().logger.debug("\(msg)")
    }
    
    /// 实现输出info log
    @objc class func info(_ msg: String) {
        sharedLogger().logger.info("\(msg)")
    }
    
    /// 实现输出fault log
    @objc class func fault(_ msg: String) {
        sharedLogger().logger.fault("\(msg)")
    }
    
    /// 实现输出notice log
    @objc class func notice(_ msg: String) {
        sharedLogger().logger.notice("\(msg)")
    }
    
    @objc class func trice(_ msg: String) {
        sharedLogger().logger.trace("\(msg)")
    }
    
    @objc class func critical(_ msg: String) {
        sharedLogger().logger.critical("\(msg)")
    }
}
