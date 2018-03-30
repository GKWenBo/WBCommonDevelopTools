//
//  WB_FileManager.m
//  WB_FileManager
//
//  Created by WMB on 2017/5/16.
//  Copyright © 2017年 文波. All rights reserved.
//

#import "WBFileManager.h"

static WBFileManager * manager = nil;

@implementation WBFileManager

+ (instancetype)shareManager {
    if (!manager) {
        manager = [[WBFileManager alloc]init];
    }
    return manager;
}

#pragma mark ------ < 获取文件大小 > ------
- (NSString *)wb_getCacheFileSize {
    
    NSString * cachePath = [self wb_getCacheDirPath];
    //获cache路径下所有文件
    NSArray * subPathArr = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    
    NSString * filePath = nil;
    NSInteger totalSize = 0;
    
    for (NSString * subPath in subPathArr) {
        //1.拼接每一个文件的全路径
        filePath = [cachePath stringByAppendingPathComponent:subPath];
        //2.是否是文件夹 默认不是
        BOOL isDirectory = NO;
        
        //3.判断文件是否存在
        BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
        
        //4.以上判断目的是忽略不需要计算的文件
        if (!isExist || isDirectory || [filePath containsString:@".DS"]) {
            // 过滤: 1. 文件夹不存在  2. 过滤文件夹  3. 隐藏文件
            continue;
        }
        
        // 5. 指定路径，获取这个路径的属性
        NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        /**
         attributesOfItemAtPath: 文件夹路径
         该方法只能获取文件的属性, 无法获取文件夹属性, 所以也是需要遍历文件夹的每一个文件的原因
         */
        
        // 6. 获取每一个文件的大小
        NSInteger size = [dict[@"NSFileSize"] integerValue];
        
        // 7. 计算总大小
        totalSize += size;
    }
    //8. 将文件夹大小转换为 M/KB/B
    NSString *totleStr = nil;
    if (totalSize > 1000 * 1000){
        totleStr = [NSString stringWithFormat:@"%.2fM",totalSize / 1000.00f /1000.00f];
    }else if (totalSize > 1000){
        totleStr = [NSString stringWithFormat:@"%.2fKB",totalSize / 1000.00f ];
    }else{
        totleStr = [NSString stringWithFormat:@"%.2fB",totalSize / 1.00f];
    }
    return totleStr;
}

- (NSString *)wb_getFileSizeWithFilePath:(NSString *)path {
    // 获取“path”文件夹下的所有文件
    NSArray *subPathArr = [[NSFileManager defaultManager] subpathsAtPath:path];
    
    NSString *filePath  = nil;
    NSInteger totleSize = 0;
    for (NSString *subPath in subPathArr){
        // 1. 拼接每一个文件的全路径
        filePath =[path stringByAppendingPathComponent:subPath];
        // 2. 是否是文件夹，默认不是
        BOOL isDirectory = NO;
        // 3. 判断文件是否存在
        BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
        // 4. 以上判断目的是忽略不需要计算的文件
        if (!isExist || isDirectory || [filePath containsString:@".DS"]){
            // 过滤: 1. 文件夹不存在  2. 过滤文件夹  3. 隐藏文件
            continue;
        }
        // 5. 指定路径，获取这个路径的属性
        NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        /**
         attributesOfItemAtPath: 文件夹路径
         该方法只能获取文件的属性, 无法获取文件夹属性, 所以也是需要遍历文件夹的每一个文件的原因
         */
        // 6. 获取每一个文件的大小
        NSInteger size = [dict[@"NSFileSize"] integerValue];
        
        // 7. 计算总大小
        totleSize += size;
    }
    //8. 将文件夹大小转换为 M/KB/B
    NSString *totleStr = nil;
    if (totleSize > 1000 * 1000){
        totleStr = [NSString stringWithFormat:@"%.2fM",totleSize / 1000.00f /1000.00f];
    }else if (totleSize > 1000){
        totleStr = [NSString stringWithFormat:@"%.2fKB",totleSize / 1000.00f ];
    }else{
        totleStr = [NSString stringWithFormat:@"%.2fB",totleSize / 1.00f];
    }
    return totleStr;
}

- (NSInteger)wb_getDiskFreeSize {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSDictionary *dict = [fileManager attributesOfItemAtPath:NSHomeDirectory() error:&error];
    NSString *freeSizeStr = [NSString stringWithFormat:@"%@",[dict objectForKey:NSFileSystemFreeSize]];
    return (NSInteger)([freeSizeStr longLongValue] / 1024 * 1024);
}

#pragma mark -- 清理缓存 && 文件操作
- (void)wb_clearCacheCompletedBlock:(void (^) (BOOL isSuccess))completedBlock{
    NSString * cachePath = [self wb_getCacheDirPath];
    //异步清除
    __block BOOL isSuccess = YES;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
        NSLog(@"files :%lu",(unsigned long)[files count]);
        for (NSString *p in files) {
            NSError *error;
            NSString *path = [cachePath stringByAppendingPathComponent:p];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                isSuccess = [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                if (error) {
                    isSuccess = NO;
                }
            }
        }
        //返回主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"清理缓存成功");
            completedBlock(isSuccess);
        });
    });
}

