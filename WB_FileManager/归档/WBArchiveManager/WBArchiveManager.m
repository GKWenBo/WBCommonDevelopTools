//
//  WB_ArchiveManager.m
//  DaShenLianMeng
//
//  Created by WMB on 2017/9/2.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "WBArchiveManager.h"

#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

static WBArchiveManager * manager = nil;
@implementation WBArchiveManager

+ (instancetype)shareManager {
    if (!manager) {
        manager = [[WBArchiveManager alloc]init];
    }
    return manager;
}

- (BOOL)wb_archiveObjectToFileWithFileName:(NSString *)conversation_id archiveData:(id)archiveData {
    return [NSKeyedArchiver archiveRootObject:archiveData toFile:[kDocumentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.archive",conversation_id]]];
}

- (id)wb_unarchiveObjectWithFileName:(NSString *)conversation_id {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[kDocumentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.archive",conversation_id]]];
}

- (BOOL)wb_removeArchiveDataAtFilePath:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [kDocumentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.archive",path]];
    NSError *error = nil;
    if ([fileManager fileExistsAtPath:filePath]) {
        [fileManager removeItemAtPath:filePath error:&error];
    }
    if (!error) {
        NSLog(@"删除归档文件成功");
        return YES;
    }else {
        NSLog(@"删除归档文件失败");
        return NO;
    }
}
@end
