//
//  LGDottedLineView.h
//  HeartDiseaseManage
//
//  Created by 1234 on 2023/3/4.
//  虚线

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGDottedLineView : UIView

/**   */
@property (nonatomic , copy)NSString *lineColor;
/**   horizonta、vertical */
@property (nonatomic , copy)NSString *lineDirection;

@end

NS_ASSUME_NONNULL_END
