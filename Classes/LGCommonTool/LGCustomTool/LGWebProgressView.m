//
//  LGWebProgressView.m
//  haoshuimian365
//
//  Created by LZH on 2019/4/16.
//  Copyright © 2019 CYY or LZH. All rights reserved.
//

#import "LGWebProgressView.h"
#import <UIKit/UIKit.h>
static NSTimeInterval const tiemInterval = 0.01;
@implementation LGWebProgressView{
    CAShapeLayer *_layer;
    NSTimer *_timer;
    CGFloat _speed;
    BOOL _isSpeedLoad;
}
- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}
- (void)initialize{
    self.lineWidth = 2;
    self.strokeColor = [UIColor colorWithHexString:@"9288FF"].CGColor;
    _timer = [NSTimer scheduledTimerWithTimeInterval:tiemInterval target:self selector:@selector(pathChanged:) userInfo:nil repeats:YES];
    [self pause];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 2)];
    [path addLineToPoint:CGPointMake([UIScreen mainScreen].bounds.size.width, 2)];
    
    self.path = path.CGPath;
    self.strokeEnd = 0;
    _speed = 0.001;
    _isSpeedLoad = NO;
}

- (void)pathChanged:(NSTimer *)timer {
    if (_isSpeedLoad) {
        //页面加载完后开始加速加速进度条
        self.strokeEnd +=0.02;
    }else{
        //页面没有加载完是慢慢的加载
        if (self.strokeEnd <= 0.8) {
            self.strokeEnd += 0.005;
        }
    }
    //进度条加载完后移除掉
    if (self.strokeEnd>=1.0) {
        [self closeTimer];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.hidden = YES;
            [self removeFromSuperlayer];
        });
    }
}
- (void)dealloc {
    //NSLog(@"progressView dealloc");
    [self closeTimer];
}

#pragma mark - private
- (void)closeTimer {
    [_timer invalidate];
    _timer = nil;
}

- (void)pause{
    if ([_timer isValid]) {
        [_timer setFireDate:[NSDate distantFuture]];
    }
}
- (void)startLoad {
    if ([_timer isValid]) {
        [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:tiemInterval]];
    }
}
- (void)speedLoad{
    _isSpeedLoad = YES;
}
@end
