//
//  UILabel+LGExtension.m
//  jiangxiaoyu
//
//  Created by apple on 17/3/27.
//  Copyright © 2017年 CYY. All rights reserved.
//

#import "UILabel+LGExtension.h"

@implementation UILabel (LGExtension)
+(instancetype)lableWithText:(NSString *)text colorString:(NSString *)color  textFont:(UIFont *)textFont textAlignment:(NSTextAlignment)textAlignment  lines:(CGFloat)lines{
    UILabel *label = [[UILabel alloc]init];
    label.textColor = [UIColor colorWithHexString:color];
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    label.textAlignment = textAlignment;
    label.numberOfLines = lines;
    label.font = textFont;
    label.text = text;
    return label;
}

-(void)lineSpacing:(CGFloat)spacing{
    if (self.text.length>0 && spacing>0) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = self.lineBreakMode;
        paragraphStyle.alignment = self.textAlignment;
        [paragraphStyle setLineSpacing:spacing];
        [attributedString setAttributes:@{NSFontAttributeName:self.font,NSParagraphStyleAttributeName:paragraphStyle} range:NSMakeRange(0, [self.text length])];
        [self setAttributedText:attributedString];
    }
}


-(void)lineSpacing2:(CGFloat)spacing{
    if (self.text.length>0 && spacing>0) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
        if(self.attributedText){
            attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        }
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = self.lineBreakMode;
        paragraphStyle.alignment = self.textAlignment;
        [paragraphStyle setLineSpacing:spacing];
        [attributedString addAttributes:@{NSParagraphStyleAttributeName:paragraphStyle} range:NSMakeRange(0, [self.text length])];
//        [attributedString setAttributes:@{NSFontAttributeName:self.font,NSParagraphStyleAttributeName:paragraphStyle} range:NSMakeRange(0, [self.text length])];
        [self setAttributedText:attributedString];
    }
}

-(void)wordSpacing:(CGFloat)spacing{
    if (self.text.length>0 && spacing>0) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
        [attributedString addAttribute:NSKernAttributeName value:@(spacing) range:NSMakeRange(0, self.text.length)];
        [self setAttributedText:attributedString];
    }
}

-(void)addMidleSegmentLine{
    if (self.text.length>0) {
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:self.text];
        if (self.attributedText) {
            attString = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
        }
        [attString setAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlinePatternSolid|NSUnderlineStyleSingle)} range:NSMakeRange(0, [self.text length])];
        [self setAttributedText:attString];
    }
}


@end
