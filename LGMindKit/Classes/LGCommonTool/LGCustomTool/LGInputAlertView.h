//
//  LGGroupInputNameView.h
//  HeartDiseaseManage
//
//  Created by 1234 on 2023/2/24.
//  填写分组名称

#import <UIKit/UIKit.h>
#import "LGBaseView.h"
NS_ASSUME_NONNULL_BEGIN

@interface LGInputAlertView : LGBaseView
/**   */
@property (nonatomic , copy)void (^groupNameFinished)(NSString *content);
/**   */
@property (nonatomic , copy)NSString *title;
/**   */
@property (nonatomic , copy)NSString *placeHolder;
/**  单位 */
@property (nonatomic , copy)NSString *unit;
/**   */
@property (nonatomic , assign)UIKeyboardType keyboardType;

@end

NS_ASSUME_NONNULL_END
