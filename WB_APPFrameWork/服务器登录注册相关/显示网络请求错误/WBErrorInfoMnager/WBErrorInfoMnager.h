//
//  WBErrorInfoMnager.h
//  WBErrorInfoMnagerDemo
//
//  Created by WMB on 2017/9/25.
//  Copyright © 2017年 文波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBErrorInfoMnager : NSObject

+ (void)wb_checkAndShowError:(NSError *)error;

@end
