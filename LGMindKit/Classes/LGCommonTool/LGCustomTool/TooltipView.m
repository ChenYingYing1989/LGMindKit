//
//  TooltipView.m
//  haoshuimian
//
//  Created by apple on 16/8/24.
//  Copyright © 2016年 CYY. All rights reserved.
//

#import "TooltipView.h"

#import "HeaderFile.h"

#define maxWidth   viewPix(200)

@implementation TooltipView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

+(void)showMessage:(NSString *)message offset:(CGFloat)offset{
    if (message.length>0) {
        NSAttributedString *attributeStr = [TooltipView attributedString:message];
        CGRect rect = [attributeStr boundingRectWithSize:CGSizeMake(260, 9000) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        UIView *baseView =  [[UIView alloc]initWithFrame:CGRectMake((Screen_W - rect.size.width - 32)/2, Screen_H/2.0+offset-20, rect.size.width+32, rect.size.height+25)];
        baseView.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.9];
        baseView.cornerRidus = 10.0f;
        baseView.alpha = 0;
        [[UIApplication sharedApplication].keyWindow addSubview:baseView];
    
        UILabel *label = [UILabel lableWithText:message colorString:@"#FFFFFF" textFont:LGFont(14) textAlignment:NSTextAlignmentCenter lines:0];
        label.frame = CGRectMake(15, 11, rect.size.width+2.0, rect.size.height+2);
        label.attributedText = attributeStr;
        [baseView addSubview:label];

        [UIView animateWithDuration:0.4 animations:^{
            baseView.alpha = 1.0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 delay:0.9 options:UIViewAnimationOptionCurveLinear animations:^{
                baseView.alpha = 0;
            } completion:^(BOOL finished) {
                [baseView removeFromSuperview];
            }];
        }];
    }
}

//带感叹号图标的弹框
+(void)showAlertMessage:(NSString *)message{
    [TooltipView showMessage:message alertPic:@"弹框提示-惊叹号"];
}

//带图标的弹框
+(void)showMessage:(NSString *)message alertPic:(NSString *)pic{
    if (message.length>0) {
        //文字宽高
        NSAttributedString *attStr = [TooltipView attributedString:message];
        CGRect rect = [attStr boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        //baseView
        UIView *baseView =  [[UIView alloc]initWithFrame:CGRectMake((Screen_W - rect.size.width - viewPix(62))/2, Screen_H/2.0-viewPix(60), rect.size.width+viewPix(62), rect.size.height+viewPix(100))];
        baseView.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.9];
        baseView.layer.cornerRadius = 10.0f;
        baseView.layer.masksToBounds = YES;
        baseView.alpha = 0;
        [[UIApplication sharedApplication].keyWindow addSubview:baseView];
        
        //图标
        UIImageView *iconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:pic]];
        [baseView addSubview:iconView];
        
        //标题
        UILabel *titleLabel = [UILabel lableWithText:message colorString:@"#FFFFFF" textFont:LGFont(14) textAlignment:NSTextAlignmentCenter lines:2];
        titleLabel.attributedText = attStr;
        [baseView addSubview:titleLabel];
        [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(baseView).offset(viewPix(32));
            make.width.height.equalTo(@(viewPix(36)));
            make.centerX.equalTo(baseView);
        }];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(iconView.mas_bottom).offset(viewPix(8));
            make.left.equalTo(baseView).offset(viewPix(30));
            make.right.equalTo(baseView).offset(-viewPix(30));
        }];
        
        [UIView animateWithDuration:0.4 animations:^{
            baseView.alpha = 1.0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 delay:0.9 options:UIViewAnimationOptionCurveLinear animations:^{
                baseView.alpha = 0;
            } completion:^(BOOL finished) {
                [baseView removeFromSuperview];
            }];
        }];
    }
}

//字号：14 、 行间距：3
+(NSAttributedString *)attributedString:(NSString *)content{
    content = (content.length==0)?@" ":content;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    [paragraphStyle setLineSpacing:3];
    NSAttributedString *attributeStr = [[NSAttributedString alloc]initWithString:content attributes:@{NSFontAttributeName:LGFont(14),NSParagraphStyleAttributeName:paragraphStyle}];
    
    return attributeStr;
}


@end
