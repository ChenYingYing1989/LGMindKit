//
//  UIButton+LGExtension.m
//  EducationCollection
//
//  Created by mac on 2021/4/6.
//

#import "UIButton+LGExtension.h"

@implementation UIButton (LGExtension)

#pragma mark
#pragma mark ====> 创建按钮

//纯文字
+(instancetype)buttonWithTitle:(NSString *)title titleFont:(UIFont *)titleFont textColor:(NSString *)textColor frame:(CGRect)frame{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitleColor:[UIColor colorWithHexString:textColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:textColor] forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = titleFont;
    return button;
}

+(instancetype)buttonWithTitle:(NSString *)title titleFont:(UIFont *)titleFont normalColor:(NSString *)normalColor selectColor:(NSString *)selectColor frame:(CGRect)frame{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitleColor:[UIColor colorWithHexString:normalColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:selectColor] forState:UIControlStateSelected];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = titleFont;
    return button;
}

//纯图片
+(instancetype)buttonWithImage:(NSString *)imageName frame:(CGRect)frame{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
    button.frame = frame;
    return button;
}

//只有图片--分normal、select状态
+(instancetype)buttonWithImage:(NSString *)imageName selectImage:(NSString *)selectName frame:(CGRect)frame{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    if (selectName.length>0) {
        [button setImage:[UIImage imageNamed:selectName] forState:UIControlStateSelected];
    }else{
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
    }
    return button;
}

//文字 + 图片
+(instancetype)buttonWithIcon:(NSString *)imageName title:(NSString *)title titleFont:(UIFont *)titleFont textColor:(NSString *)textColor frame:(CGRect)frame{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:textColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:textColor] forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    button.titleLabel.font = titleFont;
    return button;
}



//有背景颜色的按钮
+(instancetype)buttonWithBackColor:(NSString *)backColor cornerRadius:(CGFloat)radius title:(NSString *)title titleFont:(UIFont *)titleFont textColor:(NSString *)textColor  frame:(CGRect)frame{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:textColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:textColor] forState:UIControlStateHighlighted];
    [button setBackgroundColor:[UIColor colorWithHexString:backColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor colorWithHexString:backColor] forState:UIControlStateHighlighted];
    button.titleLabel.font = titleFont;
    button.layer.cornerRadius = radius;
    return button;
}

//背景色+文字+图标 -- 只有normal状态
+(instancetype)buttonWithBackColor:(NSString *)backColor cornerRadius:(CGFloat)radius icon:(NSString *)iconName title:(NSString *)title titleFont:(UIFont *)titleFont textColor:(NSString *)textColor frame:(CGRect)frame{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:textColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:textColor] forState:UIControlStateHighlighted];
    [button setBackgroundColor:[UIColor colorWithHexString:backColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor colorWithHexString:backColor] forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
    button.titleLabel.font = titleFont;
    button.layer.cornerRadius = radius;
    return button;
}

#pragma mark
#pragma mark ====> 老方法
//只有图片--分选中、未选中状态  willDeprecated
+(instancetype)buttonWithImage:(NSString *)imageName selectImage:(NSString *)selectImage{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    if (selectImage.length>0) {
        [button setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
    }else{
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
    }
    return button;
}

//没有选中状态
+(instancetype)buttonWithTitle:(NSString *)title titleFont:(UIFont *)titleFont textColor:(NSString *)textColor  imageName:(NSString *)imageName{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor colorWithHexString:textColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:textColor] forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = titleFont;
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
    return button;
}

//只有文字--分选中、未选中状态
+(instancetype)buttonWithTitle:(NSString *)title titleFont:(UIFont *)titleFont normalColor:(NSString *)normalColor selectColor:(NSString *)selectColor{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor colorWithHexString:normalColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    if (selectColor.length>0) {
        [button setTitleColor:[UIColor colorWithHexString:selectColor] forState:UIControlStateSelected];
    }
    button.titleLabel.font = titleFont;
    return button;
}

