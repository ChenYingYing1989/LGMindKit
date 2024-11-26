//
//  UIView+Extensions.h
//  CSLeftSlideDemo
//
//  Created by LCS on 16/2/13.
//  Copyright © 2016年 LCS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LGExtension)

/**设置圆角*/
@property (nonatomic, assign)IBInspectable CGFloat cornerRidus;

@property (nonatomic, assign)CGSize size;
/** 获取view所在的controller */
-(UIViewController *)getViewController;

/** 判断self和anotherView是否重叠 */
- (BOOL)overlapWithAnotherView:(UIView *)anotherView;

//部分切圆角
-(void)clipsCorners:(UIRectCorner)corners cornerRadius:(CGSize)radiusSize;
//创建阴影
-(void)setShadoWithColor:(NSString *)color offset:(CGSize)size  opacity:(CGFloat)opacity  radius:(CGFloat)radius;

//添加边框
-(void)addBorder:(NSString *)borderColor  lineWidth:(CGFloat)lineWidth  cornerRidus:(CGFloat)radius;

//阴影view
+(instancetype)shadowViewWithColor:(NSString *)color offset:(CGSize)size  opacity:(CGFloat)opacity  radius:(CGFloat)radius;

//创建分割线
+(instancetype)lineViewWithColor:(NSString *)lineColor  frame:(CGRect)frame;

@end
