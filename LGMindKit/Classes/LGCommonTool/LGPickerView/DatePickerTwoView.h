//
//  DatePickerTwoView.h
//  haoshuimiandoctor
//
//  Created by admin  on 2018/10/31.
//  Copyright © 2018 langgan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol DatePickerViewDelegate <NSObject>

-(void)sendSelectDate:(NSString *)date index:(NSInteger)index;

@end

@interface DatePickerTwoView : UIView

@property (nonatomic , assign) id<DatePickerViewDelegate>delegate;

@property (nonatomic,strong) UIDatePicker *datePicker;

@property (nonatomic, copy) NSString *currentDate;
//
//@property (nonatomic, copy) NSString *beginDate;
//
//@property (nonatomic, copy) NSString *endDate;
/**   */
@property (nonatomic , copy)NSString *title;
/**  */
@property (nonatomic , assign) NSInteger index;


@end

NS_ASSUME_NONNULL_END
