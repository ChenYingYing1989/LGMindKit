//
//  LGNavigationView.h
//  HyperactivityPatient
//
//  Created by mac on 2021/3/24.
//  导航栏

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    LGNavigationTypeDark,
    LGNavigationTypeWhite,
} LGNavigationType;

@interface LGNavigationView : UIView
/**   */
@property (nonatomic , assign)LGNavigationType type;
/**   */
@property (nonatomic , copy)NSString *title;
/**   */
@property (nonatomic , strong)UILabel *titleLabel;
/**   */
@property (nonatomic , strong)UIButton *backBtn;
/**   */
@property (nonatomic , strong)UIButton *rightBtn;
@end

NS_ASSUME_NONNULL_END