+(instancetype)buttonWithTitle:(NSString *)title titleFont:(UIFont *)titleFont normalColor:(NSString *)normalColor selectColor:(NSString *)selectColor normalImage:(NSString *)normalImage selectImage:(NSString *)selectImage{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor colorWithHexString:normalColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    if (selectColor.length>0) {
        [button setTitleColor:[UIColor colorWithHexString:selectColor] forState:UIControlStateSelected];
    }
    if(selectImage.length>0){
        [button setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
    }
    button.titleLabel.font = titleFont;
    return button;
}

//全屏按钮
+(instancetype)buttonWithTitle:(NSString *)title topMargin:(CGFloat)topMargin{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(viewPix(16), topMargin, Screen_W-viewPix(32), viewPix(46));
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor colorWithHexString:kThemeColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor colorWithHexString:kThemeColor] forState:UIControlStateSelected];
    button.titleLabel.font = LGFontWeight(16, UIFontWeightSemibold);
    [button setTitle:title forState:UIControlStateNormal];
    button.cornerRidus = 10;
    return button;
}

#pragma mark
#pragma mark ====> 设置Button的样式


-(void)setSelectTitle:(NSString *)title  selectImage:(NSString *)selectName{
    [self setTitle:title forState:UIControlStateSelected];
    [self setImage:[UIImage imageNamed:selectName] forState:UIControlStateSelected];
}

-(void)setSelectTitle:(NSString *)title  textColor:(NSString *)textColor{
    [self setTitle:title forState:UIControlStateSelected];
    [self setTitleColor:[UIColor colorWithHexString:textColor] forState:UIControlStateSelected];
}
-(void)setSelectTitle:(NSString *)title  backColor:(NSString *)backColor{
    [self setTitle:title forState:UIControlStateSelected];
    [self setBackgroundColor:[UIColor colorWithHexString:backColor] forState:UIControlStateSelected];
}
-(void)setSelectTextColor:(NSString *)textColor  backColor:(NSString *)backColor{
    [self setTitleColor:[UIColor colorWithHexString:textColor] forState:UIControlStateSelected];
    [self setBackgroundColor:[UIColor colorWithHexString:backColor] forState:UIControlStateSelected];
}

//两种状态下的背景颜色
-(void)setBackgroundColor:(NSString *)normalColor selectColor:(NSString *)selectColor{
    [self setBackgroundColor:[UIColor colorWithHexString:normalColor] forState:UIControlStateNormal];
    [self setBackgroundColor:[UIColor colorWithHexString:selectColor] forState:UIControlStateSelected];
}

//设置背景颜色
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [backgroundColor CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self setBackgroundImage:image forState:state];
}



/**
 *如果只有title或者image时，那它上下左右都是相对于button的；
 *如果同时有image和label，那这时候image的上左下是相对于button，右边是相对于label的；title的上右下是相对于button，左边是相对于image的。
 */

-(void)setButtonInsetsStyle:(LGButtonInsetsStyle)style marginSpace:(CGFloat)space{
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith   = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
//    CGFloat labelWidth  = self.titleLabel.frame.size.width;
//    CGFloat labelHeight = self.titleLabel.frame.size.height;
    CGFloat labelWidth  = [self.titleLabel.text textWidthWithFont:self.titleLabel.font maxHeight:self.bounds.size.width];
    CGFloat labelHeight = [self.titleLabel.text textHeightWithFont:self.titleLabel.font maxWidth:self.bounds.size.height];
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    switch (style) {
        case LGButtonInsetsStyleTop:{
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
        }
            break;
        case LGButtonInsetsStyleLeft:{
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case LGButtonInsetsStyleBottom:{
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case LGButtonInsetsStyleRight:{
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        }
            break;
        default:
            break;
    }
    
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}

//目前只对top有用
-(void)setButtonInsetsStyle:(LGButtonInsetsStyle)style marginSpace:(CGFloat)space offset:(CGFloat)offset{
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith   = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    CGFloat labelWidth  = self.titleLabel.frame.size.width;
    CGFloat labelHeight = self.titleLabel.frame.size.height;
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    switch (style) {
        case LGButtonInsetsStyleTop:{
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0+offset, 0, -offset, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(offset, -imageWith, -imageHeight-space/2.0-offset, 0);
        }
            break;
        case LGButtonInsetsStyleLeft:{
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case LGButtonInsetsStyleBottom:{
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case LGButtonInsetsStyleRight:{
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        }
            break;
        default:
            break;
    }
    
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}




@end
