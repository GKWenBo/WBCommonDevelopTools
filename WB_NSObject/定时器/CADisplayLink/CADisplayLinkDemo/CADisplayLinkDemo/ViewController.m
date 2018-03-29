//
//  ViewController.m
//  CADisplayLinkDemo
//
//  Created by Admin on 2017/11/20.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /**  < 创建CADisplayLink >  */
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(printSeconds)];
    /**  < 设置每秒刷新一次 The default value is 60 >  */
    self.displayLink.preferredFramesPerSecond = 1;
    /**  < 注册到RunLoop中 NSDefaultRunLoopMode >  */
    /**
     < Default mode（NSDefaultRunLoopMode）
     默认模式中几乎包含了所有输入源(NSConnection除外),一般情况下应使用此模式。
     
     Connection mode（NSConnectionReplyMode）
     处理NSConnection对象相关事件，系统内部使用，用户基本不会使用。
     Modal mode（NSModalPanelRunLoopMode）
     处理modal panels事件。
     
     Event tracking mode（UITrackingRunLoopMode）
     在拖动loop或其他user interface tracking loops时处于此种模式下，在此模式下会限制输入事件的处理。例如，当手指按住UITableView拖动时就会处于此模式。
     
     Common mode（NSRunLoopCommonModes）
     这是一个伪模式，其为一组run loop mode的集合，将输入源加入此模式意味着在Common Modes中包含的所有模式下都可以处理。在Cocoa应用程序中，默认情况下Common Modes包含default modes,modal modes,event Tracking modes.可使用CFRunLoopAddCommonMode方法想Common Modes中添加自定义modes。
     >  */
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    /**  < 暂停定时器 Initial state is
      false >  */
    self.displayLink.paused = YES;
}

#pragma mark ------ < Event Response > ------
#pragma mark
- (IBAction)start:(id)sender {
    self.displayLink.paused = NO;
}

- (IBAction)pause:(id)sender {
    self.displayLink.paused = YES;
}

- (IBAction)clear:(id)sender {
    /**  < 销毁定时器 >  */
    [self.displayLink invalidate];
    self.displayLink = nil;
}

- (void)printSeconds {
    static NSInteger i = 0;
    NSLog(@"%ld",i);
    i++;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
