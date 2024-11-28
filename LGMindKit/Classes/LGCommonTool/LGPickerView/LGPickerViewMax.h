//
//  LGPickerView.h
//  haoshuimian
//
//  Created by apple on 16/8/18.
//  Copyright © 2016年 CYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LGPickerViewDelegate <NSObject>
//只有下标数组
-(void)selectPickerViewIndex:(NSArray *)indexArray;
//只有结果数组
-(void)selectPickerViewResult:(NSArray *)resultArray;
//结果数组+下标数组
-(void)selectPickerIndexResult:(NSArray *)resultArray indexArray:(NSArray *)indexArray;
@end

@interface LGPickerViewMax : UIView
/**   */
@property (nonatomic , assign)id <LGPickerViewDelegate> delegate;
/**   */
@property (nonatomic , copy)void (^selectPickIndexResult)(NSArray *resultArray , NSArray *indexArray);
/**   */
@property (nonatomic , copy)void (^selectPickViewResult)(NSArray *resultArray);
/**   */
@property (nonatomic , copy)void (^selectPickViewIndex)(NSArray *indexArray);
/**   */
@property (nonatomic , strong)UIPickerView *pickView;
/**   */
@property (nonatomic , strong)UIButton *sureBtn;
/**   */
@property (nonatomic , strong)NSArray *pickArry;
/**  默认选中 */
@property (nonatomic , copy)NSString *selectStr;
/**   */
@property (nonatomic , strong)NSArray *units;
/**   */
@property (nonatomic , strong)UILabel *titleLabel;
/**   */
@property (nonatomic , assign)CGFloat unitOffset;

@end
