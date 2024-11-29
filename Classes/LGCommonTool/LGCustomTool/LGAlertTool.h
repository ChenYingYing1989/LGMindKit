//
//  LGAlertTool.h
//  LGSanofiPatient
//
//  Created by 1234 on 2022/10/9.
//  类似于系统的白色弹框 ， 有取消、确定按钮 ， 有标题、内容

#import <Foundation/Foundation.h>
#import "LGBaseView.h"
NS_ASSUME_NONNULL_BEGIN

@interface LGAlertTool : NSObject

+(void)alertWithTitle:(NSString *)title content:(NSString *)content sureAction:(void(^)(void))action;

+(void)alertWithTitle:(NSString *)title content:(NSString *)content sureTitle:(NSString *)sureTitle sureAction:(void(^)(void))action;

+(void)alertWithTitle:(NSString *)title attrbutContent:(NSMutableAttributedString *)content sureAction:(void(^)(void))action;

+(void)alertWithTitle:(NSString *)title sureAction:(void(^)(void))action;

+(void)closeAlertWithTitle:(NSString *)title content:(NSString *)content sureTitle:(NSString *)sureTitle sureAction:(void(^)(void))action;

+(void)singleActionAlertWithTitle:(NSString *)title sureAction:(void(^)(void))action;

+(void)singleActionAlertWithTitle:(NSString *)title attrbutContent:(NSMutableAttributedString *)content sureAction:(void(^)(void))action;

@end


@interface LGAlertView : LGBaseView
/**   */
@property (nonatomic , copy)void(^sureAction)(void);
/**   */
@property (nonatomic , strong)UILabel *titleLabel;
/**   */
@property (nonatomic , strong)UILabel *contentLabel;
/**   */
@property (nonatomic , strong)UIButton *sureBtn;

@end


@interface LGSigleAlertView : UIView
/**   */
@property (nonatomic , copy)void(^sureAction)(void);
/**   */
@property (nonatomic , strong)UILabel *titleLabel;
/**   */
@property (nonatomic , strong)UILabel *contentLabel;

@end

@interface LGCloseAlertView : UIView
/**   */
@property (nonatomic , copy)void(^sureAction)(void);
/**   */
@property (nonatomic , strong)UILabel *titleLabel;
/**   */
@property (nonatomic , strong)UILabel *contentLabel;
/**   */
@property (nonatomic , strong)UIButton *sureBtn;

@end



NS_ASSUME_NONNULL_END
