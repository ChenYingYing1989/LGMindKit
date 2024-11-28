//
//  UIButton+LGExtension.h
//  EducationCollection
//
//  Created by mac on 2021/4/6.
//

#import <UIKit/UIKit.h>
#import "HeaderFile.h"
typedef NS_ENUM(NSUInteger, LGButtonInsetsStyle) {
    LGButtonInsetsStyleTop, // image在上，label在下  需要先设置button的bounds
    LGButtonInsetsStyleLeft, // image在左，label在右
    LGButtonInsetsStyleBottom, // image在下，label在上
    LGButtonInsetsStyleRight // image在右，label在左
};

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (LGExtension)

#pragma mark ====> 老方法 -- willDeprecated
+(instancetype)buttonWithTitle:(NSString *)title titleFont:(UIFont *)titleFont normalColor:(NSString *)normalColor selectColor:(NSString *)selectColor;

+(instancetype)buttonWithTitle:(NSString *)title titleFont:(UIFont *)titleFont normalColor:(NSString *)normalColor selectColor:(NSString *)selectColor normalImage:(NSString *)normalImage selectImage:(NSString *)selectImage;

+(instancetype)buttonWithTitle:(NSString *)title titleFont:(UIFont *)titleFont textColor:(NSString *)textColor  imageName:(NSString *)imageName;

+(instancetype)buttonWithImage:(NSString *)imageName selectImage:(NSString *)selectImage;


#pragma mark ====> 新方法
+(instancetype)buttonWithTitle:(NSString *)title titleFont:(UIFont *)titleFont textColor:(NSString *)textColor frame:(CGRect)frame;

+(instancetype)buttonWithTitle:(NSString *)title titleFont:(UIFont *)titleFont normalColor:(NSString *)normalColor selectColor:(NSString *)selectColor frame:(CGRect)frame;

+(instancetype)buttonWithIcon:(NSString *)imageName title:(NSString *)title titleFont:(UIFont *)titleFont textColor:(NSString *)textColor frame:(CGRect)frame;

+(instancetype)buttonWithImage:(NSString *)imageName frame:(CGRect)frame;

+(instancetype)buttonWithImage:(NSString *)imageName selectImage:(NSString *)selectName frame:(CGRect)frame;

//有背景颜色的按钮
+(instancetype)buttonWithBackColor:(NSString *)backColor cornerRadius:(CGFloat)radius title:(NSString *)title titleFont:(UIFont *)titleFont textColor:(NSString *)textColor  frame:(CGRect)frame;

//背景色+文字+图标
+(instancetype)buttonWithBackColor:(NSString *)backColor cornerRadius:(CGFloat)radius icon:(NSString *)iconName title:(NSString *)title titleFont:(UIFont *)titleFont textColor:(NSString *)textColor frame:(CGRect)frame;

//全屏蓝色按钮
+(instancetype)buttonWithTitle:(NSString *)title topMargin:(CGFloat)topMargin;

//设置选中状态下的值
-(void)setSelectTitle:(NSString *)title  textColor:(NSString *)textColor;
-(void)setSelectTitle:(NSString *)title  backColor:(NSString *)backColor;
-(void)setSelectTextColor:(NSString *)textColor  backColor:(NSString *)backColor;
-(void)setSelectTitle:(NSString *)title  selectImage:(NSString *)selectName;

//BackgroundColor
-(void)setBackgroundColor:(NSString *)normalColor selectColor:(NSString *)selectColor;
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

//设置文字和图片的布局样式及间距
-(void)setButtonInsetsStyle:(LGButtonInsetsStyle)style marginSpace:(CGFloat)space;

//设置文字和图片的布局样式及间距
-(void)setButtonInsetsStyle:(LGButtonInsetsStyle)style marginSpace:(CGFloat)space offset:(CGFloat)offset;

@end

NS_ASSUME_NONNULL_END
