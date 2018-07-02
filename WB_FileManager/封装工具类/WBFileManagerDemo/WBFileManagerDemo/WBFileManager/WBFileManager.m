//
//  WB_FileManager.m
//  WB_FileManager
//
//  Created by WMB on 2017/5/16.
//  Copyright © 2017年 文波. All rights reserved.
//

#import "WBFileManager.h"

static WBFileManager *manager = nil;
/** < 异步队列：处理文件操作 > */
static dispatch_queue_t _concurrentQueue;

@implementation WBFileManager

+ (instancetype)shareManager {
    if (!manager) {
        manager = [[WBFileManager alloc]init];
    }
    return manager;
}

#pragma mark ------ < 获取文件大小 > ------
- (NSString *)wb_syncGetCacheFileSize {
    return [self wb_syncGetFileSizeWithFilePath:[self wb_getCacheDirPath]];
}

- (NSString *)wb_syncGetFileSizeWithFilePath:(NSString *)path {
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
        BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath
                                                            isDirectory:&isDirectory];
        // 4. 以上判断目的是忽略不需要计算的文件
        if (!isExist || isDirectory || [filePath containsString:@".DS"]){
            // 过滤: 1. 文件夹不存在  2. 过滤文件夹  3. 隐藏文件
            continue;
        }
        // 5. 指定路径，获取这个路径的属性
        NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath
                                                                              error:nil];
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
        totleStr = [NSString stringWithFormat:@"%.2fM",totleSize / 1000.00f / 1000.00f];
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
    return (NSInteger)([freeSizeStr longLongValue] / 1000 * 1000);
}

/** < 清理缓存 && 文件操作 > */
- (void)wb_asyncClearCacheDirFile {
    return [self wb_asyncClearFileAtPath:[self wb_getCacheDirPath]];
}

- (void)wb_asyncClearFileAtPath:(NSString *)path {
    if (!path) return;
    
    /** < 获取文件夹下所有文件 > */
    NSArray *subPathArr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path
                                                                              error:NULL];
    dispatch_async([self concurrentQueue], ^{
        NSString * filePath = nil;
        NSError * error = nil;
        for (NSString * subPath in subPathArr) {
            filePath = [path stringByAppendingPathComponent:subPath];
            /** 删除子文件夹 */
            if ([[NSFileManager defaultManager] removeItemAtPath:filePath error:&error]) {
                NSLog(@"文件删除成功=%@",filePath);
            }else {
                NSLog(@"删除文件失败=%@",error);
            }
        }
    });
}

- (void)wb_asycnRemoveFileAtPath:(NSString *)path
                       completed:(void (^) (BOOL success))completed {
    if (!path) return;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    __block NSError *error;
    if ([self wb_isFileExistAtPath:path]) {
        dispatch_async([self concurrentQueue], ^{
           BOOL res = [fileManager removeItemAtPath:path
                                              error:&error];
            completed(res);
            if (!res) {
                NSLog(@"删除文件%@--错误：%@",path,error);
            }
        });
    }else {
        NSLog(@"文件不存在");
    }
}

#pragma mark -- 获取文件路径
- (NSString *)wb_getDocumentDirPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

- (NSString *)wb_getCacheDirPath {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
}

// MARK: 文件存储
- (void)wb_syncWritePlist:(id)plist
                   toFile:(NSString *)fileName
            directoryType:(WBDirectoryType)directoryType {
    if (![NSPropertyListSerialization propertyList:plist isValidForFormat:NSPropertyListBinaryFormat_v1_0]) {
        NSLog(@"不能转为二进制数据，请检查数据");
        return;
    }
    
    NSError *error;
    
    NSData *data = [NSPropertyListSerialization dataWithPropertyList:plist
                                                              format:NSPropertyListBinaryFormat_v1_0
                                                             options:0
                                                               error:&error];
    
    if (!data) {
        NSLog (@"error serializing to xml: %@", error);
        return;
    }
    
    NSString *filePath = [[self wb_getDirPath:directoryType] stringByAppendingPathComponent:fileName];
    
    dispatch_barrier_sync([self concurrentQueue], ^{
       BOOL res = [data writeToFile:filePath
                         atomically:YES];
        if (!res) {
            NSLog (@"error writing to file: %@", error);
            return;
        }
    });
}

