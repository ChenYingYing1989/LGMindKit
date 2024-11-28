//
//  LGNavigationController.m
//  Yoyou
//
//  Created by Remmo on 15/9/22.
//  Copyright © 2015年 bocweb. All rights reserved.
//

#import "LGNavigationController.h"
#import <FDFullscreenPopGesture/UINavigationController+FDFullscreenPopGesture.h>

#import "LGMindHomeController.h"

@interface LGNavigationController ()

@end

@implementation LGNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_fullscreenPopGestureRecognizer.enabled = NO;
}

-(instancetype)init{
    self = [super initWithRootViewController:[[LGMindHomeController alloc] init]];
    [UIBarButtonItem appearance].tintColor = kNavTitleColor;
    [[UIBarButtonItem appearance] setTitleTextAttributes:
     @{NSForegroundColorAttributeName:kNavTitleColor,
       NSFontAttributeName:kNavTitleFont} forState:UIControlStateNormal];
    [[UINavigationBar appearance] setTranslucent:NO];
    if (@available(iOS 15.0, *)) {
        //适配iOS15
        UINavigationBarAppearance *naviBar = [UINavigationBarAppearance new];
        naviBar.backgroundImage = [UIImage imageWithColor:kNavBgColor];
        naviBar.titleTextAttributes = @{NSForegroundColorAttributeName:kNavTitleColor,
                                        NSFontAttributeName:kNavTitleFont};
        naviBar.shadowImage = [UIImage imageWithColor:kNavBgColor];
        [[UINavigationBar appearance] setScrollEdgeAppearance:naviBar];
        [[UINavigationBar appearance] setStandardAppearance:naviBar];
    }else{
        
        [[UINavigationBar appearance] setBackgroundColor:kNavBgColor];
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:kNavBgColor] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setTitleTextAttributes:
         @{NSForegroundColorAttributeName:kNavTitleColor,
           NSFontAttributeName:kNavTitleFont}];
        [UINavigationBar appearance].shadowImage = [UIImage new];
    }
    return self;
}



//设置返回按钮
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = CGRectMake(0, 0, 44, 44);
        [leftBtn setImage:kNavBackImage forState:UIControlStateNormal];
        [leftBtn setImage:kNavBackImage forState:UIControlStateHighlighted];
        leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [leftBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

-(void)backBtnAction{
    if (self.viewControllers.count>0) {
        //有自控制器则pop
        [self popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (BOOL)shouldAutorotate{
    return self.topViewController.shouldAutorotate;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [self.topViewController supportedInterfaceOrientations];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}



@end