- (void)wb_clearFileAtPath:(NSString *)path
            completedBlock:(void (^) (BOOL isSuccess))completedBlock {
    
    NSArray * subPathArr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    
    __block BOOL isSuccess = YES;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString * filePath = nil;
        NSError * error = nil;
        for (NSString * subPath in subPathArr) {
            filePath = [path stringByAppendingPathComponent:subPath];
            /** 删除子文件夹 */
            isSuccess = [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
            if (error) {
                isSuccess = NO;
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completedBlock(isSuccess);
        });
    });
}

- (BOOL)wb_removeFileAtPath:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    return [fileManager removeItemAtPath:path error:&error];
}

#pragma mark -- 获取文件路径
- (NSString *)wb_getDocumentDirPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

- (NSString *)wb_getCacheDirPath {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
}

#pragma mark -- 文件存储
- (void)wb_saveDictArray:(NSArray *)array
                fileName:(NSString *)fileName
                filePath:(NSString *)filePath {
    NSAssert(fileName || filePath, @"请设置文件名或文件路径");
    NSString * fullPath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",fileName]];
    NSArray * tempArray = nil;
    NSMutableArray * mutableArray = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    /**  判断文件是否存在 不存在则创建 存在则读取  */
    if ([fileManager fileExistsAtPath:fullPath]) {
        tempArray = [NSArray arrayWithContentsOfFile:fullPath];
        mutableArray = [NSMutableArray arrayWithArray:tempArray];
    }else {
        mutableArray = @[].mutableCopy;
    }
    for (id dict in array) {
        if ([dict isKindOfClass:[NSDictionary class]] || [dict isKindOfClass:[NSMutableDictionary class]]) {
            
            NSMutableDictionary * tempDict = [NSMutableDictionary dictionaryWithDictionary:dict];
            /**  排除key为nsnull  */
            for (NSString * key in tempDict.allKeys) {
                if (tempDict[key] == [NSNull null]) {
                    [tempDict setValue:@"" forKey:key];
                }
            }
            [mutableArray addObject:tempDict];
        }else {
            NSAssert([dict isKindOfClass:[NSDictionary class]] || [dict isKindOfClass:[NSMutableDictionary class]], @"请存储字典对象");
        }
    }
    if ([mutableArray writeToFile:fullPath atomically:YES]) {
         NSLog(@"属性列表存储数据成功");
        
    }else {
         NSLog(@"属性列表存储数据失败");
    }
}

- (void)wb_saveDictArrayToCachePathWithArray:(NSArray *)array
                                    fileName:(NSString *)fileName {
    [self wb_saveDictArray:array fileName:fileName filePath:[self wb_getCacheDirPath]];
}

- (NSArray *)wb_getDictArrayWithFileName:(NSString *)fileName filePath:(NSString *)filePath {
    NSAssert(fileName || filePath, @"请设置文件名或文件路径");
    NSString * fullPath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",fileName]];
    NSArray * tempArray = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:fullPath]) {
        NSLog(@"获取文件成功");
        tempArray = [NSArray arrayWithContentsOfFile:fullPath];
    }else {
        NSLog(@"文件不存在");
    }
    return tempArray;
}

- (NSArray *)wb_getDictArrayFromCachePath:(NSString *)fileName {
    return [self wb_getDictArrayWithFileName:fileName filePath:[self wb_getCacheDirPath]];
}

- (void)wb_saveDict:(NSDictionary *)dict
           fileName:(NSString *)fileName
           filePath:(NSString *)filePath {
     NSAssert(fileName || filePath, @"请设置文件名或文件路径");
     NSString * fullPath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",fileName]];
    NSDictionary * tempDict = nil;
    NSMutableDictionary * mutableDict = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:fullPath]) {
        tempDict = [NSDictionary dictionaryWithContentsOfFile:fullPath];
    }else {
        mutableDict = @{}.mutableCopy;
    }
    for (NSString * key in dict) {
        if (dict[key] == [NSNull null]) {
            [mutableDict setValue:@"" forKey:key];
        }
    }
    if ([mutableDict writeToFile:fullPath atomically:YES]) {
        NSLog(@"保存字典失败");
    }else {
        NSLog(@"保存字典成功");
    }
}

- (void)wb_saveDictToCachePathWithDict:(NSDictionary *)dict fileName:(NSString *)fileName {
    
    [self wb_saveDict:dict fileName:fileName filePath:[self wb_getCacheDirPath]];
}
- (NSDictionary *)wb_getDictWithFileName:(NSString *)fileName
                                filePath:(NSString *)filePath {
    NSAssert(fileName || filePath, @"请设置文件名或文件路径");
    NSString * fullPath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",fileName]];
    NSDictionary * dict = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:fullPath]) {
        dict = [NSDictionary dictionaryWithContentsOfFile:fullPath];
        NSLog(@"读取字典文件成功");
    }else {
        NSLog(@"字典文件路径不存在");
    }
    return dict;
}
- (NSDictionary *)wb_getDictFromCachePath:(NSString *)fileName {
    return [self wb_getDictWithFileName:fileName filePath:[self wb_getCacheDirPath]];
}

#pragma mark -- NSUserDefaults
- (void)wb_storageValue:(id)value forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (id)wb_getValueForKey:(NSString *)key {
    id value = [[NSUserDefaults standardUserDefaults] valueForKey:key];
    return value;
}

#pragma mark ------ < 文件判断 > ------
- (BOOL)wb_isFileExistAtPath:(NSString *)path {
    NSFileManager *fileNanager = [NSFileManager defaultManager];
    return [fileNanager fileExistsAtPath:path];
}
@end
