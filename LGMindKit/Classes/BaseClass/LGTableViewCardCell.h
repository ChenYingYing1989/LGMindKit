//
//  LGShadowViewCell.h
//  BreathTrainingTool
//
//  Created by 1234 on 2024/6/5.
//  边距16 、 带阴影 、 卡片式Cell

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    LGPositionTypeTop,
    LGPositionTypeMiddle,
    LGPositionTypeBottom,
    LGPositionTypeSingle,
} LGPositionType;

@interface LGTableViewCardCell : UITableViewCell
/**   */
@property (nonatomic , weak)UITableView *tableView;
/**   */
@property (nonatomic , strong)NSDictionary *dataDic;
/**   */
@property (nonatomic , strong)UIView *baseView;
/**   */
@property (nonatomic , assign)LGPositionType type;

@end

NS_ASSUME_NONNULL_END
