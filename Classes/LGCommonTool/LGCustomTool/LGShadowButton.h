//
//  LGShadowButton.h
//  HyperactivityPatient
//
//  Created by mac on 2021/3/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGShadowButton : UIButton

/**   */
@property (nonatomic , copy)NSString *shadowColor;
/**   */
@property (nonatomic , strong)NSArray *layerColors;
/**   */
@property (nonatomic , assign)CGFloat radius;

@end

NS_ASSUME_NONNULL_END
