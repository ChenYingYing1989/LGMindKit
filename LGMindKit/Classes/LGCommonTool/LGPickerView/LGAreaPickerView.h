//
//  LGAreaPickerView.h
//  HeartDiseaseManage
//
//  Created by 1234 on 2023/9/22.
//  地区选择器

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LGAreaPickerDelegate <NSObject>

//只有结果数组
-(void)selectPickerViewResult:(NSArray *)resultArray;

@end

@interface LGAreaPickerView : UIView
/**   */
@property (nonatomic , assign)id <LGAreaPickerDelegate> delegate;
/**   */
@property (nonatomic , copy)void (^selectPickViewResult)(NSString *result);
/**   */
@property (nonatomic , strong)UIPickerView *pickView;
/**   */
@property (nonatomic , strong)NSArray *pickArry;
/**  默认选中 */
@property (nonatomic , copy)NSString *selectStr;
/**   */
@property (nonatomic , strong)UILabel *titleLabel;

@end

NS_ASSUME_NONNULL_END
