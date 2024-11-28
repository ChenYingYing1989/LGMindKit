//
//  DatePickerView.h
//  DatePickerStudy
//
//  Created by 张发行 on 16/9/5.
//  Copyright © 2016年 zhangfaxing. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "LGBaseView.h"
@protocol DatePickerViewDelegate <NSObject>

-(void)sendSelectDate:(NSString *)date index:(NSInteger)index;

@end

@interface DatePickerView : LGBaseView

@property (nonatomic , assign) id<DatePickerViewDelegate>delegate;
/**   */
@property (nonatomic , copy)void (^selectDate)(NSString *date);
/**   */
@property (nonatomic , strong)NSDateFormatter *formatter;

@property (nonatomic , strong)UIDatePicker *datePicker;

@property (nonatomic , copy)NSString *currentDate;

@property (nonatomic , copy)NSString *beginDate;

@property (nonatomic , copy)NSString *endDate;
/**   */
@property (nonatomic , copy)NSString *title;

/**  */
@property (nonatomic , assign)NSInteger index;



@end
