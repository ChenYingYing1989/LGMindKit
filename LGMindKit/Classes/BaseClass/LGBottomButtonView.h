//
//  LGBottomButtonView.h
//  XieHeHeartDisease
//
//  Created by 1234 on 2024/6/20.
//  底部ButtonView

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    LGBottomButtonTypeBack,
    LGBottomButtonTypeBolder,
}  LGBottomButtonType;

@protocol LGBottomButtonDelegate <NSObject>

@optional

-(void)bottomButtonTouchedWithTitle:(NSString *)title;

-(void)bottomButtonTouchedWithIndex:(NSInteger)index;

//只有一个的情况下
-(void)bottomButtonTouched;

@end



@interface LGBottomButtonView : UIView

/**   */
@property (nonatomic , assign)id <LGBottomButtonDelegate> delegate;
/**  按钮的间距:默认 viewPix(8) 
     若要修改 ， 则在itemArray之前设置
 */
@property (nonatomic , assign)CGFloat margin;
/**   */
@property (nonatomic , assign)CGFloat buttonH;
/**  [{"title" 、"color" 、"type"}]  */
@property (nonatomic , strong)NSArray *itemArray; //最多3个按钮
/**   */
@property (nonatomic , assign)CGFloat radius;

//多个按钮
-(instancetype)initWithItemArray:(NSArray *)itemArray frame:(CGRect)frame;

-(instancetype)initWithTitle:(NSString *)title color:(NSString *)color type:(LGBottomButtonType)type frame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
