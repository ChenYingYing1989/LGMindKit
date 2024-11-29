//
//  LGHeaderFile.h
//  LGBaseClassTool
//
//  Created by mac on 2021/8/28.
//

#ifndef HeaderFile_h
#define HeaderFile_h

#define BaseUrl                  @"https://www.baidu.com"

#define kUserId                  @""

#define kToken                   @""

/**  取本地图片 */
#define LGImagePath              [[NSBundle mainBundle]pathForResource:@"image" ofType:@"bundle"]
#define LGImageName(imageName)   [LGImagePath stringByAppendingPathComponent:imageName]

#define defaultPatientMan          [UIImage imageNamed:@"默认患者男"]
#define defaultPatientWomen        [UIImage imageNamed:@"默认患者女"]
#define defaultDoctorPic           [UIImage imageNamed:@"默认头像医生"]
#define defaultNursePic            [UIImage imageNamed:@"默认头像护士"]
//空白页
#define LGErrorMessage             @"未请求到数据"
#define LGEmptyPicName             @"emptyView"
#define LGEmptyPicName2            @"emptyView2"
/* 屏幕尺寸 */
#define Screen_W   [UIScreen mainScreen].bounds.size.width
#define Screen_H   [UIScreen mainScreen].bounds.size.height

#define tmpScreenW  MIN(Screen_W, Screen_H)
#define tmpScreenH  MAX(Screen_W, Screen_H)

//判断是否为iPad
#define isPad        NO  //([[UIDevice currentDevice].model isEqualToString:@"iPad"]?YES:NO)

#define LGPercent    (isPad ? (tmpScreenW/768):(tmpScreenW/375.0))   //用于适配iPad

//#define LGPercent   (tmpScreenW/375.0)

#define viewPix(a)  round((a)*LGPercent)

#define LGImageHeight(imageW,percent)  ((imageW)/percent)

/**6
 *iPhoneX系列
 *不带刘海：tmpScreenW/tmpScreenH = 0.56...
 *带刘海：tmpScreenW/tmpScreenH = 0.46...
 */
#define isIPhoneX            ((tmpScreenW/tmpScreenH < 0.5)?YES:NO)
#define bottomSafeBarHeight  (isIPhoneX ? 34 : 0) //底部安全高度
#define iPhoneXMargin(a)     (isIPhoneX ? (a) : 0) //iPhoneX系列单独修改的距离
#define iPhone5sMargin(a)    (Screen_H == 568.0 ? (a) : 0) //5代机
#define iPadMargin(a)        (isPad ? viewPix(a) : 0)



//keyWindow
#define LGKeyWindow           [NSObject mainWindow]

//状态栏高度
#define statusBarHeight        [[UIApplication sharedApplication] statusBarFrame].size.height
#define hiddenStatusBarHeight  (isIPhoneX ? 44 : 20) //状态栏隐藏时statusBarFrame的高度是0，则通过此方法获取

//tabBar高度
#define tabBarHeight   self.tabBarController.tabBar.frame.size.height

//top高度
#define topBarHeight   (((statusBarHeight>0)?statusBarHeight:hiddenStatusBarHeight)+44)

#define kThemeColor           @"#5E8EF5"

//导航栏设置
#define kNavBgColor           [UIColor colorWithHexString:@"#E5F1FF"]
#define kNavBackImage         [UIImage imageNamed:@"navBack"]
#define kNavBackImageWhite    [UIImage imageNamed:@"navBackWhite"]
#define kNavTitleColor        [UIColor colorWithHexString:@"#333333"]
#define kNavTitleColorWhite   [UIColor colorWithHexString:@"#FFFFFF"]
#define kNavShadowColor       [UIColor colorWithHexString:@"#EDF0F0"]
#define kNavTitleFont         [UIFont systemFontOfSize:16 weight:UIFontWeightSemibold]


#define kMaxX(X) CGRectGetMaxX(X)
#define kMaxY(Y) CGRectGetMaxY(Y)
#define kMinX(X) CGRectGetMinX(X)
#define kMinY(Y) CGRectGetMinY(Y)


#define LGNSString(a) [NSString stringWithFormat:@"%@",a]


/* 颜色 */
#define LGStringColor(string)   [UIColor colorWithString:string]
#define RGBAColor(r,g,b,a)      [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define RGBColor(r, g, b)       RGBAColor(r,g,b,1.0)
#define RandomColor             RGBColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


/*  适配文字大小 */
//static inline CGFloat FontSize(CGFloat fontSize){
//    if (tmpScreenW < 375) {
//        return (fontSize-2);
//    }else if (tmpScreenW == 375){
//        return fontSize;
//    }else{
//        return (fontSize+1);
//    }
//}


//#define FontSize(a)                   (isPad ? a+2 : a)
#define FontSize(a)                   (isPad ? a : a)
#define LGFont(a)                     [UIFont systemFontOfSize:FontSize(a)]
#define LGFontWeight(a,UIFontWeight)  [UIFont systemFontOfSize:FontSize(a) weight:UIFontWeight]


#define global_quque    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define main_queue      dispatch_get_main_queue()


/* log输出方法 */
#define LGLogFunction     NSLog(@"%s",__func__)

//#ifdef DEBUG
//#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n", [[[NSString alloc] initWithData:[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] dataUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding] UTF8String]);
//#else
//#define NSLog(...)
//#endif


//打印调试
#if DEBUG
#define NSLog(fmt,...)    NSLog((@"\n%s\n\n" fmt),__PRETTY_FUNCTION__, ##__VA_ARGS__);  /**<输出语句*/
#else
#define NSLog(fmt, ...)
#endif

#endif /* LGHeaderFile_h */
