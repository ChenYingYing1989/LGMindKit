//
//  LGTextView.m
//  HeartDiseaseManage
//
//  Created by 1234 on 2023/10/13.
//

#import "LGCustomTextView.h"
#import "NSString+LGExtenison.h"
#import "UIColor+LGExtension.h"
#import "UIView+LGExtension.h"
#import "HeaderFile.h"

@implementation LGCustomTextView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.lineSpace = 3;
        self.maxCount = 10000000;
        self.contentColor = @"#333333";
        self.placeHolderFont = LGFont(14);
        self.placeHolderColor = @"#999999";
        self.placeHolder = (_placeHolder && _placeHolder.length>0)?_placeHolder:@"请输入...";
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textValueChanged) name:UITextViewTextDidChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewBeginEditing) name:UITextViewTextDidBeginEditingNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewEndEditing) name:UITextViewTextDidEndEditingNotification object:nil];
    }
    return self;
}

-(void)setContent:(NSString *)content{
    _content = content;
    if(content.length == 0 || [content isEqualToString:self.placeHolder]){
        self.attributedText = [self.placeHolder attributeString:@{NSFontAttributeName:self.placeHolderFont,NSForegroundColorAttributeName:[UIColor colorWithHexString:self.placeHolderColor]} alignment:self.textAlignment lineSpacing:self.lineSpace];
    }else{
     
        self.attributedText = [content attributeString:@{NSFontAttributeName:self.contentFont,NSForegroundColorAttributeName:[UIColor colorWithHexString:self.contentColor]} alignment:self.textAlignment lineSpacing:self.lineSpace];
    }
    CGFloat textHeight = [self sizeThatFits:CGSizeMake(self.size.width, MAXFLOAT)].height;
    if(self.customDelegate && [self.customDelegate respondsToSelector:@selector(textViewHeightChanged:)]){
        [self.customDelegate textViewHeightChanged:textHeight];
    }
}

//开始编辑
- (void)textViewBeginEditing{
    self.textColor = [UIColor colorWithHexString:self.contentColor];
    if([self.text isEqualToString:self.placeHolder]){
        self.text = @"";
    }
}

//结束编辑
-(void)textViewEndEditing{
    self.content = self.text;
    [self setContentOffset:CGPointMake(0, 0)];
    NSString *result = [self.text isEqualToString:self.placeHolder]?@"":self.text;
    if(self.customDelegate && [self.customDelegate respondsToSelector:@selector(textViewDidEndEditing:)]){
        [self.customDelegate textViewDidEndEditing:result];
    }
}

//文字输入
-(void)textValueChanged{
    NSString *lang = self.textInputMode.primaryLanguage; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]){
        UITextRange *selectedRange = [self markedTextRange];
        if (!selectedRange) { // 没有高亮
            [self handleTextContent:self.text];
        }
    }else{
        [self handleTextContent:self.text];
    }
}

//内容处理
-(void)handleTextContent:(NSString *)content{
    content = (content.length>self.maxCount)?[content substringToIndex:self.maxCount]:content;
    if(content.length>0){
        self.attributedText = [content attributeString:@{NSFontAttributeName:self.contentFont,NSForegroundColorAttributeName:self.textColor} alignment:self.textAlignment lineSpacing:self.lineSpace];
    }
    CGFloat textHeight = [self sizeThatFits:CGSizeMake(self.size.width, MAXFLOAT)].height;
    if(self.customDelegate && [self.customDelegate respondsToSelector:@selector(textViewHeightChanged:)]){
        [self.customDelegate textViewHeightChanged:textHeight];
    }
    if(self.customDelegate && [self.customDelegate respondsToSelector:@selector(textViewValueChanged:)]){
        [self.customDelegate textViewValueChanged:content];
    }
}



-(void)setPlaceHolderColor:(NSString *)placeHolderColor{
    _placeHolderColor = placeHolderColor;
}

-(void)setPlaceHolderFont:(UIFont *)placeHolderFont{
    _placeHolderFont = placeHolderFont;
}

-(void)setPlaceHolder:(NSString *)placeHolder{
    _placeHolder = placeHolder;
}

-(void)setContentColor:(NSString *)contentColor{
    _contentColor = contentColor;
    self.textColor = [UIColor colorWithHexString:contentColor];
}

-(void)setContentFont:(UIFont *)contentFont{
    _contentFont = contentFont;
    self.font = contentFont;
}

-(void)setLineSpace:(CGFloat)lineSpace{
    _lineSpace = lineSpace;
}

-(void)setMaxCount:(NSInteger)maxCount{
    _maxCount = maxCount;
}

+(LGCustomTextView *)textViewWithPlaceHolder:(NSString *)placeHolder  textColor:(NSString *)textColor  textFont:(UIFont *)textFont  textAlignment:(NSTextAlignment)textAlignment  keyboard:(UIKeyboardType)keyboard{
    LGCustomTextView *textView = [[LGCustomTextView alloc]init];
    textView.tintColor = [UIColor colorWithHexString:textColor];
    textView.placeHolderFont = textFont;
    textView.placeHolder = placeHolder;
    textView.contentFont = textFont;
    textView.contentColor = textColor;
    textView.textAlignment = textAlignment;
    textView.keyboardType = keyboard;
    textView.content = @"";
    return textView;
}

+(LGCustomTextView *)textViewWithPlaceHolder:(NSString *)placeHolder  placeHolderColor:(NSString *)placeHolderColor  placeHolderFont:(UIFont *)placeHolderFont  textColor:(NSString *)textColor   textFont:(UIFont *)textFont  textAlignment:(NSTextAlignment)textAlignment  keyboard:(UIKeyboardType)keyboard{
    LGCustomTextView *textView = [[LGCustomTextView alloc]init];
    textView.tintColor = [UIColor colorWithHexString:textColor];
    textView.placeHolderColor = placeHolderColor;
    textView.placeHolderFont = placeHolderFont;
    textView.placeHolder = placeHolder;
    textView.contentFont = textFont;
    textView.contentColor = textColor;
    textView.textAlignment = textAlignment;
    textView.keyboardType = keyboard;
    textView.content = @"";
    return textView;
}

@end
