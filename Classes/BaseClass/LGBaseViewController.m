//
//  LGBaseViewController.m
//  haoshuimian365
//
//  Created by apple on 2017/6/19.
//  Copyright © 2017年 CYY. All rights reserved.
/*
 基类说明：
 tableView的空白页：中间图片+描述内容
 */

#import "LGBaseViewController.h"


@interface LGBaseViewController ()



@end

@implementation LGBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isfirst = YES;
//    [UINavigationBar appearance].shadowImage = [UIImage new];
//    [self.view.layer addSublayer:self.gradientLayer];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F3F7F8"];
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    if (size.width>size.height) {
        self.isPortrait = NO;
    }else{
        self.isPortrait = YES;
    }
}

-(void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)resetNavigationTheme{
    [UIBarButtonItem appearance].tintColor = kNavTitleColor;
    [[UIBarButtonItem appearance] setTitleTextAttributes:
     @{NSForegroundColorAttributeName:kNavTitleColor,
       NSFontAttributeName:kNavTitleFont} forState:UIControlStateNormal];
    [[UINavigationBar appearance] setTranslucent:NO];
    if (@available(iOS 15.0, *)) {
        //适配iOS15
        UINavigationBarAppearance *naviBar = [UINavigationBarAppearance new];
        naviBar.backgroundColor = kNavBgColor;
        naviBar.backgroundImage = [UIImage imageWithColor:kNavBgColor];
        naviBar.titleTextAttributes = @{NSForegroundColorAttributeName:kNavTitleColor,
                                        NSFontAttributeName:kNavTitleFont};
        naviBar.shadowImage = [UIImage imageWithColor:[UIColor whiteColor]];
        [[UINavigationBar appearance] setScrollEdgeAppearance:naviBar];
        [[UINavigationBar appearance] setStandardAppearance:naviBar];
    }else{
        
        [[UINavigationBar appearance] setBackgroundColor:kNavBgColor];
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:kNavBgColor] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setTitleTextAttributes:
         @{NSForegroundColorAttributeName:kNavTitleColor,
           NSFontAttributeName:kNavTitleFont}];
    }
}

-(UIButton *)backBtn{
    if(!_backBtn){
        _backBtn = [UIButton buttonWithImage:@"navBack" selectImage:@"navBack"];
        _backBtn.frame = CGRectMake(5, statusBarHeight, 44, 44);
        [_backBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

//-(LGNavigationView *)navigationView{
//    if(!_navigationView){
//        _navigationView = [[LGNavigationView alloc]initWithFrame:CGRectMake(0, 0, Screen_W, topBarHeight)];
//        _navigationView.backgroundColor = [UIColor clearColor];
//        [_navigationView.backBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _navigationView;
//}

//-(void)navigationViewWithType:(LGNavigationType)type title:(NSString *)title{
//    self.navigationView.type = type;
//    self.navigationView.title = title;
//    [self.view addSubview:self.navigationView];
//}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    if (self.fd_prefersNavigationBarHidden == YES) {
        self.gradientLayer.frame = CGRectMake(0, topBarHeight, Screen_W, viewPix(167));
    }else{
        self.gradientLayer.frame = CGRectMake(0, 0, Screen_W, viewPix(167));
    }
}

-(CAGradientLayer *)gradientLayer{
    if(!_gradientLayer){
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.frame = CGRectMake(0, 0, Screen_W, viewPix(167));
        _gradientLayer.startPoint = CGPointMake(0.5, 0);
        _gradientLayer.endPoint = CGPointMake(0.5, 1.03);
        _gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:@"#E5F1FF"].CGColor, (__bridge id)[UIColor colorWithHexString:@"#F3F9FE"].CGColor, (__bridge id)[UIColor colorWithHexString:@"#F3F7F8"].CGColor];
        _gradientLayer.locations = @[@(0), @(0.4f), @(1.0f)];
    }
    return _gradientLayer;
}

//创建EmptyView
-(void)emptyViewWithSuperView:(UIView *)superView frame:(CGRect)frame{
    LGEmptyView *emptyView = [[LGEmptyView alloc]initWithFrame:frame];
    emptyView.backgroundColor = [UIColor clearColor];
    emptyView.margin = viewPix(15);
    emptyView.delegate = self;
    emptyView.needBuffer = YES;
    [superView addSubview:emptyView];
    self.emptyView = emptyView;
    [self performSelector:@selector(startBufferAction) withObject:nil afterDelay:0.5];
}

-(void)startBufferAction{
    if (self.isfirst == YES) {
        [self.emptyView startBufferAction];
        self.isfirst = NO;
    }
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}


- (void)dealloc{
    if ([[NSNotificationCenter defaultCenter] respondsToSelector:@selector(addObserver:selector:name:object:)]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
