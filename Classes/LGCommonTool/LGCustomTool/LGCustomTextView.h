//
//  LGTextView.h
//  HeartDiseaseManage
//
//  Created by 1234 on 2023/10/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LGTextViewDelegate <NSObject>

@optional
-(void)textViewHeightChanged:(CGFloat)height;

-(void)textViewValueChanged:(NSString *)content;

-(void)textViewDidEndEditing:(NSString *)content;

@end

@interface LGCustomTextView : UITextView
/**   */
@property (nonatomic , assign)id <LGTextViewDelegate> customDelegate;
/**   */
@property (nonatomic , copy)NSString *placeHolderColor;
/**   */
@property (nonatomic , strong)UIFont *placeHolderFont;
/**   */
@property (nonatomic , copy)NSString *placeHolder;
/**   */
@property (nonatomic , copy)NSString *contentColor;
/**   */
@property (nonatomic , strong)UIFont *contentFont;
/**   */
@property (nonatomic , copy)NSString *content;
/**   */
@property (nonatomic , assign)NSInteger maxCount;
/**   */
@property (nonatomic , assign)CGFloat lineSpace;

//快速创建
+(LGCustomTextView *)textViewWithPlaceHolder:(NSString *)placeHolder  textColor:(NSString *)textColor  textFont:(UIFont *)textFont  textAlignment:(NSTextAlignment)textAlignment  keyboard:(UIKeyboardType)keyboard;

+(LGCustomTextView *)textViewWithPlaceHolder:(NSString *)placeHolder  placeHolderColor:(NSString *)placeHolderColor  placeHolderFont:(UIFont *)placeHolderFont  textColor:(NSString *)textColor   textFont:(UIFont *)textFont  textAlignment:(NSTextAlignment)textAlignment  keyboard:(UIKeyboardType)keyboard;

@end

NS_ASSUME_NONNULL_END
