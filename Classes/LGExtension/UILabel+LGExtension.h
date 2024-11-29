//
//  UILabel+LGExtension.h
//  jiangxiaoyu
//
//  Created by apple on 17/3/27.
//  Copyright © 2017年 CYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LGExtension)

+(instancetype)lableWithText:(NSString *)text colorString:(NSString *)color  textFont:(UIFont *)textFont textAlignment:(NSTextAlignment)textAlignment  lines:(CGFloat)lines;

//设置行间距
-(void)lineSpacing:(CGFloat)spacing;
//设置行间距
-(void)lineSpacing2:(CGFloat)spacing;

//设置字间距
-(void)wordSpacing:(CGFloat)spacing;

//给文字添加分割线
-(void)addMidleSegmentLine;

@end
