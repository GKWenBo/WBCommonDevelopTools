//
//  WB_ArchiveManager.h
//  DaShenLianMeng
//
//  Created by WMB on 2017/9/2.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kWBARCHIVEMANAGER [WBArchiveManager shareManager]
@interface WBArchiveManager : NSObject

+ (instancetype)shareManager;

/**
 数据归档
 
 @param fileName 保存的文件路径
 @param archiveData 归档数据
 @return YES/NO
 */
- (BOOL)wb_archiveObjectToFileWithFileName:(NSString *)fileName archiveData:(id)archiveData;

/**
 数据接档
 
 @param fileName 文件路径
 @return 接档后的数据
 */
- (id)wb_unarchiveObjectWithFileName:(NSString *)fileName;

/**
 删除归档文件

 @param path 路径
 @return YES/NO
 */
- (BOOL)wb_removeArchiveDataAtFilePath:(NSString *)path;

@end