- (void)wb_asyncWritePlist:(id)plist
                    toFile:(NSString *)fileName
             directoryType:(WBDirectoryType)directoryType
                 completed:(void (^) (BOOL success))completed {
    if (![NSPropertyListSerialization propertyList:plist isValidForFormat:NSPropertyListBinaryFormat_v1_0]) {
        NSLog(@"不能转为二进制数据，请检查数据");
        return;
    }
    
    NSError *error;
    
    NSData *data = [NSPropertyListSerialization dataWithPropertyList:plist
                                                              format:NSPropertyListBinaryFormat_v1_0
                                                             options:0
                                                               error:&error];
    
    if (!data) {
        NSLog (@"error serializing to xml: %@", error);
        return;
    }
    
    NSString *filePath = [[self wb_getDirPath:directoryType] stringByAppendingPathComponent:fileName];
    dispatch_barrier_async([self concurrentQueue], ^{
        BOOL res = [data writeToFile:filePath
                          atomically:YES];
        completed(res);
    });
}

- (id)wb_syncReadPlistWithFile:(NSString *)fileName
                 directoryType:(WBDirectoryType)directoryType {
    NSString *filePath = [[self wb_getDirPath:directoryType] stringByAppendingPathComponent:fileName];
    
    NSError *error;
    NSData *data = [NSData dataWithContentsOfFile:filePath
                                          options:NSDataReadingMappedIfSafe
                                            error:&error];
    if (!data) {
        NSLog(@"error reading %@: %@", filePath, error);
        return nil;
    }
    
    id plist = [NSPropertyListSerialization propertyListWithData:data
                                                         options:0
                                                          format:NULL
                                                           error:&error];
    if (!plist) {
        NSLog (@"could not deserialize %@: %@", filePath, error);
    }
    return plist;
}

