//
//  WBArchiverTool.h
//  Demo
//
//  Created by WMB on 2017/9/24.
//  Copyright © 2017年 文波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBArchiverTool : NSObject
/**
 *  归档
 *
 *  @param object     归档对象
 *  @param keyString  归档的建
 *  @param pathString 文件路径,已经是APP家目录只需加后缀
 */
+ (void)wb_archiverObject:(id)object key:(NSString *)keyString filePath:(NSString *)pathString;

/**
 *  解归档的对象
 *
 *  @param pathString path,已经是APP家目录只需加后缀
 *  @param keyStirng  key
 *
 *  @return 返回对象
 */
+ (id)wb_unarchiverPath:(NSString *)pathString key:(NSString *)keyStirng;
@end
