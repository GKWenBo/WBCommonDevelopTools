//
//  WBScreenRecorder.m
//  WBScreenRecorder
//
//  Created by wenbo on 2018/4/23.
//  Copyright © 2018年 wenbo. All rights reserved.
//

#import "WBScreenRecorder.h"

#import <ReplayKit/ReplayKit.h>
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIKit.h>


@interface WBScreenRecorder () <RPScreenRecorderDelegate,RPPreviewViewControllerDelegate>

@property (nonatomic, assign) BOOL isSave;
@property (nonatomic, strong) NSTimer *recorderTimer;

@end

@implementation WBScreenRecorder


+ (instancetype)shareInstance {
    static WBScreenRecorder *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

#pragma mark < 初始化 >
- (instancetype)init
{
    self = [super init];
    if (self) {
        _isSave = NO;
    }
    return self;
}

#pragma mark < Public Method >
- (void)startScreenRecorder {
    if ([RPScreenRecorder sharedRecorder].isRecording) {
        if (_delegate && [_delegate respondsToSelector:@selector(screenRecorderStopFailedReason:)]) {
            [_delegate screenRecorderStopFailedReason:@"已经在录制了"];
        }
        return;
    }
    
    if ([RPScreenRecorder sharedRecorder].isAvailable && [self isiOS9Later]) {
        RPScreenRecorder *recorder = [RPScreenRecorder sharedRecorder];
        recorder.delegate = self;
        NSLog(@"启动录屏");
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                NSLog(@"Authorized");
            }else {
                NSLog(@"Denied or Restricted");
            }
        }];
        
        recorder.microphoneEnabled = _microphoneEnabled;
        recorder.cameraEnabled = YES;
        
        [recorder startRecordingWithHandler:^(NSError * _Nullable error) {
            if (error) {
                if (_delegate && [_delegate respondsToSelector:@selector(screenRecorderStopFailedReason:)]) {
                    [_delegate screenRecorderStopFailedReason:error.description];
                }
                NSLog(@"录屏失败 error = %@",error.description);
            }else {
                if ([RPScreenRecorder sharedRecorder].recording) {
                    if (_delegate && [_delegate respondsToSelector:@selector(screenRecorderSaveSuccessfully)]) {
                        [_delegate screenRecorderSaveSuccessfully];
                        NSLog(@"开始录屏");
                        dispatch_async(dispatch_get_main_queue(), ^{
                            _recorderTime = 0;
                            _recorderTimer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(timeHasChanged) userInfo:nil repeats:YES];
                            [[NSRunLoop currentRunLoop] addTimer:_recorderTimer forMode:NSRunLoopCommonModes];
                        });
                    }
                }
            }
        }];
    }else {
        if (_delegate && [_delegate respondsToSelector:@selector(screeenRecorderLaunchFailedReason:)]) {
            [_delegate screeenRecorderLaunchFailedReason:@"iOS系统版本过低"];
        }
        return;
    }
}

- (void)stopScreenRecorder {
    if ([RPScreenRecorder sharedRecorder].isRecording == NO) {
        if (_delegate && [_delegate respondsToSelector:@selector(screenRecorderStopFailedReason:)]) {
            [_delegate screenRecorderStopFailedReason:@"当前并未录制"];
        }
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    [[RPScreenRecorder sharedRecorder] stopRecordingWithHandler:^(RPPreviewViewController * _Nullable previewViewController, NSError * _Nullable error) {
        if (error) {
            if (_delegate && [_delegate respondsToSelector:@selector(screenRecorderStopFailedReason:)]) {
                [_delegate screenRecorderStopFailedReason:error.description];
            }
            NSLog(@"停止失败 error = %@",error.description);
        }else {
            [_recorderTimer invalidate];
            _recorderTimer = nil;
            
            if (_delegate && [_delegate respondsToSelector:@selector(screenRecorderStopSuccessfully)]) {
                [_delegate screenRecorderStopSuccessfully];
            }
            previewViewController.previewControllerDelegate = (id<RPPreviewViewControllerDelegate>)self;
            [weakSelf showVideoPreviewController:previewViewController];
        }
        
    }];
}


#pragma mark < RPScreenRecorderDelegate >
- (void)screenRecorderDidChangeAvailability:(RPScreenRecorder *)screenRecorder {
    NSLog(@" delegate ======%@",screenRecorder);
}

- (void)screenRecorder:(RPScreenRecorder *)screenRecorder didStopRecordingWithPreviewViewController:(RPPreviewViewController *)previewViewController error:(NSError *)error {
    previewViewController.previewControllerDelegate = (id<RPPreviewViewControllerDelegate>)self;
    [self showVideoPreviewController:previewViewController];
}

#pragma mark < RPPreviewViewControllerDelegate >
- (void)previewControllerDidFinish:(RPPreviewViewController *)previewController {
    if (_isSave == YES) {
        
        [self hideVideoPreviewController:previewController];
        
        _isSave = NO;
    }else {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertAction *queding = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self hideVideoPreviewController:previewController];
                _isSave = NO;
            }];
            UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"录制未保存\n确定要取消吗" preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:actionCancel];
            [alert addAction:queding];
            
            [previewController presentViewController:alert animated:YES completion:nil];
        });
    }
}

