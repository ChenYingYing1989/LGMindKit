//
//  LGHomeViewController.m
//  LGMindKit
//
//  Created by 1234 on 2024/11/22.
//

#import "LGHomeViewController.h"
#import "LGMindHomeController.h"
@interface LGBaseViewController ()


@end


@implementation LGHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isfirst = YES;
//    [UINavigationBar appearance].shadowImage = [UIImage new];
//    [self.view.layer addSublayer:self.gradientLayer];
    self.title = @"下一页";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F3F7F8"];
    
//    LGBottomButtonView *bottomView = [[LGBottomButtonView alloc]initWithTitle:@"上一页" color:@"#4C87FD" type:LGBottomButtonTypeBack frame:CGRectMake(0, Screen_H-topBarHeight-viewPix(76), Screen_W, viewPix(76))];
//    bottomView.delegate = self;
//    [self.view addSubview:bottomView];
   
//    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage bundleImage:@"navBack"]];
//    imageView.backgroundColor = [UIColor redColor];
//    imageView.frame = CGRectMake(100, 200, 100, 100);
//    [self.view addSubview:imageView];
}

-(void)bottomButtonTouched{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
