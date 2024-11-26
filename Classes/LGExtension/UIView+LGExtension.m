//
//  UIView+Extensions.m
//  CSLeftSlideDemo
//
//  Created by LCS on 16/2/13.
//  Copyright © 2016年 LCS. All rights reserved.
//

#import "UIView+LGExtension.h"

@implementation UIView (LGExtension)

-(CGFloat)cornerRidus{
    return self.layer.cornerRadius;
}

-(void)setCornerRidus:(CGFloat)cornerRidus{
    self.layer.cornerRadius = cornerRidus;
    self.layer.masksToBounds = YES;
    self.clipsToBounds = YES;
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGSize)size{
    return self.frame.size;
}

/** 获取view所在的controller */
-(UIViewController *)getViewController{
    for (UIView* next = [self superview]; next; next = next.superview){
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]){
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}


/** 判断self和anotherView是否重叠 */
- (BOOL)overlapWithAnotherView:(UIView *)anotherView{
    //如果anotherView为nil，那么就代表keyWindow
    if (anotherView == nil) anotherView = LGKeyWindow;
    CGRect selfRect = [self convertRect:self.bounds toView:nil];
    CGRect anotherRect = [anotherView convertRect:anotherView.bounds toView:nil];
    //CGRectIntersectsRect是否有交叉
    return CGRectIntersectsRect(selfRect, anotherRect);
}


-(void)setShadoWithColor:(NSString *)color offset:(CGSize)size  opacity:(CGFloat)opacity  radius:(CGFloat)radius{
    self.layer.shadowColor = [UIColor colorWithHexString:color].CGColor;
    self.layer.shadowOffset = size;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = radius;
    self.layer.cornerRadius = radius;
}

+(instancetype)shadowViewWithColor:(NSString *)color offset:(CGSize)size  opacity:(CGFloat)opacity  radius:(CGFloat)radius{
    UIView *view = [[UIView alloc]init];
    view.layer.shadowColor = [UIColor colorWithHexString:color].CGColor;
    view.layer.shadowOffset = size;
    view.layer.shadowOpacity = opacity;
    view.layer.shadowRadius = radius;
    view.layer.cornerRadius = radius;
    return view;
}

+(instancetype)lineViewWithColor:(NSString *)lineColor  frame:(CGRect)frame{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = [UIColor colorWithHexString:lineColor];
    return view;
}

//部分切圆角
-(void)clipsCorners:(UIRectCorner)corners cornerRadius:(CGSize)radiusSize{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:radiusSize];
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.frame = self.bounds;
    layer.path = path.CGPath;
    self.layer.mask = layer;
}

//添加边框
-(void)addBorder:(NSString *)borderColor  lineWidth:(CGFloat)lineWidth  cornerRidus:(CGFloat)radius{
    self.layer.borderColor = [UIColor colorWithHexString:borderColor].CGColor;
    self.layer.borderWidth = lineWidth;
    self.layer.cornerRadius = radius;
}

@end
