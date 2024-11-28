//
//  DatePickerView.m
//  DatePickerStudy
//
//  Created by 张发行 on 16/9/5.
//  Copyright © 2016年 zhangfaxing. All rights reserved.
//

#import "DatePickerView.h"

@interface DatePickerView()
/**---底部带按钮的pickView---*/
@property (nonatomic , strong)UIView *baseView;
/**   */
@property (nonatomic , strong)UILabel *titleLabel;
@property (nonatomic , strong)UIButton *closeBtn;
@property (nonatomic , strong)UIButton *sureBtn;

/**---选择结果---*/
@property (nonatomic , copy)NSString *resultStr;

@end

@implementation DatePickerView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.baseView];
        [self.baseView addSubview:self.titleLabel];
        [self.baseView addSubview:self.closeBtn];
        [self.baseView addSubview:self.sureBtn];
        [self.baseView addSubview:self.datePicker];
        self.datePicker.frame = CGRectMake(0, viewPix(50), Screen_W, viewPix(173));
        [self showViewAnimation];
    }
    return self;
}

-(void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}

-(void)setCurrentDate:(NSString *)currentDate{
    if (currentDate && currentDate.length>0) {
        NSDate *tempDate = [self.formatter dateFromString:currentDate];
        self.datePicker.date = tempDate;
    }else{
        self.datePicker.date = [NSDate date];
    }
}

- (void)setBeginDate:(NSString *)beginDate{
    if (beginDate && beginDate.length > 0) {
        NSDate *minDate = [self.formatter dateFromString:beginDate];
        self.datePicker.minimumDate = minDate;
    }
}

- (void)setEndDate:(NSString *)endDate{
    if (endDate && endDate.length >0) {
        NSDate *maxDate = [self.formatter dateFromString:endDate];
        self.datePicker.maximumDate = maxDate;
    }
}

-(void)selectFinished{
    NSString *resultStr = [self.formatter stringFromDate:self.datePicker.date];
    if(self.delegate && [self.delegate respondsToSelector:@selector(sendSelectDate:index:)]){
        [self.delegate sendSelectDate:resultStr index:self.index];
    }
    if(self.selectDate){
        self.selectDate(resultStr);
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.baseView.frame = CGRectMake(0, Screen_H, Screen_W, 230);
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    } completion:^(BOOL finished) {
        self.frame = CGRectZero;
        [self removeFromSuperview];
    }];
}

-(void)showViewAnimation{
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.5];
        self.baseView.frame = CGRectMake(0, Screen_H-viewPix(295), Screen_W, viewPix(310));
    }];
}

-(void)closeViewAnimation{
    [UIView animateWithDuration:0.3 animations:^{
        self.baseView.frame = CGRectMake(0, Screen_H, Screen_W, viewPix(310));
        self.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark
#pragma mark ====> 创建控件
-(NSDateFormatter *)formatter{
    if(!_formatter){
        _formatter = [[NSDateFormatter alloc] init];
        _formatter.dateFormat = @"yyyy-MM-dd";
    }
    return _formatter;
}

-(UIView *)baseView{
    if (!_baseView) {
        _baseView = [[UIView alloc]initWithFrame:CGRectMake(0, Screen_H, Screen_W, viewPix(310))];
        _baseView.backgroundColor = [UIColor whiteColor];
        _baseView.cornerRidus = 15;
    }
    return _baseView;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [UILabel lableWithText:@"" colorString:@"#333333" textFont:LGFontWeight(16, UIFontWeightMedium) textAlignment:NSTextAlignmentCenter lines:1];
        _titleLabel.frame = CGRectMake(viewPix(46), viewPix(13), Screen_W-viewPix(92), viewPix(36));
    }
    return _titleLabel;
}

-(UIDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, viewPix(40), Screen_W, viewPix(173))];
        _datePicker.backgroundColor = [UIColor whiteColor];
        if (@available(iOS 13.4, *)) {
            _datePicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
        } else {
            // Fallback on earlier versions
        }
        // 本地化
        _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
        // 日期控件格式
        _datePicker.datePickerMode = UIDatePickerModeDate;
    }
    return _datePicker;
}

-(UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithImage:@"closeGray16" selectImage:@"closeGray16"];
        _closeBtn.frame = CGRectMake(Screen_W-viewPix(46), viewPix(13), viewPix(36), viewPix(36));
        [_closeBtn addTarget:self action:@selector(closeViewAnimation) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

-(UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithTitle:@"确定" topMargin:viewPix(230)];
        [_sureBtn addTarget:self action:@selector(selectFinished) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}



@end
