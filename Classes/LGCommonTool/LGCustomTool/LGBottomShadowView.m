//
//  LGBottomShadowView.m
//  haoshuimian365
//
//  Created by admin  on 2018/8/23.
//  Copyright © 2018年 CYY or LZH. All rights reserved.
//  主页底部渐变色

#import "LGBottomShadowView.h"

@implementation LGBottomShadowView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        [self.layer addSublayer:[self shadowAsInverse]];
    }
    return self;
}

- (CAGradientLayer *)shadowAsInverse{
    CAGradientLayer *newShadow = [[CAGradientLayer alloc] init];
    CGRect newShadowFrame = CGRectMake(0, 0, Screen_W, self.frame.size.height);
    newShadow.frame = newShadowFrame;
    //添加渐变的颜色组合（颜色透明度的改变）
    newShadow.colors = [NSArray arrayWithObjects:
                        (id)[[[UIColor colorWithHexString:@"eeeeee"] colorWithAlphaComponent:0] CGColor] ,
                        (id)[[[UIColor colorWithHexString:@"eeeeee"] colorWithAlphaComponent:0.1] CGColor],
                        (id)[[[UIColor colorWithHexString:@"eeeeee"] colorWithAlphaComponent:0.2] CGColor],
                        (id)[[[UIColor colorWithHexString:@"eeeeee"] colorWithAlphaComponent:0.3] CGColor],
                        (id)[[[UIColor colorWithHexString:@"eeeeee"] colorWithAlphaComponent:0.4] CGColor],
                        (id)[[[UIColor colorWithHexString:@"eeeeee"] colorWithAlphaComponent:0.5] CGColor],
                        nil];
    return newShadow;
}

@end
