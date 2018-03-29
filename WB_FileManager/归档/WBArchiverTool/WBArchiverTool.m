//
//  WBArchiverTool.m
//  Demo
//
//  Created by WMB on 2017/9/24.
//  Copyright © 2017年 文波. All rights reserved.
//

#import "WBArchiverTool.h"

@implementation WBArchiverTool
/**
 *  归档
 *
 *  @param object     归档对象
 *  @param keyString  归档的建
 *  @param pathString 文件路径
 */
+ (void)wb_archiverObject:(id)object key:(NSString *)keyString filePath:(NSString *)pathString {
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    // NSMutableData对象相当于一个数据中转站
    NSMutableData *mData = [NSMutableData data];
    // 创建归档器
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mData];
    // 将学生对象进行归档编码并指定对应的键
    [archiver encodeObject:object forKey:keyString];
    // 结束归档编码
    [archiver finishEncoding];
    // 将归档数据写入文件中完成持久化
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 文件夹路径
    NSString *createPath = [NSString stringWithFormat:@"%@/Data", path];
    // 判断路径是否存在 不存在则创建
    if (![[NSFileManager defaultManager] fileExistsAtPath:createPath]) {
        [fileManager createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
    } else {
        NSLog(@"FileDir is exists.");
    }
    NSString *filePath = [pathString isEqualToString:@"loginUserInfoModel"] ? [path stringByAppendingPathComponent:pathString] : [createPath stringByAppendingPathComponent:pathString];
    [mData writeToFile:filePath atomically:YES];
}

/**
 *  解归档的对象
 *
 *  @param pathString path
 *  @param keyStirng  key
 *
 *  @return 返回对象
 */
+ (id)wb_unarchiverPath:(NSString *)pathString key:(NSString *)keyStirng {
    // 将归档文件的数据加载到内存中
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 文件夹路径
    NSString *createPath = [NSString stringWithFormat:@"%@/Data", path];
    NSString *filePath = [pathString isEqualToString:@"loginUserInfoModel"] ? [path stringByAppendingPathComponent:pathString] : [createPath stringByAppendingPathComponent:pathString];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    // 创建解归档器
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    id model = [unarchiver decodeObjectForKey:keyStirng];
    // 通过指定的键将对象解归档出来
    return model;
}
@end
