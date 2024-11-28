//
//  LGCornerFooterView.h
//  HeartDiseaseManage
//
//  Created by 1234 on 2023/2/16.
//  高度:viewPix(16)+15

#import <UIKit/UIKit.h>
#import "LGBaseView.h"
NS_ASSUME_NONNULL_BEGIN

@interface LGCornerFooterView : LGBaseView
/**   */
@property (nonatomic , strong)UIView *shadowView;
/**   */
@property (nonatomic , assign)CGFloat bottomMargin;

@end

NS_ASSUME_NONNULL_END
