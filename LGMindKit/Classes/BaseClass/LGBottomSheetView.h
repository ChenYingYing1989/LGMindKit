//
//  LGBottomSheetView.h
//  XieHeHeartDisease
//
//  Created by 1234 on 2024/6/20.
//  底部弹框：圆弧背景 、 标题 、 关闭按钮 、 底部按钮

#import <UIKit/UIKit.h>
#import "LGBottomButtonView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LGBottomSheetView : UIView

@property (nonatomic, copy) void(^bottomButtonSelect)(NSInteger index);
/**   */
@property (nonatomic , strong)LGBottomButtonView *buttonView;
/**   */
@property (nonatomic , strong)UIView *baseView;
/**   */
@property (nonatomic , assign)CGFloat baseHeight;

//无底部按钮
-(instancetype)initWithTitle:(NSString *)title baseHeight:(CGFloat)baseHeight;

//有底部按钮
-(instancetype)initWithTitle:(NSString *)title bottomBtn:(NSArray *)btnArray baseHeight:(CGFloat)baseHeight;

-(void)bottomButtonTouchedWithIndex:(NSInteger)index;

-(void)showViewAnimation;

-(void)hiddenViewAnmation;

@end

NS_ASSUME_NONNULL_END
