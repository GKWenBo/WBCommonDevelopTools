//
//  WBScreenRecorder.h
//  WBScreenRecorder
//
//  Created by wenbo on 2018/4/23.
//  Copyright © 2018年 wenbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WBScreenRecorderDelegate <NSObject>

- (void)screenRecorderStartSuccessfully;
- (void)screeenRecorderLaunchFailedReason:(NSString *)reason;
- (void)screenRecorderStopSuccessfully;
- (void)screenRecorderStopFailedReason:(NSString *)reason;
- (void)screenRecorderSaveSuccessfully;
- (void)screenRecorderTimeChange;

@end

@interface WBScreenRecorder : NSObject


@property (nonatomic, assign) BOOL microphoneEnabled;
@property (nonatomic, weak) id <WBScreenRecorderDelegate> delegate;
@property (nonatomic, assign, readonly) NSInteger recorderTime;
/** <
特殊说明: 由于会给出上个录屏的路径,所以录屏完后保存一份到了沙盒中,每次录制完新的视频后,会移除上一个录屏,然后存新的视频,所以这个路径实际上是不变的.只是内容会改变.
 >  */
@property (nonatomic, strong, readonly) NSString *lastSavePath;

/**
 单例管理

 @return WBScreenRecorder
 */
+ (instancetype)shareInstance;

/**
 Begin screen recorder.
 */
- (void)startScreenRecorder;

/**
 Stop screen recorder.
 */
- (void)stopScreenRecorder;

@end
