//
//  DatePickerTwoView.m
//  haoshuimiandoctor
//
//  Created by admin  on 2018/10/31.
//  Copyright © 2018 langgan. All rights reserved.
//

#import "DatePickerTwoView.h"

@interface DatePickerTwoView()

@property (nonatomic , strong) UIButton *cancelBtn;
@property (nonatomic , strong) UIButton *finishBtn;

/**---底部带按钮的pickView---*/
@property (nonatomic , strong)UIView *baseView;

/**---选择结果---*/
@property (nonatomic , copy)NSString *resultStr;

@property (nonatomic , strong)UIView *maskView;
/**   */
@property (nonatomic , strong)UILabel *titleLabel;

@end

@implementation DatePickerTwoView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.baseView];
        [self.baseView addSubview:self.datePicker];
        [self.baseView addSubview:self.cancelBtn];
        [self.baseView addSubview:self.finishBtn];
        [self.baseView addSubview:self.titleLabel];
        self.datePicker.frame = CGRectMake(0, viewPix(45), Screen_W, 180);
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
            self.baseView.frame = CGRectMake(0, Screen_H-240, Screen_W, 250);
        }];
    }
    return self;
}

-(void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}

-(void)setCurrentDate:(NSString *)currentDate{
    if (currentDate && currentDate.length>0) {
        NSDateFormatter *fomatter = [[NSDateFormatter alloc]init];
        [fomatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *tempDate = [fomatter dateFromString:currentDate];
        self.datePicker.date = tempDate;
    }else{
        self.datePicker.date = [NSDate date];
    }
}

//- (void)setBeginDate:(NSString *)beginDate{
//    if (beginDate && beginDate.length > 0) {
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateFormat:@"HH:mm"];
//
//        NSDate *minDate = [formatter dateFromString:beginDate];
//        self.datePicker.minimumDate = minDate;
//    }
//}
//
//- (void)setEndDate:(NSString *)endDate{
//    if (endDate && endDate.length >0) {
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateFormat:@"HH:mm"];
//
//        NSDate *maxDate = [formatter dateFromString:endDate];
//        self.datePicker.maximumDate = maxDate;
//    }
//}


-(void)cancelSelect{
    [UIView animateWithDuration:0.3 animations:^{
        self.baseView.frame = CGRectMake(0, Screen_H, Screen_W, 230);
        self.maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    } completion:^(BOOL finished) {
        self.frame = CGRectZero;
        [self.maskView removeFromSuperview];
    }];
}

-(void)selectFinished{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *resultStr = [formatter stringFromDate:_datePicker.date];
    if (self.delegate && [self.delegate respondsToSelector:@selector(sendSelectDate:index:)]) {
        [self.delegate sendSelectDate:resultStr index:self.index];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.baseView.frame = CGRectMake(0, Screen_H, Screen_W, 230);
        self.maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    } completion:^(BOOL finished) {
        self.frame = CGRectZero;
        [self.maskView removeFromSuperview];
    }];
}


#pragma mark
#pragma mark ====> 创建控件
-(UIView *)baseView{
    if (!_baseView) {
        _baseView = [[UIView alloc]initWithFrame:CGRectMake(0, Screen_H, Screen_W, 250)];
        _baseView.backgroundColor = [UIColor whiteColor];
        _baseView.cornerRidus = 15;
    }
    return _baseView;
}



-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithTitle:@"取消" titleFont:LGFontWeight(14, UIFontWeightSemibold) textColor:@"#999999" imageName:@""];
        _cancelBtn.frame = CGRectMake(viewPix(10), viewPix(10), viewPix(58), viewPix(40));
        [_cancelBtn addTarget:self action:@selector(cancelSelect) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [UILabel lableWithText:@"" colorString:@"#333333" textFont:LGFontWeight(16, UIFontWeightSemibold) textAlignment:NSTextAlignmentCenter lines:1];
        _titleLabel.frame = CGRectMake(viewPix(100), viewPix(10), Screen_W-viewPix(200), viewPix(40));
    }
    return _titleLabel;
}

-(UIButton *)finishBtn{
    if (!_finishBtn) {
        _finishBtn = [UIButton buttonWithTitle:@"确定" titleFont:LGFontWeight(14, UIFontWeightSemibold) textColor:kThemeColor imageName:@""];
        _finishBtn.frame = CGRectMake(Screen_W-viewPix(68), viewPix(10), viewPix(58), viewPix(40));
        [_finishBtn addTarget:self action:@selector(selectFinished) forControlEvents:UIControlEventTouchUpInside];
    }
    return _finishBtn;
}

-(UIDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc]init];
        _datePicker.backgroundColor = [UIColor whiteColor];
        if (@available(iOS 13.4, *)) {
            _datePicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
        } else {
            // Fallback on earlier versions
        }
        // 本地化
        _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        
        // 日期控件格式
        _datePicker.datePickerMode = UIDatePickerModeDate;
    }
    return _datePicker;
}

@end