//#pragma mark -- 文件存储
//- (void)wb_saveDictArray:(NSArray *)array
//                fileName:(NSString *)fileName
//                filePath:(NSString *)filePath {
//    NSAssert(fileName || filePath, @"请设置文件名或文件路径");
//    NSString * fullPath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",fileName]];
//    NSArray * tempArray = nil;
//    NSMutableArray * mutableArray = nil;
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    /**  判断文件是否存在 不存在则创建 存在则读取  */
//    if ([fileManager fileExistsAtPath:fullPath]) {
//        tempArray = [NSArray arrayWithContentsOfFile:fullPath];
//        mutableArray = [NSMutableArray arrayWithArray:tempArray];
//    }else {
//        mutableArray = @[].mutableCopy;
//    }
//    for (id dict in array) {
//        if ([dict isKindOfClass:[NSDictionary class]] || [dict isKindOfClass:[NSMutableDictionary class]]) {
//
//            NSMutableDictionary * tempDict = [NSMutableDictionary dictionaryWithDictionary:dict];
//            /**  排除key为nsnull  */
//            for (NSString * key in tempDict.allKeys) {
//                if (tempDict[key] == [NSNull null]) {
//                    [tempDict setValue:@"" forKey:key];
//                }
//            }
//            [mutableArray addObject:tempDict];
//        }else {
//            NSAssert([dict isKindOfClass:[NSDictionary class]] || [dict isKindOfClass:[NSMutableDictionary class]], @"请存储字典对象");
//        }
//    }
//    if ([mutableArray writeToFile:fullPath atomically:YES]) {
//         NSLog(@"属性列表存储数据成功");
//
//    }else {
//         NSLog(@"属性列表存储数据失败");
//    }
//}
//
//- (void)wb_saveDictArrayToCachePathWithArray:(NSArray *)array
//                                    fileName:(NSString *)fileName {
//    [self wb_saveDictArray:array fileName:fileName filePath:[self wb_getCacheDirPath]];
//}
//
//- (NSArray *)wb_getDictArrayWithFileName:(NSString *)fileName filePath:(NSString *)filePath {
//    NSAssert(fileName || filePath, @"请设置文件名或文件路径");
//    NSString * fullPath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",fileName]];
//    NSArray * tempArray = nil;
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    if ([fileManager fileExistsAtPath:fullPath]) {
//        NSLog(@"获取文件成功");
//        tempArray = [NSArray arrayWithContentsOfFile:fullPath];
//    }else {
//        NSLog(@"文件不存在");
//    }
//    return tempArray;
//}
//
//- (NSArray *)wb_getDictArrayFromCachePath:(NSString *)fileName {
//    return [self wb_getDictArrayWithFileName:fileName filePath:[self wb_getCacheDirPath]];
//}
//
//- (void)wb_saveDict:(NSDictionary *)dict
//           fileName:(NSString *)fileName
//           filePath:(NSString *)filePath {
//     NSAssert(fileName || filePath, @"请设置文件名或文件路径");
//     NSString * fullPath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",fileName]];
//    NSDictionary * tempDict = nil;
//    NSMutableDictionary * mutableDict = nil;
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    if ([fileManager fileExistsAtPath:fullPath]) {
//        tempDict = [NSDictionary dictionaryWithContentsOfFile:fullPath];
//    }else {
//        mutableDict = @{}.mutableCopy;
//    }
//    for (NSString * key in dict) {
//        if (dict[key] == [NSNull null]) {
//            [mutableDict setValue:@"" forKey:key];
//        }
//    }
//    if ([mutableDict writeToFile:fullPath atomically:YES]) {
//        NSLog(@"保存字典失败");
//    }else {
//        NSLog(@"保存字典成功");
//    }
//}
//
//- (void)wb_saveDictToCachePathWithDict:(NSDictionary *)dict fileName:(NSString *)fileName {
//
//    [self wb_saveDict:dict fileName:fileName filePath:[self wb_getCacheDirPath]];
//}
//- (NSDictionary *)wb_getDictWithFileName:(NSString *)fileName
//                                filePath:(NSString *)filePath {
//    NSAssert(fileName || filePath, @"请设置文件名或文件路径");
//    NSString * fullPath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",fileName]];
//    NSDictionary * dict = nil;
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    if ([fileManager fileExistsAtPath:fullPath]) {
//        dict = [NSDictionary dictionaryWithContentsOfFile:fullPath];
//        NSLog(@"读取字典文件成功");
//    }else {
//        NSLog(@"字典文件路径不存在");
//    }
//    return dict;
//}

//- (NSDictionary *)wb_getDictFromCachePath:(NSString *)fileName {
//    return [self wb_getDictWithFileName:fileName filePath:[self wb_getCacheDirPath]];
//}

// MARK:文件判断
- (BOOL)wb_isFileExistAtPath:(NSString *)path {
    NSFileManager *fileNanager = [NSFileManager defaultManager];
    return [fileNanager fileExistsAtPath:path];
}

// MARK:Private Method
- (NSString *)wb_getDirPath:(WBDirectoryType)type {
    switch (type) {
        case WBDirectoryCacheType:
            return [self wb_getCacheDirPath];
            break;
        default:
            return [self wb_getDocumentDirPath];
            break;
    }
}

// MARK:Getter
- (dispatch_queue_t)concurrentQueue {
    if (!_concurrentQueue) {
        _concurrentQueue = dispatch_queue_create("com.WBFileManagerConcurrentQueue.info", DISPATCH_QUEUE_CONCURRENT);
    }
    return _concurrentQueue;
}

@end
