//
//  TooltipView.h
//  haoshuimian
//
//  Created by apple on 16/8/24.
//  Copyright © 2016年 CYY. All rights reserved.
//  黑条提示框

#import <UIKit/UIKit.h>

@interface TooltipView : UIView

+(void)showMessage:(NSString *)message offset:(CGFloat)offset;

//带感叹号图标的弹框
+(void)showAlertMessage:(NSString *)message;

//带图标的弹框
+(void)showMessage:(NSString *)message alertPic:(NSString *)pic;

@end