- (void)previewController:(RPPreviewViewController *)previewController didFinishWithActivityTypes:(NSSet<NSString *> *)activityTypes {
    __weak typeof (self)weakSelf = self;
    if ([activityTypes containsObject:@"com.apple.UIKit.activity.SaveToCameraRoll"]) {
        _isSave = YES;
        [self saveVideo];
        NSLog(@"执行保存操作");
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf hideVideoPreviewController:previewController];
        });
    }
    if ([activityTypes containsObject:@"com.apple.UIKit.activity.CopyToPasteboard"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf showAlert:@"复制成功" andMessage:@"已经复制到粘贴板" withPreViewController:previewController];
        });
    }
}

#pragma mark < Private Method >
- (void)timeHasChanged {
    _recorderTime ++;
    if (_delegate && [_delegate respondsToSelector:@selector(screenRecorderTimeChange)]) {
        [_delegate screenRecorderTimeChange];
    }
}

- (BOOL)isiOS9Later {
    if ([[UIDevice currentDevice].systemVersion floatValue] < 9.0) {
        return NO;
    }
    return YES;
}

- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    
    return nil;
}

- (void)showVideoPreviewController:(RPPreviewViewController *)previewController {
    [self.topViewController presentViewController:previewController animated:YES completion:nil];
}

- (void)hideVideoPreviewController:(RPPreviewViewController *)previewController  {
    _isSave = NO;
    [previewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveVideo{
    PHFetchResult *result =nil;
    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
    result = [PHAsset fetchAssetsWithOptions:fetchOptions];
    
    PHAsset *targetAsset = nil;
    targetAsset = result.lastObject;
    
    PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
    options.version = PHImageRequestOptionsVersionCurrent;
    options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
    
    PHImageManager *manager = [PHImageManager defaultManager];
    [manager requestAVAssetForVideo:targetAsset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
        
        NSFileManager *fmanager = [NSFileManager defaultManager];
        
        NSString *path = [NSString stringWithFormat:@"%@/Documents/screen.mp4",NSHomeDirectory()];
        
        if ([fmanager fileExistsAtPath:path]) {
            NSError *error = nil;
            [fmanager removeItemAtPath:path error:&error];
            if (error == nil) {
                NSLog(@"移除上个视频成功");
            }
        }
        
        AVAssetExportSession * session = [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetHighestQuality];
        
        session.outputFileType = AVFileTypeMPEG4;
        
        session.outputURL = [NSURL fileURLWithPath:path];
        
        [session exportAsynchronouslyWithCompletionHandler:^{
            NSLog(@"导出成功");
        }];
    }];
    
}

- (void)showAlert:(NSString *)title andMessage:(NSString *)message withPreViewController:(RPPreviewViewController *)preViewController{
    if (!title) {
        title = @"";
    }
    if (!message) {
        message = @"";
    }
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:actionCancel];
    
    [preViewController presentViewController:alert animated:YES completion:nil];
}

- (NSString *)lastVideoPath
{
    NSString *path = [NSString stringWithFormat:@"%@/Documents/screen.mp4",NSHomeDirectory()];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return path;
    } else {
        return nil;
    }
}


@end
