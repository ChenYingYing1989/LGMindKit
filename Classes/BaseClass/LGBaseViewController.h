//
//  LGBaseViewController.h
//  haoshuimian365
//
//  Created by apple on 2017/6/19.
//  Copyright © 2017年 CYY. All rights reserved.
/*
 基类说明：
  空白页：中间图片+描述内容
 */

#import <UIKit/UIKit.h>
//#import "UINavigationController+FDFullscreenPopGesture.h"
//#import "LGNavigationView.h"
#import "HeaderFile.h"
#import "UIImage+LGExtension.h"
#import "UIColor+LGExtension.h"
#import "NSString+LGExtenison.h"
#import "NSObject+LGExtension.h"
#import "UIView+LGExtension.h"
#import "UILabel+LGExtension.h"
#import "UIButton+LGExtension.h"
#import "NSDictionary+LGExtension.h"
@interface LGBaseViewController : UIViewController <LGEmptyViewDelegate>
/**   */
//@property (nonatomic , strong)LGNavigationView *navigationView;
/**   */
@property (nonatomic , strong)CAGradientLayer *gradientLayer;
/**   */
@property (nonatomic , strong)UIButton *backBtn;

@property (nonatomic , strong)LGEmptyView *emptyView;
/**  用户角色：10-医生  、20-医助  、 100-其他 */
@property (nonatomic , copy)NSString *roleType;
/** 是否首次加载*/
@property (nonatomic , assign) BOOL isfirst;

/**  是否是竖屏 */
@property (nonatomic , assign)BOOL isPortrait;

//返回按钮点击事件
-(void)backButtonAction;

//分栏子控制器--选中显示
-(void)viewWillAppearAction;
//重置导航栏
-(void)resetNavigationTheme;
//创建导航栏
//-(void)navigationViewWithType:(LGNavigationType)type title:(NSString *)title;

/**  创建空白页 */
-(void)emptyViewWithSuperView:(UIView *)superView frame:(CGRect)frame;


@end
