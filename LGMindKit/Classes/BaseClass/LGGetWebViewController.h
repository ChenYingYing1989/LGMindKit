//
//  LGGetWebViewController.h
//  EducationCollection
//
//  Created by mac on 2021/5/8.
//

//#import "LGBaseViewController.h"

#import <LGMindKit/LGBaseViewController.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGGetWebViewController : LGBaseViewController
/**  是否是模态过来的 */
@property (nonatomic , assign)BOOL isPresent;
/**   */
@property (nonatomic , copy)NSString *urlStr;
/**   */
@property (nonatomic , strong)NSDictionary *params;
/**   */
@property (nonatomic , assign)BOOL withAsset;


@end

NS_ASSUME_NONNULL_END
